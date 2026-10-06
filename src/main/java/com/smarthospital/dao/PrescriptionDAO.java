package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Prescription;
import com.smarthospital.model.PrescriptionItem;
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
 * Data Access Object for Prescriptions and Prescription Items.
 */
public class PrescriptionDAO {

    private static final Logger LOGGER = Logger.getLogger(PrescriptionDAO.class.getName());

    public boolean createPrescription(Prescription presc) {
        String insertPrescSql = "INSERT INTO prescriptions (record_id, patient_id, doctor_id, notes) VALUES (?, ?, ?, ?)";
        String insertItemSql = "INSERT INTO prescription_items (prescription_id, medicine_id, dosage, frequency, duration, instructions) " +
                               "VALUES (?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int prescId;
            try (PreparedStatement ps = conn.prepareStatement(insertPrescSql, Statement.RETURN_GENERATED_KEYS)) {
                if (presc.getRecordId() != null) {
                    ps.setInt(1, presc.getRecordId());
                } else {
                    ps.setNull(1, Types.INTEGER);
                }
                ps.setInt(2, presc.getPatientId());
                ps.setInt(3, presc.getDoctorId());
                ps.setString(4, presc.getNotes());
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        prescId = rs.getInt(1);
                        presc.setPrescriptionId(prescId);
                    } else {
                        conn.rollback();
                        return false;
                    }
                }
            }

            if (presc.getItems() != null && !presc.getItems().isEmpty()) {
                try (PreparedStatement psItem = conn.prepareStatement(insertItemSql)) {
                    for (PrescriptionItem item : presc.getItems()) {
                        psItem.setInt(1, prescId);
                        psItem.setInt(2, item.getMedicineId());
                        psItem.setString(3, item.getDosage());
                        psItem.setString(4, item.getFrequency());
                        psItem.setString(5, item.getDuration());
                        psItem.setString(6, item.getInstructions());
                        psItem.addBatch();
                    }
                    psItem.executeBatch();
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error creating prescription", e);
            throw new DatabaseException("Failed to save prescription.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }

    public Prescription getPrescriptionById(int prescId) {
        String sql = basePrescriptionQuery() + " WHERE pr.prescription_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, prescId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Prescription p = mapPrescription(rs);
                    p.setItems(getItemsByPrescriptionId(conn, prescId));
                    return p;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching prescription ID: " + prescId, e);
            throw new DatabaseException("Failed to retrieve prescription.", e);
        }
        return null;
    }

    public List<Prescription> getPrescriptionsByPatient(int patientId) {
        List<Prescription> list = new ArrayList<>();
        String sql = basePrescriptionQuery() + " WHERE pr.patient_id = ? ORDER BY pr.prescription_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prescription p = mapPrescription(rs);
                    p.setItems(getItemsByPrescriptionId(conn, p.getPrescriptionId()));
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching prescriptions for patient ID: " + patientId, e);
            throw new DatabaseException("Failed to fetch patient prescriptions.", e);
        }
        return list;
    }

    public List<Prescription> getPrescriptionsByDoctor(int doctorId) {
        List<Prescription> list = new ArrayList<>();
        String sql = basePrescriptionQuery() + " WHERE pr.doctor_id = ? ORDER BY pr.prescription_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prescription p = mapPrescription(rs);
                    p.setItems(getItemsByPrescriptionId(conn, p.getPrescriptionId()));
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching prescriptions for doctor ID: " + doctorId, e);
            throw new DatabaseException("Failed to fetch doctor prescriptions.", e);
        }
        return list;
    }

    private List<PrescriptionItem> getItemsByPrescriptionId(Connection conn, int prescId) throws SQLException {
        List<PrescriptionItem> items = new ArrayList<>();
        String sql = "SELECT pi.item_id, pi.prescription_id, pi.medicine_id, m.medicine_name, " +
                     "pi.dosage, pi.frequency, pi.duration, pi.instructions " +
                     "FROM prescription_items pi " +
                     "JOIN medicines m ON pi.medicine_id = m.medicine_id " +
                     "WHERE pi.prescription_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, prescId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PrescriptionItem item = new PrescriptionItem();
                    item.setItemId(rs.getInt("item_id"));
                    item.setPrescriptionId(rs.getInt("prescription_id"));
                    item.setMedicineId(rs.getInt("medicine_id"));
                    item.setMedicineName(rs.getString("medicine_name"));
                    item.setDosage(rs.getString("dosage"));
                    item.setFrequency(rs.getString("frequency"));
                    item.setDuration(rs.getString("duration"));
                    item.setInstructions(rs.getString("instructions"));
                    items.add(item);
                }
            }
        }
        return items;
    }

    private String basePrescriptionQuery() {
        return "SELECT pr.prescription_id, pr.record_id, pr.patient_id, up.full_name AS patient_name, " +
               "pr.doctor_id, ud.full_name AS doctor_name, d.specialization AS doctor_specialization, " +
               "pr.prescription_date, pr.notes, pr.created_at " +
               "FROM prescriptions pr " +
               "JOIN patients p ON pr.patient_id = p.patient_id " +
               "JOIN users up ON p.user_id = up.user_id " +
               "JOIN doctors d ON pr.doctor_id = d.doctor_id " +
               "JOIN users ud ON d.user_id = ud.user_id ";
    }

    private Prescription mapPrescription(ResultSet rs) throws SQLException {
        Prescription p = new Prescription();
        p.setPrescriptionId(rs.getInt("prescription_id"));
        int recId = rs.getInt("record_id");
        if (!rs.wasNull()) {
            p.setRecordId(recId);
        }
        p.setPatientId(rs.getInt("patient_id"));
        p.setPatientName(rs.getString("patient_name"));
        p.setDoctorId(rs.getInt("doctor_id"));
        p.setDoctorName(rs.getString("doctor_name"));
        p.setDoctorSpecialization(rs.getString("doctor_specialization"));
        p.setPrescriptionDate(rs.getTimestamp("prescription_date"));
        p.setNotes(rs.getString("notes"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }
}
