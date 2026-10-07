package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Nurse;
import com.smarthospital.model.PatientVital;
import com.smarthospital.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Nurse profiles and physiological patient vitals telemetry.
 */
public class VitalDAO {

    private static final Logger LOGGER = Logger.getLogger(VitalDAO.class.getName());

    public int recordVitals(PatientVital vital) {
        String sql = "INSERT INTO patient_vitals (patient_id, nurse_id, temperature, blood_pressure, pulse, oxygen_level, notes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, vital.getPatientId());
            ps.setInt(2, vital.getNurseId());
            ps.setBigDecimal(3, vital.getTemperature());
            ps.setString(4, vital.getBloodPressure());
            ps.setInt(5, vital.getPulse());
            ps.setInt(6, vital.getOxygenLevel());
            ps.setString(7, vital.getNotes());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    vital.setVitalId(rs.getInt(1));
                    return vital.getVitalId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error recording patient vitals", e);
            throw new DatabaseException("Failed to record vitals.", e);
        }
        return 0;
    }

    public List<PatientVital> getVitalsByPatient(int patientId) {
        List<PatientVital> list = new ArrayList<>();
        String sql = "SELECT pv.vital_id, pv.patient_id, up.full_name AS patient_name, " +
                     "pv.nurse_id, un.full_name AS nurse_name, pv.recorded_at, " +
                     "pv.temperature, pv.blood_pressure, pv.pulse, pv.oxygen_level, pv.notes " +
                     "FROM patient_vitals pv " +
                     "JOIN patients p ON pv.patient_id = p.patient_id " +
                     "JOIN users up ON p.user_id = up.user_id " +
                     "JOIN nurses n ON pv.nurse_id = n.nurse_id " +
                     "JOIN users un ON n.user_id = un.user_id " +
                     "WHERE pv.patient_id = ? ORDER BY pv.recorded_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PatientVital v = new PatientVital();
                    v.setVitalId(rs.getInt("vital_id"));
                    v.setPatientId(rs.getInt("patient_id"));
                    v.setPatientName(rs.getString("patient_name"));
                    v.setNurseId(rs.getInt("nurse_id"));
                    v.setNurseName(rs.getString("nurse_name"));
                    v.setRecordedAt(rs.getTimestamp("recorded_at"));
                    v.setTemperature(rs.getBigDecimal("temperature"));
                    v.setBloodPressure(rs.getString("blood_pressure"));
                    v.setPulse(rs.getInt("pulse"));
                    v.setOxygenLevel(rs.getInt("oxygen_level"));
                    v.setNotes(rs.getString("notes"));
                    list.add(v);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching vitals for patient ID: " + patientId, e);
            throw new DatabaseException("Failed to fetch patient vitals.", e);
        }
        return list;
    }

    public Nurse getNurseByUserId(int userId) {
        String sql = "SELECT n.nurse_id, n.user_id, u.full_name AS nurse_name, u.email, u.phone, u.status, " +
                     "n.department_id, dept.name AS department_name, n.qualification, n.shift, n.created_at " +
                     "FROM nurses n " +
                     "JOIN users u ON n.user_id = u.user_id " +
                     "LEFT JOIN departments dept ON n.department_id = dept.department_id " +
                     "WHERE n.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Nurse n = new Nurse();
                    n.setNurseId(rs.getInt("nurse_id"));
                    n.setUserId(rs.getInt("user_id"));
                    n.setNurseName(rs.getString("nurse_name"));
                    n.setEmail(rs.getString("email"));
                    n.setPhone(rs.getString("phone"));
                    n.setStatus(rs.getString("status"));
                    int dId = rs.getInt("department_id");
                    if (!rs.wasNull()) {
                        n.setDepartmentId(dId);
                    }
                    n.setDepartmentName(rs.getString("department_name"));
                    n.setQualification(rs.getString("qualification"));
                    n.setShift(rs.getString("shift"));
                    n.setCreatedAt(rs.getTimestamp("created_at"));
                    return n;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching nurse by user ID: " + userId, e);
            throw new DatabaseException("Failed to fetch nurse details.", e);
        }
        return null;
    }

    public List<Nurse> getAllNurses() {
        List<Nurse> list = new ArrayList<>();
        String sql = "SELECT n.nurse_id, n.user_id, u.full_name AS nurse_name, u.email, u.phone, u.status, " +
                     "n.department_id, dept.name AS department_name, n.qualification, n.shift, n.created_at " +
                     "FROM nurses n " +
                     "JOIN users u ON n.user_id = u.user_id " +
                     "LEFT JOIN departments dept ON n.department_id = dept.department_id " +
                     "ORDER BY n.nurse_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Nurse n = new Nurse();
                n.setNurseId(rs.getInt("nurse_id"));
                n.setUserId(rs.getInt("user_id"));
                n.setNurseName(rs.getString("nurse_name"));
                n.setEmail(rs.getString("email"));
                n.setPhone(rs.getString("phone"));
                n.setStatus(rs.getString("status"));
                int dId = rs.getInt("department_id");
                if (!rs.wasNull()) {
                    n.setDepartmentId(dId);
                }
                n.setDepartmentName(rs.getString("department_name"));
                n.setQualification(rs.getString("qualification"));
                n.setShift(rs.getString("shift"));
                n.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(n);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all nurses", e);
            throw new DatabaseException("Failed to fetch nurses.", e);
        }
        return list;
    }

    /**
     * Atomically creates both user account and nurse profile inside a transaction.
     */
    public boolean createNurseWithUser(Nurse nurse, com.smarthospital.model.User user) {
        String insertUserSql = "INSERT INTO users (role_id, full_name, email, password_hash, phone, status) VALUES (4, ?, ?, ?, ?, 'ACTIVE')";
        String insertNurseSql = "INSERT INTO nurses (user_id, department_id, qualification, shift) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int userId;
            try (PreparedStatement psUser = conn.prepareStatement(insertUserSql, Statement.RETURN_GENERATED_KEYS)) {
                psUser.setString(1, user.getFullName());
                psUser.setString(2, user.getEmail().trim().toLowerCase());
                psUser.setString(3, user.getPasswordHash());
                psUser.setString(4, user.getPhone());
                psUser.executeUpdate();

                try (ResultSet rs = psUser.getGeneratedKeys()) {
                    if (rs.next()) {
                        userId = rs.getInt(1);
                    } else {
                        conn.rollback();
                        return false;
                    }
                }
            }

            try (PreparedStatement psNurse = conn.prepareStatement(insertNurseSql, Statement.RETURN_GENERATED_KEYS)) {
                psNurse.setInt(1, userId);
                if (nurse.getDepartmentId() != null && nurse.getDepartmentId() > 0) {
                    psNurse.setInt(2, nurse.getDepartmentId());
                } else {
                    psNurse.setNull(2, java.sql.Types.INTEGER);
                }
                psNurse.setString(3, nurse.getQualification() != null ? nurse.getQualification() : "Registered Nurse (RN)");
                psNurse.setString(4, nurse.getShift() != null ? nurse.getShift() : "MORNING");
                psNurse.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error creating nurse account: " + user.getEmail(), e);
            throw new DatabaseException("Failed to register nurse account.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }
}
