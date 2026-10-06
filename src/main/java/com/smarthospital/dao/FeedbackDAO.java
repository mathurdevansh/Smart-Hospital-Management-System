package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.AuditLog;
import com.smarthospital.model.Feedback;
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
 * Data Access Object for Patient Feedback and System Audit Logs.
 */
public class FeedbackDAO {

    private static final Logger LOGGER = Logger.getLogger(FeedbackDAO.class.getName());

    public int createFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedback (patient_id, doctor_id, rating, comments) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, feedback.getPatientId());
            if (feedback.getDoctorId() != null && feedback.getDoctorId() > 0) {
                ps.setInt(2, feedback.getDoctorId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }
            ps.setInt(3, feedback.getRating());
            ps.setString(4, feedback.getComments());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    feedback.setFeedbackId(rs.getInt(1));
                    return feedback.getFeedbackId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error submitting patient feedback", e);
            throw new DatabaseException("Failed to submit feedback.", e);
        }
        return 0;
    }

    public List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT fb.feedback_id, fb.patient_id, up.full_name AS patient_name, " +
                     "fb.doctor_id, ud.full_name AS doctor_name, fb.rating, fb.comments, fb.created_at " +
                     "FROM feedback fb " +
                     "JOIN patients p ON fb.patient_id = p.patient_id " +
                     "JOIN users up ON p.user_id = up.user_id " +
                     "LEFT JOIN doctors d ON fb.doctor_id = d.doctor_id " +
                     "LEFT JOIN users ud ON d.user_id = ud.user_id " +
                     "ORDER BY fb.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackId(rs.getInt("feedback_id"));
                fb.setPatientId(rs.getInt("patient_id"));
                fb.setPatientName(rs.getString("patient_name"));
                int docId = rs.getInt("doctor_id");
                if (!rs.wasNull()) {
                    fb.setDoctorId(docId);
                    fb.setDoctorName(rs.getString("doctor_name"));
                }
                fb.setRating(rs.getInt("rating"));
                fb.setComments(rs.getString("comments"));
                fb.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(fb);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching feedback list", e);
            throw new DatabaseException("Failed to fetch feedback records.", e);
        }
        return list;
    }
}
