package com.smarthospital.dao;

import com.smarthospital.exception.DatabaseException;
import com.smarthospital.model.Bill;
import com.smarthospital.model.Payment;
import com.smarthospital.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
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
 * Data Access Object for Invoices, Billing, and Payments.
 */
public class BillingDAO {

    private static final Logger LOGGER = Logger.getLogger(BillingDAO.class.getName());

    public int createBill(Bill bill) {
        bill.calculateTotal();
        String sql = "INSERT INTO billing (patient_id, appointment_id, admission_id, consultation_charges, " +
                     "medicine_charges, lab_charges, room_charges, other_charges, discount, tax, total_amount, payment_status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, bill.getPatientId());
            if (bill.getAppointmentId() != null) {
                ps.setInt(2, bill.getAppointmentId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }
            if (bill.getAdmissionId() != null) {
                ps.setInt(3, bill.getAdmissionId());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            ps.setBigDecimal(4, bill.getConsultationCharges());
            ps.setBigDecimal(5, bill.getMedicineCharges());
            ps.setBigDecimal(6, bill.getLabCharges());
            ps.setBigDecimal(7, bill.getRoomCharges());
            ps.setBigDecimal(8, bill.getOtherCharges());
            ps.setBigDecimal(9, bill.getDiscount());
            ps.setBigDecimal(10, bill.getTax());
            ps.setBigDecimal(11, bill.getTotalAmount());
            ps.setString(12, bill.getPaymentStatus() != null ? bill.getPaymentStatus() : "PENDING");

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    bill.setBillId(rs.getInt(1));
                    return bill.getBillId();
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating invoice", e);
            throw new DatabaseException("Failed to generate bill.", e);
        }
        return 0;
    }

    public Bill getBillById(int billId) {
        String sql = baseBillingQuery() + " WHERE b.bill_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapBill(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching bill ID: " + billId, e);
            throw new DatabaseException("Failed to fetch bill details.", e);
        }
        return null;
    }

    public List<Bill> getAllBills() {
        List<Bill> list = new ArrayList<>();
        String sql = baseBillingQuery() + " ORDER BY b.bill_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapBill(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all bills", e);
            throw new DatabaseException("Failed to fetch billing list.", e);
        }
        return list;
    }

    public List<Bill> getBillsByPatient(int patientId) {
        List<Bill> list = new ArrayList<>();
        String sql = baseBillingQuery() + " WHERE b.patient_id = ? ORDER BY b.bill_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapBill(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching bills for patient ID: " + patientId, e);
            throw new DatabaseException("Failed to fetch patient bills.", e);
        }
        return list;
    }

    /**
     * Atomically records a payment and updates the bill status to PAID.
     */
    public boolean recordPayment(Payment payment) {
        String insertPaymentSql = "INSERT INTO payments (bill_id, payment_mode, amount_paid, transaction_reference) VALUES (?, ?, ?, ?)";
        String updateBillSql = "UPDATE billing SET payment_status = 'PAID', payment_date = CURRENT_TIMESTAMP WHERE bill_id = ?";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement psPay = conn.prepareStatement(insertPaymentSql)) {
                psPay.setInt(1, payment.getBillId());
                psPay.setString(2, payment.getPaymentMode());
                psPay.setBigDecimal(3, payment.getAmountPaid());
                psPay.setString(4, payment.getTransactionReference());
                psPay.executeUpdate();
            }

            try (PreparedStatement psBill = conn.prepareStatement(updateBillSql)) {
                psBill.setInt(1, payment.getBillId());
                psBill.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { LOGGER.log(Level.SEVERE, "Rollback failed", ex); }
            }
            LOGGER.log(Level.SEVERE, "Error recording payment for bill ID: " + payment.getBillId(), e);
            throw new DatabaseException("Failed to record payment.", e);
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { LOGGER.log(Level.WARNING, "Error closing connection", e); }
            }
        }
    }

    public BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM billing WHERE payment_status = 'PAID'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error calculating total revenue", e);
            throw new DatabaseException("Failed to calculate total revenue.", e);
        }
        return BigDecimal.ZERO;
    }

    public List<Bill> getRevenueReport(String fromDate, String toDate) {
        List<Bill> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(baseBillingQuery() + " WHERE b.payment_status = 'PAID' ");

        if (fromDate != null && !fromDate.trim().isEmpty()) {
            sql.append("AND DATE(b.payment_date) >= ? ");
        }
        if (toDate != null && !toDate.trim().isEmpty()) {
            sql.append("AND DATE(b.payment_date) <= ? ");
        }
        sql.append("ORDER BY b.payment_date DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            if (fromDate != null && !fromDate.trim().isEmpty()) {
                ps.setDate(idx++, Date.valueOf(fromDate.trim()));
            }
            if (toDate != null && !toDate.trim().isEmpty()) {
                ps.setDate(idx, Date.valueOf(toDate.trim()));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapBill(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error generating revenue report", e);
            throw new DatabaseException("Failed to generate revenue report.", e);
        }
        return list;
    }

    private String baseBillingQuery() {
        return "SELECT b.bill_id, b.patient_id, up.full_name AS patient_name, up.phone AS patient_phone, up.email AS patient_email, " +
               "b.appointment_id, b.admission_id, b.bill_date, b.consultation_charges, b.medicine_charges, " +
               "b.lab_charges, b.room_charges, b.other_charges, b.discount, b.tax, b.total_amount, " +
               "b.payment_status, b.payment_date " +
               "FROM billing b " +
               "JOIN patients p ON b.patient_id = p.patient_id " +
               "JOIN users up ON p.user_id = up.user_id ";
    }

    private Bill mapBill(ResultSet rs) throws SQLException {
        Bill b = new Bill();
        b.setBillId(rs.getInt("bill_id"));
        b.setPatientId(rs.getInt("patient_id"));
        b.setPatientName(rs.getString("patient_name"));
        b.setPatientPhone(rs.getString("patient_phone"));
        b.setPatientEmail(rs.getString("patient_email"));
        int apptId = rs.getInt("appointment_id");
        if (!rs.wasNull()) {
            b.setAppointmentId(apptId);
        }
        int admId = rs.getInt("admission_id");
        if (!rs.wasNull()) {
            b.setAdmissionId(admId);
        }
        b.setBillDate(rs.getTimestamp("bill_date"));
        b.setConsultationCharges(rs.getBigDecimal("consultation_charges"));
        b.setMedicineCharges(rs.getBigDecimal("medicine_charges"));
        b.setLabCharges(rs.getBigDecimal("lab_charges"));
        b.setRoomCharges(rs.getBigDecimal("room_charges"));
        b.setOtherCharges(rs.getBigDecimal("other_charges"));
        b.setDiscount(rs.getBigDecimal("discount"));
        b.setTax(rs.getBigDecimal("tax"));
        b.setTotalAmount(rs.getBigDecimal("total_amount"));
        b.setPaymentStatus(rs.getString("payment_status"));
        b.setPaymentDate(rs.getTimestamp("payment_date"));
        return b;
    }
}
