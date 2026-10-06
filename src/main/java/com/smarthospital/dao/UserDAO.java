package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Role;
import com.smarthospital.model.User;
import com.smarthospital.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Users, Roles, and Authentication.
 */
public class UserDAO {

    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());

    public User getUserByEmailAndRole(String email, String roleName) {
        String sql = "SELECT u.user_id, u.role_id, r.role_name, u.full_name, u.email, " +
                     "u.password_hash, u.phone, u.status, u.created_at, u.updated_at " +
                     "FROM users u " +
                     "JOIN roles r ON u.role_id = r.role_id " +
                     "WHERE LOWER(u.email) = LOWER(?) AND UPPER(r.role_name) = UPPER(?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email.trim());
            ps.setString(2, roleName.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching user by email and role: " + email, e);
            throw new DatabaseException("Failed to retrieve user credentials.", e);
        }
        return null;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT u.user_id, u.role_id, r.role_name, u.full_name, u.email, " +
                     "u.password_hash, u.phone, u.status, u.created_at, u.updated_at " +
                     "FROM users u " +
                     "JOIN roles r ON u.role_id = r.role_id " +
                     "WHERE LOWER(u.email) = LOWER(?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching user by email: " + email, e);
            throw new DatabaseException("Database error during email lookup.", e);
        }
        return null;
    }

    public User getUserById(int userId) {
        String sql = "SELECT u.user_id, u.role_id, r.role_name, u.full_name, u.email, " +
                     "u.password_hash, u.phone, u.status, u.created_at, u.updated_at " +
                     "FROM users u " +
                     "JOIN roles r ON u.role_id = r.role_id " +
                     "WHERE u.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching user by ID: " + userId, e);
            throw new DatabaseException("Failed to retrieve user by ID.", e);
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.user_id, u.role_id, r.role_name, u.full_name, u.email, " +
                     "u.password_hash, u.phone, u.status, u.created_at, u.updated_at " +
                     "FROM users u " +
                     "JOIN roles r ON u.role_id = r.role_id " +
                     "ORDER BY u.user_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all users", e);
            throw new DatabaseException("Failed to retrieve user list.", e);
        }
        return list;
    }

    public int createUser(User user) {
        String sql = "INSERT INTO users (role_id, full_name, email, password_hash, phone, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, user.getRoleId());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getEmail().trim().toLowerCase());
            ps.setString(4, user.getPasswordHash());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getStatus() != null ? user.getStatus() : "ACTIVE");

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    user.setUserId(rs.getInt(1));
                    return user.getUserId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting new user: " + user.getEmail(), e);
            throw new DatabaseException("Failed to create user account. Email might already exist.", e);
        }
        return 0;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, role_id = ?, status = ? WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setInt(3, user.getRoleId());
            ps.setString(4, user.getStatus());
            ps.setInt(5, user.getUserId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user ID: " + user.getUserId(), e);
            throw new DatabaseException("Failed to update user.", e);
        }
    }

    public boolean updatePassword(int userId, String newPasswordHash) {
        String sql = "UPDATE users SET password_hash = ? WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newPasswordHash);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating password for user ID: " + userId, e);
            throw new DatabaseException("Failed to update password.", e);
        }
    }

    public boolean updateStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user status for user ID: " + userId, e);
            throw new DatabaseException("Failed to update user status.", e);
        }
    }

    public List<User> searchUsers(String keyword) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.user_id, u.role_id, r.role_name, u.full_name, u.email, " +
                     "u.password_hash, u.phone, u.status, u.created_at, u.updated_at " +
                     "FROM users u " +
                     "JOIN roles r ON u.role_id = r.role_id " +
                     "WHERE LOWER(u.full_name) LIKE ? OR LOWER(u.email) LIKE ? OR u.phone LIKE ? " +
                     "ORDER BY u.user_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String term = "%" + keyword.trim().toLowerCase() + "%";
            ps.setString(1, term);
            ps.setString(2, term);
            ps.setString(3, term);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapUser(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching users with term: " + keyword, e);
            throw new DatabaseException("Failed to search users.", e);
        }
        return list;
    }

    public List<Role> getAllRoles() {
        List<Role> list = new ArrayList<>();
        String sql = "SELECT role_id, role_name, description FROM roles ORDER BY role_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Role(rs.getInt("role_id"), rs.getString("role_name"), rs.getString("description")));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching roles", e);
            throw new DatabaseException("Failed to fetch roles.", e);
        }
        return list;
    }

    public Map<String, Integer> getSystemCounts() {
        Map<String, Integer> counts = new HashMap<>();
        String sql = "SELECT " +
                     "(SELECT COUNT(*) FROM patients) AS total_patients, " +
                     "(SELECT COUNT(*) FROM doctors) AS total_doctors, " +
                     "(SELECT COUNT(*) FROM nurses) AS total_nurses, " +
                     "(SELECT COUNT(*) FROM appointments WHERE appointment_date = CURRENT_DATE()) AS today_appointments, " +
                     "(SELECT COUNT(*) FROM appointments WHERE status = 'PENDING') AS pending_appointments, " +
                     "(SELECT COUNT(*) FROM rooms WHERE status = 'AVAILABLE') AS available_rooms, " +
                     "(SELECT COUNT(*) FROM lab_tests WHERE status = 'PENDING') AS pending_lab_tests";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                counts.put("totalPatients", rs.getInt("total_patients"));
                counts.put("totalDoctors", rs.getInt("total_doctors"));
                counts.put("totalNurses", rs.getInt("total_nurses"));
                counts.put("todayAppointments", rs.getInt("today_appointments"));
                counts.put("pendingAppointments", rs.getInt("pending_appointments"));
                counts.put("availableRooms", rs.getInt("available_rooms"));
                counts.put("pendingLabTests", rs.getInt("pending_lab_tests"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching system summary counts", e);
            throw new DatabaseException("Failed to fetch dashboard metrics.", e);
        }
        return counts;
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setRoleId(rs.getInt("role_id"));
        u.setRoleName(rs.getString("role_name"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPasswordHash(rs.getString("password_hash"));
        u.setPhone(rs.getString("phone"));
        u.setStatus(rs.getString("status"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        u.setUpdatedAt(rs.getTimestamp("updated_at"));
        return u;
    }
}
