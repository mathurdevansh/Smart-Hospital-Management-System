package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Appointment;
import com.smarthospital.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Appointment bookings, scheduling, and statuses.
 */
public class AppointmentDAO {

    private static final Logger LOGGER = Logger.getLogger(AppointmentDAO.class.getName());

    /**
     * Checks if a doctor already has an active (non-cancelled, non-rejected) appointment at the given date and time.
     */
    public boolean isSlotBooked(int doctorId, Date date, Time time, Integer excludeApptId) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM appointments " +
                "WHERE doctor_id = ? AND appointment_date = ? AND appointment_time = ? " +
                "AND status NOT IN ('CANCELLED', 'REJECTED') "
        );
        if (excludeApptId != null) {
            sql.append("AND appointment_id != ?");
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            ps.setInt(1, doctorId);
            ps.setDate(2, date);
            ps.setTime(3, time);
            if (excludeApptId != null) {
                ps.setInt(4, excludeApptId);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking appointment slot availability", e);
            throw new DatabaseException("Failed to verify appointment slot availability.", e);
        }
        return false;
    }

    public int createAppointment(Appointment appt) {
        String sql = "INSERT INTO appointments (patient_id, doctor_id, department_id, appointment_date, appointment_time, reason, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, appt.getPatientId());
            ps.setInt(2, appt.getDoctorId());
            ps.setInt(3, appt.getDepartmentId());
            ps.setDate(4, appt.getAppointmentDate());
            ps.setTime(5, appt.getAppointmentTime());
            ps.setString(6, appt.getReason());
            ps.setString(7, appt.getStatus() != null ? appt.getStatus() : "PENDING");

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    appt.setAppointmentId(rs.getInt(1));
                    return appt.getAppointmentId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating appointment", e);
            throw new DatabaseException("Failed to book appointment.", e);
        }
        return 0;
    }

    public Appointment getAppointmentById(int apptId) {
        String sql = baseAppointmentQuery() + " WHERE a.appointment_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, apptId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapAppointment(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching appointment ID: " + apptId, e);
            throw new DatabaseException("Failed to retrieve appointment details.", e);
        }
        return null;
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String sql = baseAppointmentQuery() + " ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapAppointment(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all appointments", e);
            throw new DatabaseException("Failed to fetch appointments.", e);
        }
        return list;
    }

    public List<Appointment> getAppointmentsByDoctor(int doctorId, String status) {
        List<Appointment> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(baseAppointmentQuery() + " WHERE a.doctor_id = ? ");
        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append("AND a.status = ? ");
        }
        sql.append("ORDER BY a.appointment_date ASC, a.appointment_time ASC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            ps.setInt(1, doctorId);
            if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
                ps.setString(2, status.trim().toUpperCase());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapAppointment(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching appointments for doctor ID: " + doctorId, e);
            throw new DatabaseException("Failed to fetch doctor appointments.", e);
        }
        return list;
    }

    public List<Appointment> getAppointmentsByPatient(int patientId) {
        List<Appointment> list = new ArrayList<>();
        String sql = baseAppointmentQuery() + " WHERE a.patient_id = ? ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapAppointment(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching appointments for patient ID: " + patientId, e);
            throw new DatabaseException("Failed to fetch patient appointments.", e);
        }
        return list;
    }

    public List<Appointment> getTodayAppointmentsForDoctor(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        String sql = baseAppointmentQuery() + " WHERE a.doctor_id = ? AND a.appointment_date = CURRENT_DATE() ORDER BY a.appointment_time ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapAppointment(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching today's appointments for doctor ID: " + doctorId, e);
            throw new DatabaseException("Failed to fetch today's doctor appointments.", e);
        }
        return list;
    }

    public boolean updateStatus(int apptId, String status) {
        String sql = "UPDATE appointments SET status = ? WHERE appointment_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status.trim().toUpperCase());
            ps.setInt(2, apptId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating status for appointment ID: " + apptId, e);
            throw new DatabaseException("Failed to update appointment status.", e);
        }
    }

    public boolean reschedule(int apptId, Date newDate, Time newTime) {
        String sql = "UPDATE appointments SET appointment_date = ?, appointment_time = ?, status = 'CONFIRMED' WHERE appointment_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, newDate);
            ps.setTime(2, newTime);
            ps.setInt(3, apptId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error rescheduling appointment ID: " + apptId, e);
            throw new DatabaseException("Failed to reschedule appointment.", e);
        }
    }

    public List<Appointment> filterAppointments(String date, Integer doctorId, Integer patientId, String status) {
        List<Appointment> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(baseAppointmentQuery() + " WHERE 1=1 ");

        if (date != null && !date.trim().isEmpty()) {
            sql.append("AND a.appointment_date = ? ");
        }
        if (doctorId != null && doctorId > 0) {
            sql.append("AND a.doctor_id = ? ");
        }
        if (patientId != null && patientId > 0) {
            sql.append("AND a.patient_id = ? ");
        }
        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append("AND a.status = ? ");
        }
        sql.append("ORDER BY a.appointment_date DESC, a.appointment_time DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (date != null && !date.trim().isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(date.trim()));
            }
            if (doctorId != null && doctorId > 0) {
                ps.setInt(paramIndex++, doctorId);
            }
            if (patientId != null && patientId > 0) {
                ps.setInt(paramIndex++, patientId);
            }
            if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
                ps.setString(paramIndex, status.trim().toUpperCase());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapAppointment(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error filtering appointments", e);
            throw new DatabaseException("Failed to search appointments.", e);
        }
        return list;
    }

    private String baseAppointmentQuery() {
        return "SELECT a.appointment_id, a.patient_id, up.full_name AS patient_name, up.phone AS patient_phone, " +
               "a.doctor_id, ud.full_name AS doctor_name, d.consultation_fee, " +
               "a.department_id, dept.name AS department_name, " +
               "a.appointment_date, a.appointment_time, a.reason, a.status, a.created_at " +
               "FROM appointments a " +
               "JOIN patients p ON a.patient_id = p.patient_id " +
               "JOIN users up ON p.user_id = up.user_id " +
               "JOIN doctors d ON a.doctor_id = d.doctor_id " +
               "JOIN users ud ON d.user_id = ud.user_id " +
               "JOIN departments dept ON a.department_id = dept.department_id ";
    }

    private Appointment mapAppointment(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setAppointmentId(rs.getInt("appointment_id"));
        a.setPatientId(rs.getInt("patient_id"));
        a.setPatientName(rs.getString("patient_name"));
        a.setPatientPhone(rs.getString("patient_phone"));
        a.setDoctorId(rs.getInt("doctor_id"));
        a.setDoctorName(rs.getString("doctor_name"));
        a.setConsultationFee(rs.getBigDecimal("consultation_fee"));
        a.setDepartmentId(rs.getInt("department_id"));
        a.setDepartmentName(rs.getString("department_name"));
        a.setAppointmentDate(rs.getDate("appointment_date"));
        a.setAppointmentTime(rs.getTime("appointment_time"));
        a.setReason(rs.getString("reason"));
        a.setStatus(rs.getString("status"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        return a;
    }
}
