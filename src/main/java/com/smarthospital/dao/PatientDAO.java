package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Patient;
import com.smarthospital.model.User;
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
 * Data Access Object for Patient registration, profile, and demographics.
 */
public class PatientDAO {

    private static final Logger LOGGER = Logger.getLogger(PatientDAO.class.getName());

    public List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT p.patient_id, p.user_id, u.full_name AS patient_name, u.email, u.phone, u.status, " +
                     "p.dob, p.gender, p.blood_group, p.address, p.emergency_contact_name, " +
                     "p.emergency_contact_phone, p.medical_history_summary, p.created_at " +
                     "FROM patients p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "ORDER BY p.patient_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapPatient(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all patients", e);
            throw new DatabaseException("Failed to fetch patient list.", e);
        }
        return list;
    }

    public Patient getPatientById(int patientId) {
        String sql = "SELECT p.patient_id, p.user_id, u.full_name AS patient_name, u.email, u.phone, u.status, " +
                     "p.dob, p.gender, p.blood_group, p.address, p.emergency_contact_name, " +
                     "p.emergency_contact_phone, p.medical_history_summary, p.created_at " +
                     "FROM patients p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.patient_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapPatient(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching patient by ID: " + patientId, e);
            throw new DatabaseException("Failed to retrieve patient details.", e);
        }
        return null;
    }

    public Patient getPatientByUserId(int userId) {
        String sql = "SELECT p.patient_id, p.user_id, u.full_name AS patient_name, u.email, u.phone, u.status, " +
                     "p.dob, p.gender, p.blood_group, p.address, p.emergency_contact_name, " +
                     "p.emergency_contact_phone, p.medical_history_summary, p.created_at " +
                     "FROM patients p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapPatient(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching patient by user ID: " + userId, e);
            throw new DatabaseException("Failed to retrieve patient profile.", e);
        }
        return null;
    }

    /**
     * Atomically creates both user account and patient record inside a transaction.
     */
    public boolean createPatientWithUser(Patient patient, User user) {
        String insertUserSql = "INSERT INTO users (role_id, full_name, email, password_hash, phone, status) VALUES (?, ?, ?, ?, ?, ?)";
        String insertPatientSql = "INSERT INTO patients (user_id, dob, gender, blood_group, address, emergency_contact_name, emergency_contact_phone, medical_history_summary) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int userId;
            try (PreparedStatement psUser = conn.prepareStatement(insertUserSql, Statement.RETURN_GENERATED_KEYS)) {
                psUser.setInt(1, 5); // Role 5 = PATIENT
                psUser.setString(2, user.getFullName());
                psUser.setString(3, user.getEmail().trim().toLowerCase());
                psUser.setString(4, user.getPasswordHash());
                psUser.setString(5, user.getPhone());
                psUser.setString(6, "ACTIVE");
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

            try (PreparedStatement psPat = conn.prepareStatement(insertPatientSql, Statement.RETURN_GENERATED_KEYS)) {
                psPat.setInt(1, userId);
                psPat.setDate(2, patient.getDob());
                psPat.setString(3, patient.getGender());
                psPat.setString(4, patient.getBloodGroup());
                psPat.setString(5, patient.getAddress());
                psPat.setString(6, patient.getEmergencyContactName());
                psPat.setString(7, patient.getEmergencyContactPhone());
                psPat.setString(8, patient.getMedicalHistorySummary());
                psPat.executeUpdate();

                try (ResultSet rs = psPat.getGeneratedKeys()) {
                    if (rs.next()) {
                        patient.setPatientId(rs.getInt(1));
                    }
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error creating patient with user: " + user.getEmail(), e);
            throw new DatabaseException("Failed to register patient. Email might already exist.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }

    public boolean updatePatient(Patient patient) {
        String updatePatientSql = "UPDATE patients SET dob = ?, gender = ?, blood_group = ?, address = ?, " +
                                  "emergency_contact_name = ?, emergency_contact_phone = ?, medical_history_summary = ? " +
                                  "WHERE patient_id = ?";
        String updateUserSql = "UPDATE users SET full_name = ?, phone = ? WHERE user_id = ?";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(updatePatientSql)) {
                ps.setDate(1, patient.getDob());
                ps.setString(2, patient.getGender());
                ps.setString(3, patient.getBloodGroup());
                ps.setString(4, patient.getAddress());
                ps.setString(5, patient.getEmergencyContactName());
                ps.setString(6, patient.getEmergencyContactPhone());
                ps.setString(7, patient.getMedicalHistorySummary());
                ps.setInt(8, patient.getPatientId());
                ps.executeUpdate();
            }

            try (PreparedStatement psUser = conn.prepareStatement(updateUserSql)) {
                psUser.setString(1, patient.getPatientName());
                psUser.setString(2, patient.getPhone());
                psUser.setInt(3, patient.getUserId());
                psUser.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error updating patient ID: " + patient.getPatientId(), e);
            throw new DatabaseException("Failed to update patient profile.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }

    public List<Patient> searchPatients(String keyword) {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT p.patient_id, p.user_id, u.full_name AS patient_name, u.email, u.phone, u.status, " +
                     "p.dob, p.gender, p.blood_group, p.address, p.emergency_contact_name, " +
                     "p.emergency_contact_phone, p.medical_history_summary, p.created_at " +
                     "FROM patients p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE LOWER(u.full_name) LIKE ? OR u.phone LIKE ? OR CAST(p.patient_id AS CHAR) = ? " +
                     "ORDER BY p.patient_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String term = "%" + keyword.trim().toLowerCase() + "%";
            ps.setString(1, term);
            ps.setString(2, term);
            ps.setString(3, keyword.trim());

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapPatient(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching patients with keyword: " + keyword, e);
            throw new DatabaseException("Failed to search patients.", e);
        }
        return list;
    }

    private Patient mapPatient(ResultSet rs) throws SQLException {
        Patient p = new Patient();
        p.setPatientId(rs.getInt("patient_id"));
        p.setUserId(rs.getInt("user_id"));
        p.setPatientName(rs.getString("patient_name"));
        p.setEmail(rs.getString("email"));
        p.setPhone(rs.getString("phone"));
        p.setStatus(rs.getString("status"));
        p.setDob(rs.getDate("dob"));
        p.setGender(rs.getString("gender"));
        p.setBloodGroup(rs.getString("blood_group"));
        p.setAddress(rs.getString("address"));
        p.setEmergencyContactName(rs.getString("emergency_contact_name"));
        p.setEmergencyContactPhone(rs.getString("emergency_contact_phone"));
        p.setMedicalHistorySummary(rs.getString("medical_history_summary"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }
}
