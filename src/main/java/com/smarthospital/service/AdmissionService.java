package com.smarthospital.service;

import com.smarthospital.dao.AdmissionDAO;
import com.smarthospital.dao.AuditDAO;
import com.smarthospital.exception.ApplicationException;
import com.smarthospital.model.Admission;
import com.smarthospital.util.ValidationUtil;

import java.util.List;

/**
 * Service orchestrating patient hospitalizations, ward bed allocations, and discharges.
 */
public class AdmissionService {

    private final AdmissionDAO admissionDAO = new AdmissionDAO();
    private final AuditDAO auditDAO = new AuditDAO();

    public boolean admitPatient(Admission admission, Integer staffUserId, String ipAddress) {
        if (admission.getPatientId() <= 0) {
            throw new ApplicationException("Patient selection is required.");
        }
        if (admission.getDoctorId() <= 0) {
            throw new ApplicationException("Attending doctor is required.");
        }
        if (admission.getRoomId() <= 0) {
            throw new ApplicationException("Room assignment is required.");
        }
        if (!ValidationUtil.isNotEmpty(admission.getReason())) {
            throw new ApplicationException("Reason for admission is required.");
        }

        boolean success = admissionDAO.admitPatient(admission);
        if (success) {
            auditDAO.log(staffUserId, "PATIENT_ADMITTED", "Patient #" + admission.getPatientId() + " admitted to room #" + admission.getRoomId(), ipAddress);
        }
        return success;
    }

    public boolean dischargePatient(int admissionId, int roomId, String dischargeSummary, Integer staffUserId, String ipAddress) {
        if (admissionId <= 0 || roomId <= 0) {
            throw new ApplicationException("Valid admission and room references are required.");
        }
        if (!ValidationUtil.isNotEmpty(dischargeSummary)) {
            throw new ApplicationException("Discharge summary and final doctor remarks are required.");
        }

        boolean success = admissionDAO.dischargePatient(admissionId, roomId, dischargeSummary);
        if (success) {
            auditDAO.log(staffUserId, "PATIENT_DISCHARGED", "Discharged admission #" + admissionId + " and released room #" + roomId, ipAddress);
        }
        return success;
    }

    public List<Admission> getActiveAdmissions() {
        return admissionDAO.getActiveAdmissions();
    }

    public List<Admission> getAllAdmissions() {
        return admissionDAO.getAllAdmissions();
    }

    public List<Admission> getAdmissionsByPatient(int patientId) {
        return admissionDAO.getAdmissionsByPatient(patientId);
    }
}
