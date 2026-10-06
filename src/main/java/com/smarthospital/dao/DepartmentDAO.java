package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Department;
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
 * Data Access Object for Departments.
 */
public class DepartmentDAO {

    private static final Logger LOGGER = Logger.getLogger(DepartmentDAO.class.getName());

    public List<Department> getAllDepartments() {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT department_id, name, description, status, created_at FROM departments ORDER BY name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapDepartment(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving departments", e);
            throw new DatabaseException("Failed to fetch departments.", e);
        }
        return list;
    }

    public Department getDepartmentById(int deptId) {
        String sql = "SELECT department_id, name, description, status, created_at FROM departments WHERE department_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, deptId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapDepartment(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching department ID: " + deptId, e);
            throw new DatabaseException("Failed to fetch department details.", e);
        }
        return null;
    }

    public int createDepartment(Department dept) {
        String sql = "INSERT INTO departments (name, description, status) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, dept.getName());
            ps.setString(2, dept.getDescription());
            ps.setString(3, dept.getStatus() != null ? dept.getStatus() : "ACTIVE");

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    dept.setDepartmentId(rs.getInt(1));
                    return dept.getDepartmentId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting department: " + dept.getName(), e);
            throw new DatabaseException("Failed to create department. Name may already exist.", e);
        }
        return 0;
    }

    public boolean updateDepartment(Department dept) {
        String sql = "UPDATE departments SET name = ?, description = ?, status = ? WHERE department_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dept.getName());
            ps.setString(2, dept.getDescription());
            ps.setString(3, dept.getStatus());
            ps.setInt(4, dept.getDepartmentId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating department ID: " + dept.getDepartmentId(), e);
            throw new DatabaseException("Failed to update department.", e);
        }
    }

    public boolean deleteDepartment(int deptId) {
        String sql = "DELETE FROM departments WHERE department_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, deptId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting department ID: " + deptId, e);
            throw new DatabaseException("Cannot delete department because doctors or appointments are assigned to it.", e);
        }
    }

    private Department mapDepartment(ResultSet rs) throws SQLException {
        Department d = new Department();
        d.setDepartmentId(rs.getInt("department_id"));
        d.setName(rs.getString("name"));
        d.setDescription(rs.getString("description"));
        d.setStatus(rs.getString("status"));
        d.setCreatedAt(rs.getTimestamp("created_at"));
        return d;
    }
}
