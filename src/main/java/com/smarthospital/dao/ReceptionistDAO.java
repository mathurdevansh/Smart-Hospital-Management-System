package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Receptionist;
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
 * Data Access Object for Receptionist management.
 */
public class ReceptionistDAO {

    private static final Logger LOGGER = Logger.getLogger(ReceptionistDAO.class.getName());

    public List<Receptionist> getAllReceptionists() {
        List<Receptionist> list = new ArrayList<>();
        String sql = "SELECT r.receptionist_id, r.user_id, u.full_name AS receptionist_name, u.email, u.phone, u.status, " +
                     "r.qualification, r.shift, r.created_at " +
                     "FROM receptionists r " +
                     "JOIN users u ON r.user_id = u.user_id " +
                     "ORDER BY r.receptionist_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapReceptionist(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching receptionists", e);
            throw new DatabaseException("Failed to fetch receptionists.", e);
        }
        return list;
    }

    public Receptionist getReceptionistByUserId(int userId) {
        String sql = "SELECT r.receptionist_id, r.user_id, u.full_name AS receptionist_name, u.email, u.phone, u.status, " +
                     "r.qualification, r.shift, r.created_at " +
                     "FROM receptionists r " +
                     "JOIN users u ON r.user_id = u.user_id " +
                     "WHERE r.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapReceptionist(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching receptionist by user ID: " + userId, e);
            throw new DatabaseException("Failed to fetch receptionist details.", e);
        }
        return null;
    }

    public boolean createReceptionistWithUser(Receptionist receptionist, User user) {
        String insertUserSql = "INSERT INTO users (role_id, full_name, email, password_hash, phone, status) VALUES (3, ?, ?, ?, ?, 'ACTIVE')";
        String insertRecepSql = "INSERT INTO receptionists (user_id, qualification, shift) VALUES (?, ?, ?)";

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

            try (PreparedStatement psRecep = conn.prepareStatement(insertRecepSql, Statement.RETURN_GENERATED_KEYS)) {
                psRecep.setInt(1, userId);
                psRecep.setString(2, receptionist.getQualification());
                psRecep.setString(3, receptionist.getShift() != null ? receptionist.getShift() : "MORNING");
                psRecep.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error creating receptionist", e);
            throw new DatabaseException("Failed to create receptionist account.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }

    private Receptionist mapReceptionist(ResultSet rs) throws SQLException {
        Receptionist r = new Receptionist();
        r.setReceptionistId(rs.getInt("receptionist_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setReceptionistName(rs.getString("receptionist_name"));
        r.setEmail(rs.getString("email"));
        r.setPhone(rs.getString("phone"));
        r.setStatus(rs.getString("status"));
        r.setQualification(rs.getString("qualification"));
        r.setShift(rs.getString("shift"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        return r;
    }
}
