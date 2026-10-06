package com.smarthospital.service;

import com.smarthospital.dao.AppointmentDAO;
import com.smarthospital.dao.AuditDAO;
import com.smarthospital.exception.ApplicationException;
import com.smarthospital.model.Appointment;
import com.smarthospital.util.ValidationUtil;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

/**
 * Service managing appointment scheduling, validation, double-booking prevention, and lifecycle state changes.
 */
public class AppointmentService {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final AuditDAO auditDAO = new AuditDAO();

    public int bookAppointment(Appointment appt, Integer bookedByUserId, String ipAddress) {
        if (appt.getPatientId() <= 0) {
            throw new ApplicationException("Valid patient is required.");
        }
        if (appt.getDoctorId() <= 0) {
            throw new ApplicationException("Please select a doctor.");
        }
        if (appt.getAppointmentDate() == null) {
            throw new ApplicationException("Appointment date is required.");
        }
        if (appt.getAppointmentTime() == null) {
            throw new ApplicationException("Appointment time is required.");
        }
        if (!ValidationUtil.isNotEmpty(appt.getReason())) {
            throw new ApplicationException("Please describe the medical reason for this consultation.");
        }

        // Double-booking check: Ensure doctor doesn't have an active consultation at that time
        boolean booked = appointmentDAO.isSlotBooked(appt.getDoctorId(), appt.getAppointmentDate(), appt.getAppointmentTime(), null);
        if (booked) {
            throw new ApplicationException("The selected doctor already has a booked appointment at this date and time. Please pick another slot.");
        }

        int id = appointmentDAO.createAppointment(appt);
        auditDAO.log(bookedByUserId, "APPOINTMENT_BOOKED", "Booked appointment #" + id + " for doctor ID " + appt.getDoctorId(), ipAddress);
        return id;
    }

    public boolean reschedule(int apptId, Date newDate, Time newTime, int doctorId, Integer updatedByUserId, String ipAddress) {
        if (newDate == null || newTime == null) {
            throw new ApplicationException("New date and time are required.");
        }

        boolean booked = appointmentDAO.isSlotBooked(doctorId, newDate, newTime, apptId);
        if (booked) {
            throw new ApplicationException("Doctor already has another appointment booked for this slot.");
        }

        boolean success = appointmentDAO.reschedule(apptId, newDate, newTime);
        if (success) {
            auditDAO.log(updatedByUserId, "APPOINTMENT_RESCHEDULED", "Rescheduled appointment #" + apptId + " to " + newDate + " " + newTime, ipAddress);
        }
        return success;
    }

    public boolean updateStatus(int apptId, String newStatus, Integer updatedByUserId, String ipAddress) {
        boolean success = appointmentDAO.updateStatus(apptId, newStatus);
        if (success) {
            auditDAO.log(updatedByUserId, "APPOINTMENT_STATUS_CHANGED", "Appointment #" + apptId + " status updated to " + newStatus, ipAddress);
        }
        return success;
    }

    public List<Appointment> getAppointmentsByDoctor(int doctorId, String status) {
        return appointmentDAO.getAppointmentsByDoctor(doctorId, status);
    }

    public List<Appointment> getAppointmentsByPatient(int patientId) {
        return appointmentDAO.getAppointmentsByPatient(patientId);
    }

    public List<Appointment> getAllAppointments() {
        return appointmentDAO.getAllAppointments();
    }
}
