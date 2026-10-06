package com.smarthospital.service;

import com.smarthospital.dao.AuditDAO;
import com.smarthospital.dao.BillingDAO;
import com.smarthospital.exception.ApplicationException;
import com.smarthospital.model.Bill;
import com.smarthospital.model.Payment;

import java.math.BigDecimal;
import java.util.List;

/**
 * Service managing invoice creation, payment settlement, and revenue metrics.
 */
public class BillingService {

    private final BillingDAO billingDAO = new BillingDAO();
    private final AuditDAO auditDAO = new AuditDAO();

    public int generateBill(Bill bill, Integer generatedByUserId, String ipAddress) {
        if (bill.getPatientId() <= 0) {
            throw new ApplicationException("Patient is required to generate a bill.");
        }
        bill.calculateTotal();

        int billId = billingDAO.createBill(bill);
        auditDAO.log(generatedByUserId, "BILL_GENERATED", "Generated invoice #" + billId + " total: " + bill.getTotalAmount(), ipAddress);
        return billId;
    }

    public boolean processPayment(int billId, String paymentMode, BigDecimal amount, String refNo, Integer processedByUserId, String ipAddress) {
        if (billId <= 0) {
            throw new ApplicationException("Valid bill ID is required.");
        }
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new ApplicationException("Payment amount must be greater than zero.");
        }

        Payment payment = new Payment(billId, paymentMode, amount, refNo);
        boolean success = billingDAO.recordPayment(payment);
        if (success) {
            auditDAO.log(processedByUserId, "PAYMENT_RECORDED", "Recorded payment of " + amount + " via " + paymentMode + " for invoice #" + billId, ipAddress);
        }
        return success;
    }

    public Bill getBillById(int billId) {
        return billingDAO.getBillById(billId);
    }

    public List<Bill> getAllBills() {
        return billingDAO.getAllBills();
    }

    public List<Bill> getBillsByPatient(int patientId) {
        return billingDAO.getBillsByPatient(patientId);
    }

    public BigDecimal getTotalRevenue() {
        return billingDAO.getTotalRevenue();
    }

    public List<Bill> getRevenueReport(String fromDate, String toDate) {
        return billingDAO.getRevenueReport(fromDate, toDate);
    }
}
