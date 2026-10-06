package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Admission;
import com.smarthospital.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for In-Patient Admissions and Hospitalization tracking.
 */
public class AdmissionDAO {

    private static final Logger LOGGER = Logger.getLogger(AdmissionDAO.class.getName());

    /**
     * Atomically creates admission record and marks room as OCCUPIED.
     */
    public boolean admitPatient(Admission admission) {
        String insertSql = "INSERT INTO admissions (patient_id, doctor_id, room_id, expected_discharge, reason, status) " +
                           "VALUES (?, ?, ?, ?, ?, 'ADMITTED')";
        String updateRoomSql = "UPDATE rooms SET status = 'OCCUPIED' WHERE room_id = ?";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, admission.getPatientId());
                ps.setInt(2, admission.getDoctorId());
                ps.setInt(3, admission.getRoomId());
                if (admission.getExpectedDischarge() != null) {
                    ps.setDate(4, admission.getExpectedDischarge());
                } else {
                    ps.setNull(4, Types.DATE);
                }
                ps.setString(5, admission.getReason());
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        admission.setAdmissionId(rs.getInt(1));
                    }
                }
            }

            try (PreparedStatement psRoom = conn.prepareStatement(updateRoomSql)) {
                psRoom.setInt(1, admission.getRoomId());
                psRoom.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error admitting patient", e);
            throw new DatabaseException("Failed to admit patient.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }

    /**
     * Atomically discharges patient: sets discharge_date, status = DISCHARGED, summary, and marks room as AVAILABLE.
     */
    public boolean dischargePatient(int admissionId, int roomId, String dischargeSummary) {
        String dischargeSql = "UPDATE admissions SET discharge_date = CURRENT_TIMESTAMP, status = 'DISCHARGED', " +
                              "discharge_summary = ? WHERE admission_id = ?";
        String updateRoomSql = "UPDATE rooms SET status = 'AVAILABLE' WHERE room_id = ?";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(dischargeSql)) {
                ps.setString(1, dischargeSummary);
                ps.setInt(2, admissionId);
                ps.executeUpdate();
            }

            try (PreparedStatement psRoom = conn.prepareStatement(updateRoomSql)) {
                psRoom.setInt(1, roomId);
                psRoom.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error discharging patient from admission ID: " + admissionId, e);
            throw new DatabaseException("Failed to discharge patient.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }

    public List<Admission> getActiveAdmissions() {
        List<Admission> list = new ArrayList<>();
        String sql = baseAdmissionQuery() + " WHERE adm.status = 'ADMITTED' ORDER BY adm.admission_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapAdmission(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching active admissions", e);
            throw new DatabaseException("Failed to fetch active admissions.", e);
        }
        return list;
    }

    public List<Admission> getAllAdmissions() {
        List<Admission> list = new ArrayList<>();
        String sql = baseAdmissionQuery() + " ORDER BY adm.admission_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapAdmission(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all admissions", e);
            throw new DatabaseException("Failed to fetch admissions.", e);
        }
        return list;
    }

    public List<Admission> getAdmissionsByPatient(int patientId) {
        List<Admission> list = new ArrayList<>();
        String sql = baseAdmissionQuery() + " WHERE adm.patient_id = ? ORDER BY adm.admission_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapAdmission(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching admissions for patient ID: " + patientId, e);
            throw new DatabaseException("Failed to fetch patient admissions.", e);
        }
        return list;
    }

    private String baseAdmissionQuery() {
        return "SELECT adm.admission_id, adm.patient_id, up.full_name AS patient_name, " +
               "adm.doctor_id, ud.full_name AS doctor_name, " +
               "adm.room_id, r.room_number, r.room_type, r.charges_per_day, " +
               "adm.admission_date, adm.expected_discharge, adm.discharge_date, " +
               "adm.reason, adm.status, adm.discharge_summary, adm.created_at " +
               "FROM admissions adm " +
               "JOIN patients p ON adm.patient_id = p.patient_id " +
               "JOIN users up ON p.user_id = up.user_id " +
               "JOIN doctors d ON adm.doctor_id = d.doctor_id " +
               "JOIN users ud ON d.user_id = ud.user_id " +
               "JOIN rooms r ON adm.room_id = r.room_id ";
    }

    private Admission mapAdmission(ResultSet rs) throws SQLException {
        Admission adm = new Admission();
        adm.setAdmissionId(rs.getInt("admission_id"));
        adm.setPatientId(rs.getInt("patient_id"));
        adm.setPatientName(rs.getString("patient_name"));
        adm.setDoctorId(rs.getInt("doctor_id"));
        adm.setDoctorName(rs.getString("doctor_name"));
        adm.setRoomId(rs.getInt("room_id"));
        adm.setRoomNumber(rs.getString("room_number"));
        adm.setRoomType(rs.getString("room_type"));
        adm.setChargesPerDay(rs.getBigDecimal("charges_per_day"));
        adm.setAdmissionDate(rs.getTimestamp("admission_date"));
        adm.setExpectedDischarge(rs.getDate("expected_discharge"));
        adm.setDischargeDate(rs.getTimestamp("discharge_date"));
        adm.setReason(rs.getString("reason"));
        adm.setStatus(rs.getString("status"));
        adm.setDischargeSummary(rs.getString("discharge_summary"));
        adm.setCreatedAt(rs.getTimestamp("created_at"));
        return adm;
    }
}
