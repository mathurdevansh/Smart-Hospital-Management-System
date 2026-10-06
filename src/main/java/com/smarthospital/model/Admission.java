package com.smarthospital.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Admission Model representing in-patient room assignments and hospitalizations.
 */
public class Admission implements Serializable {
    private static final long serialVersionUID = 1L;

    private int admissionId;
    private int patientId;
    private String patientName;
    private int doctorId;
    private String doctorName;
    private int roomId;
    private String roomNumber;
    private String roomType;
    private BigDecimal chargesPerDay;
    private Timestamp admissionDate;
    private Date expectedDischarge;
    private Timestamp dischargeDate;
    private String reason;
    private String status; // ADMITTED, DISCHARGED, TRANSFERRED
    private String dischargeSummary;
    private Timestamp createdAt;

    public Admission() {}

    public int getAdmissionId() {
        return admissionId;
    }

    public void setAdmissionId(int admissionId) {
        this.admissionId = admissionId;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public BigDecimal getChargesPerDay() {
        return chargesPerDay;
    }

    public void setChargesPerDay(BigDecimal chargesPerDay) {
        this.chargesPerDay = chargesPerDay;
    }

    public Timestamp getAdmissionDate() {
        return admissionDate;
    }

    public void setAdmissionDate(Timestamp admissionDate) {
        this.admissionDate = admissionDate;
    }

    public Date getExpectedDischarge() {
        return expectedDischarge;
    }

    public void setExpectedDischarge(Date expectedDischarge) {
        this.expectedDischarge = expectedDischarge;
    }

    public Timestamp getDischargeDate() {
        return dischargeDate;
    }

    public void setDischargeDate(Timestamp dischargeDate) {
        this.dischargeDate = dischargeDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDischargeSummary() {
        return dischargeSummary;
    }

    public void setDischargeSummary(String dischargeSummary) {
        this.dischargeSummary = dischargeSummary;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
