package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Doctor;
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
 * Data Access Object for Doctor profiles and management.
 */
public class DoctorDAO {

    private static final Logger LOGGER = Logger.getLogger(DoctorDAO.class.getName());

    public List<Doctor> getAllDoctors() {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT d.doctor_id, d.user_id, d.department_id, dept.name AS department_name, " +
                     "u.full_name AS doctor_name, u.email, u.phone, u.status, " +
                     "d.specialization, d.qualification, d.experience_years, d.consultation_fee, " +
                     "d.room_no, d.available_days, d.available_time, d.created_at " +
                     "FROM doctors d " +
                     "JOIN users u ON d.user_id = u.user_id " +
                     "JOIN departments dept ON d.department_id = dept.department_id " +
                     "ORDER BY d.doctor_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapDoctor(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving doctors", e);
            throw new DatabaseException("Failed to fetch doctor list.", e);
        }
        return list;
    }

    public Doctor getDoctorById(int doctorId) {
        String sql = "SELECT d.doctor_id, d.user_id, d.department_id, dept.name AS department_name, " +
                     "u.full_name AS doctor_name, u.email, u.phone, u.status, " +
                     "d.specialization, d.qualification, d.experience_years, d.consultation_fee, " +
                     "d.room_no, d.available_days, d.available_time, d.created_at " +
                     "FROM doctors d " +
                     "JOIN users u ON d.user_id = u.user_id " +
                     "JOIN departments dept ON d.department_id = dept.department_id " +
                     "WHERE d.doctor_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapDoctor(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching doctor by ID: " + doctorId, e);
            throw new DatabaseException("Failed to fetch doctor details.", e);
        }
        return null;
    }

    public Doctor getDoctorByUserId(int userId) {
        String sql = "SELECT d.doctor_id, d.user_id, d.department_id, dept.name AS department_name, " +
                     "u.full_name AS doctor_name, u.email, u.phone, u.status, " +
                     "d.specialization, d.qualification, d.experience_years, d.consultation_fee, " +
                     "d.room_no, d.available_days, d.available_time, d.created_at " +
                     "FROM doctors d " +
                     "JOIN users u ON d.user_id = u.user_id " +
                     "JOIN departments dept ON d.department_id = dept.department_id " +
                     "WHERE d.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapDoctor(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching doctor by user ID: " + userId, e);
            throw new DatabaseException("Failed to fetch doctor profile.", e);
        }
        return null;
    }

    public List<Doctor> getDoctorsByDepartment(int departmentId) {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT d.doctor_id, d.user_id, d.department_id, dept.name AS department_name, " +
                     "u.full_name AS doctor_name, u.email, u.phone, u.status, " +
                     "d.specialization, d.qualification, d.experience_years, d.consultation_fee, " +
                     "d.room_no, d.available_days, d.available_time, d.created_at " +
                     "FROM doctors d " +
                     "JOIN users u ON d.user_id = u.user_id " +
                     "JOIN departments dept ON d.department_id = dept.department_id " +
                     "WHERE d.department_id = ? AND u.status = 'ACTIVE' " +
                     "ORDER BY u.full_name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, departmentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapDoctor(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching doctors by department ID: " + departmentId, e);
            throw new DatabaseException("Failed to fetch doctors by department.", e);
        }
        return list;
    }

    /**
     * Atomically creates both user account and doctor profile inside a transaction.
     */
    public boolean createDoctorWithUser(Doctor doctor, User user) {
        String insertUserSql = "INSERT INTO users (role_id, full_name, email, password_hash, phone, status) VALUES (?, ?, ?, ?, ?, ?)";
        String insertDoctorSql = "INSERT INTO doctors (user_id, department_id, specialization, qualification, experience_years, consultation_fee, room_no, available_days, available_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int userId;
            try (PreparedStatement psUser = conn.prepareStatement(insertUserSql, Statement.RETURN_GENERATED_KEYS)) {
                psUser.setInt(1, 2); // Role 2 = DOCTOR
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

            try (PreparedStatement psDoc = conn.prepareStatement(insertDoctorSql, Statement.RETURN_GENERATED_KEYS)) {
                psDoc.setInt(1, userId);
                psDoc.setInt(2, doctor.getDepartmentId());
                psDoc.setString(3, doctor.getSpecialization());
                psDoc.setString(4, doctor.getQualification());
                psDoc.setInt(5, doctor.getExperienceYears());
                psDoc.setBigDecimal(6, doctor.getConsultationFee());
                psDoc.setString(7, doctor.getRoomNo());
                psDoc.setString(8, doctor.getAvailableDays() != null ? doctor.getAvailableDays() : "Mon-Sat");
                psDoc.setString(9, doctor.getAvailableTime() != null ? doctor.getAvailableTime() : "09:00 AM - 05:00 PM");
                psDoc.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error creating doctor with user: " + user.getEmail(), e);
            throw new DatabaseException("Failed to register doctor. Email might already exist.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }

    public boolean updateDoctor(Doctor doctor) {
        String updateDoctorSql = "UPDATE doctors SET department_id = ?, specialization = ?, qualification = ?, " +
                                 "experience_years = ?, consultation_fee = ?, room_no = ?, available_days = ?, available_time = ? " +
                                 "WHERE doctor_id = ?";
        String updateUserSql = "UPDATE users SET full_name = ?, phone = ? WHERE user_id = ?";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(updateDoctorSql)) {
                ps.setInt(1, doctor.getDepartmentId());
                ps.setString(2, doctor.getSpecialization());
                ps.setString(3, doctor.getQualification());
                ps.setInt(4, doctor.getExperienceYears());
                ps.setBigDecimal(5, doctor.getConsultationFee());
                ps.setString(6, doctor.getRoomNo());
                ps.setString(7, doctor.getAvailableDays());
                ps.setString(8, doctor.getAvailableTime());
                ps.setInt(9, doctor.getDoctorId());
                ps.executeUpdate();
            }

            try (PreparedStatement psUser = conn.prepareStatement(updateUserSql)) {
                psUser.setString(1, doctor.getDoctorName());
                psUser.setString(2, doctor.getPhone());
                psUser.setInt(3, doctor.getUserId());
                psUser.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error updating doctor ID: " + doctor.getDoctorId(), e);
            throw new DatabaseException("Failed to update doctor profile.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }

    public List<Doctor> searchDoctors(String keyword, Integer deptId) {
        List<Doctor> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT d.doctor_id, d.user_id, d.department_id, dept.name AS department_name, " +
                "u.full_name AS doctor_name, u.email, u.phone, u.status, " +
                "d.specialization, d.qualification, d.experience_years, d.consultation_fee, " +
                "d.room_no, d.available_days, d.available_time, d.created_at " +
                "FROM doctors d " +
                "JOIN users u ON d.user_id = u.user_id " +
                "JOIN departments dept ON d.department_id = dept.department_id " +
                "WHERE 1=1 "
        );

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (LOWER(u.full_name) LIKE ? OR LOWER(d.specialization) LIKE ? OR LOWER(dept.name) LIKE ?) ");
        }
        if (deptId != null && deptId > 0) {
            sql.append("AND d.department_id = ? ");
        }
        sql.append("ORDER BY u.full_name ASC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String term = "%" + keyword.trim().toLowerCase() + "%";
                ps.setString(paramIndex++, term);
                ps.setString(paramIndex++, term);
                ps.setString(paramIndex++, term);
            }
            if (deptId != null && deptId > 0) {
                ps.setInt(paramIndex, deptId);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapDoctor(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching doctors", e);
            throw new DatabaseException("Failed to search doctors.", e);
        }
        return list;
    }

    private Doctor mapDoctor(ResultSet rs) throws SQLException {
        Doctor d = new Doctor();
        d.setDoctorId(rs.getInt("doctor_id"));
        d.setUserId(rs.getInt("user_id"));
        d.setDepartmentId(rs.getInt("department_id"));
        d.setDepartmentName(rs.getString("department_name"));
        d.setDoctorName(rs.getString("doctor_name"));
        d.setEmail(rs.getString("email"));
        d.setPhone(rs.getString("phone"));
        d.setStatus(rs.getString("status"));
        d.setSpecialization(rs.getString("specialization"));
        d.setQualification(rs.getString("qualification"));
        d.setExperienceYears(rs.getInt("experience_years"));
        d.setConsultationFee(rs.getBigDecimal("consultation_fee"));
        d.setRoomNo(rs.getString("room_no"));
        d.setAvailableDays(rs.getString("available_days"));
        d.setAvailableTime(rs.getString("available_time"));
        d.setCreatedAt(rs.getTimestamp("created_at"));
        return d;
    }
}
