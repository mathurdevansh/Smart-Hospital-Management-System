package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.LabTest;
import com.smarthospital.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Laboratory Diagnostic Tests and Reports.
 */
public class LabDAO {

    private static final Logger LOGGER = Logger.getLogger(LabDAO.class.getName());

    public int createLabTest(LabTest test) {
        String sql = "INSERT INTO lab_tests (patient_id, doctor_id, appointment_id, test_name, normal_range, status, remarks) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, test.getPatientId());
            ps.setInt(2, test.getDoctorId());
            if (test.getAppointmentId() != null) {
                ps.setInt(3, test.getAppointmentId());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            ps.setString(4, test.getTestName());
            ps.setString(5, test.getNormalRange());
            ps.setString(6, test.getStatus() != null ? test.getStatus() : "PENDING");
            ps.setString(7, test.getRemarks());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    test.setTestId(rs.getInt(1));
                    return test.getTestId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating lab test order", e);
            throw new DatabaseException("Failed to order lab test.", e);
        }
        return 0;
    }

    public LabTest getLabTestById(int testId) {
        String sql = baseLabQuery() + " WHERE lt.test_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, testId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapLabTest(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching lab test ID: " + testId, e);
            throw new DatabaseException("Failed to fetch lab test.", e);
        }
        return null;
    }

    public List<LabTest> getAllLabTests() {
        List<LabTest> list = new ArrayList<>();
        String sql = baseLabQuery() + " ORDER BY lt.test_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapLabTest(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all lab tests", e);
            throw new DatabaseException("Failed to fetch lab tests.", e);
        }
        return list;
    }

    public List<LabTest> getLabTestsByPatient(int patientId) {
        List<LabTest> list = new ArrayList<>();
        String sql = baseLabQuery() + " WHERE lt.patient_id = ? ORDER BY lt.test_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapLabTest(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching lab tests for patient ID: " + patientId, e);
            throw new DatabaseException("Failed to fetch patient lab tests.", e);
        }
        return list;
    }

    public List<LabTest> getLabTestsByDoctor(int doctorId) {
        List<LabTest> list = new ArrayList<>();
        String sql = baseLabQuery() + " WHERE lt.doctor_id = ? ORDER BY lt.test_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapLabTest(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching lab tests for doctor ID: " + doctorId, e);
            throw new DatabaseException("Failed to fetch doctor lab tests.", e);
        }
        return list;
    }

    public boolean updateLabResult(int testId, String result, String normalRange, String remarks, String status) {
        String sql = "UPDATE lab_tests SET result = ?, normal_range = ?, remarks = ?, status = ?, " +
                     "completed_at = CASE WHEN ? = 'COMPLETED' THEN CURRENT_TIMESTAMP ELSE completed_at END " +
                     "WHERE test_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, result);
            ps.setString(2, normalRange);
            ps.setString(3, remarks);
            ps.setString(4, status);
            ps.setString(5, status);
            ps.setInt(6, testId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating lab test ID: " + testId, e);
            throw new DatabaseException("Failed to update lab test result.", e);
        }
    }

    private String baseLabQuery() {
        return "SELECT lt.test_id, lt.patient_id, up.full_name AS patient_name, " +
               "lt.doctor_id, ud.full_name AS doctor_name, lt.appointment_id, " +
               "lt.test_name, lt.test_date, lt.normal_range, lt.result, lt.status, " +
               "lt.report_file, lt.remarks, lt.completed_at " +
               "FROM lab_tests lt " +
               "JOIN patients p ON lt.patient_id = p.patient_id " +
               "JOIN users up ON p.user_id = up.user_id " +
               "JOIN doctors d ON lt.doctor_id = d.doctor_id " +
               "JOIN users ud ON d.user_id = ud.user_id ";
    }

    private LabTest mapLabTest(ResultSet rs) throws SQLException {
        LabTest lt = new LabTest();
        lt.setTestId(rs.getInt("test_id"));
        lt.setPatientId(rs.getInt("patient_id"));
        lt.setPatientName(rs.getString("patient_name"));
        lt.setDoctorId(rs.getInt("doctor_id"));
        lt.setDoctorName(rs.getString("doctor_name"));
        int apptId = rs.getInt("appointment_id");
        if (!rs.wasNull()) {
            lt.setAppointmentId(apptId);
        }
        lt.setTestName(rs.getString("test_name"));
        lt.setTestDate(rs.getTimestamp("test_date"));
        lt.setNormalRange(rs.getString("normal_range"));
        lt.setResult(rs.getString("result"));
        lt.setStatus(rs.getString("status"));
        lt.setReportFile(rs.getString("report_file"));
        lt.setRemarks(rs.getString("remarks"));
        lt.setCompletedAt(rs.getTimestamp("completed_at"));
        return lt;
    }
}
