package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.MedicalRecord;
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
 * Data Access Object for Clinical Medical Records.
 */
public class MedicalRecordDAO {

    private static final Logger LOGGER = Logger.getLogger(MedicalRecordDAO.class.getName());

    public int createRecord(MedicalRecord record) {
        String sql = "INSERT INTO medical_records (patient_id, doctor_id, appointment_id, symptoms, diagnosis, treatment, notes, follow_up_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, record.getPatientId());
            ps.setInt(2, record.getDoctorId());
            if (record.getAppointmentId() != null) {
                ps.setInt(3, record.getAppointmentId());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            ps.setString(4, record.getSymptoms());
            ps.setString(5, record.getDiagnosis());
            ps.setString(6, record.getTreatment());
            ps.setString(7, record.getNotes());
            if (record.getFollowUpDate() != null) {
                ps.setDate(8, record.getFollowUpDate());
            } else {
                ps.setNull(8, Types.DATE);
            }

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    record.setRecordId(rs.getInt(1));
                    return record.getRecordId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating medical record", e);
            throw new DatabaseException("Failed to save medical record.", e);
        }
        return 0;
    }

    public MedicalRecord getRecordById(int recordId) {
        String sql = baseRecordQuery() + " WHERE mr.record_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, recordId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRecord(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching record ID: " + recordId, e);
            throw new DatabaseException("Failed to fetch medical record.", e);
        }
        return null;
    }

    public List<MedicalRecord> getRecordsByPatient(int patientId) {
        List<MedicalRecord> list = new ArrayList<>();
        String sql = baseRecordQuery() + " WHERE mr.patient_id = ? ORDER BY mr.record_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRecord(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching records for patient ID: " + patientId, e);
            throw new DatabaseException("Failed to fetch patient medical records.", e);
        }
        return list;
    }

    public List<MedicalRecord> getRecordsByDoctor(int doctorId) {
        List<MedicalRecord> list = new ArrayList<>();
        String sql = baseRecordQuery() + " WHERE mr.doctor_id = ? ORDER BY mr.record_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRecord(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching records for doctor ID: " + doctorId, e);
            throw new DatabaseException("Failed to fetch doctor medical records.", e);
        }
        return list;
    }

    private String baseRecordQuery() {
        return "SELECT mr.record_id, mr.patient_id, up.full_name AS patient_name, " +
               "mr.doctor_id, ud.full_name AS doctor_name, mr.appointment_id, " +
               "mr.record_date, mr.symptoms, mr.diagnosis, mr.treatment, mr.notes, mr.follow_up_date, mr.created_at " +
               "FROM medical_records mr " +
               "JOIN patients p ON mr.patient_id = p.patient_id " +
               "JOIN users up ON p.user_id = up.user_id " +
               "JOIN doctors d ON mr.doctor_id = d.doctor_id " +
               "JOIN users ud ON d.user_id = ud.user_id ";
    }

    private MedicalRecord mapRecord(ResultSet rs) throws SQLException {
        MedicalRecord mr = new MedicalRecord();
        mr.setRecordId(rs.getInt("record_id"));
        mr.setPatientId(rs.getInt("patient_id"));
        mr.setPatientName(rs.getString("patient_name"));
        mr.setDoctorId(rs.getInt("doctor_id"));
        mr.setDoctorName(rs.getString("doctor_name"));
        int apptId = rs.getInt("appointment_id");
        if (!rs.wasNull()) {
            mr.setAppointmentId(apptId);
        }
        mr.setRecordDate(rs.getTimestamp("record_date"));
        mr.setSymptoms(rs.getString("symptoms"));
        mr.setDiagnosis(rs.getString("diagnosis"));
        mr.setTreatment(rs.getString("treatment"));
        mr.setNotes(rs.getString("notes"));
        mr.setFollowUpDate(rs.getDate("follow_up_date"));
        mr.setCreatedAt(rs.getTimestamp("created_at"));
        return mr;
    }
}
