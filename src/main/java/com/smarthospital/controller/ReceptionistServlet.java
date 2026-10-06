package com.smarthospital.controller;

import com.smarthospital.dao.AppointmentDAO;
import com.smarthospital.dao.BillingDAO;
import com.smarthospital.dao.DepartmentDAO;
import com.smarthospital.dao.DoctorDAO;
import com.smarthospital.dao.PatientDAO;
import com.smarthospital.dao.RoomDAO;
import com.smarthospital.model.Appointment;
import com.smarthospital.model.Bill;
import com.smarthospital.model.Doctor;
import com.smarthospital.model.Patient;
import com.smarthospital.model.User;
import com.smarthospital.service.AppointmentService;
import com.smarthospital.service.BillingService;
import com.smarthospital.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

/**
 * Controller for Front-Desk Reception: Patient Registration, Centralized Scheduling,
 * Check-In / Check-Out, and Inpatient/Outpatient Cashiering.
 */
@WebServlet(name = "ReceptionistServlet", urlPatterns = {"/receptionist"})
public class ReceptionistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PatientDAO patientDAO = new PatientDAO();
    private final DoctorDAO doctorDAO = new DoctorDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final AppointmentService appointmentService = new AppointmentService();
    private final BillingDAO billingDAO = new BillingDAO();
    private final BillingService billingService = new BillingService();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "dashboard";
        }

        switch (action) {
            case "dashboard":
                showDashboard(req, resp);
                break;
            case "patients":
                showPatients(req, resp);
                break;
            case "registerPatient":
                showRegisterPatientForm(req, resp);
                break;
            case "appointments":
                showAppointments(req, resp);
                break;
            case "bookAppointment":
                showBookAppointmentForm(req, resp);
                break;
            case "billing":
                showBilling(req, resp);
                break;
            case "generateBill":
                showGenerateBillForm(req, resp);
                break;
            case "rooms":
                showRooms(req, resp);
                break;
            case "checkIn":
                handleCheckIn(req, resp);
                break;
            case "cancelAppointment":
                handleCancel(req, resp);
                break;
            default:
                showDashboard(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "registerPatient":
                handleRegisterPatient(req, resp);
                break;
            case "bookAppointment":
                handleBookAppointment(req, resp);
                break;
            case "rescheduleAppointment":
                handleRescheduleAppointment(req, resp);
                break;
            case "createBill":
                handleCreateBill(req, resp);
                break;
            case "recordPayment":
                handleRecordPayment(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/receptionist?action=dashboard");
                break;
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("patients", patientDAO.getAllPatients());
        req.setAttribute("appointments", appointmentDAO.getAllAppointments());
        req.setAttribute("availableRooms", roomDAO.getAvailableRooms());
        req.setAttribute("doctors", doctorDAO.getAllDoctors());
        req.getRequestDispatcher("/receptionist/dashboard.jsp").forward(req, resp);
    }

    private void showPatients(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword != null && !keyword.trim().isEmpty()) {
            req.setAttribute("patients", patientDAO.searchPatients(keyword));
            req.setAttribute("keyword", keyword);
        } else {
            req.setAttribute("patients", patientDAO.getAllPatients());
        }
        req.getRequestDispatcher("/receptionist/patients.jsp").forward(req, resp);
    }

    private void showRegisterPatientForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/receptionist/register_patient.jsp").forward(req, resp);
    }

    private void showAppointments(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String date = req.getParameter("date");
        String status = req.getParameter("status");
        req.setAttribute("appointments", appointmentDAO.filterAppointments(date, null, null, status));
        req.setAttribute("doctors", doctorDAO.getAllDoctors());
        req.getRequestDispatcher("/receptionist/appointments.jsp").forward(req, resp);
    }

    private void showBookAppointmentForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("patients", patientDAO.getAllPatients());
        req.setAttribute("doctors", doctorDAO.getAllDoctors());
        req.setAttribute("departments", departmentDAO.getAllDepartments());
        req.getRequestDispatcher("/receptionist/book_appointment.jsp").forward(req, resp);
    }

    private void showBilling(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("bills", billingDAO.getAllBills());
        req.getRequestDispatcher("/receptionist/billing.jsp").forward(req, resp);
    }

    private void showGenerateBillForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("patients", patientDAO.getAllPatients());
        req.getRequestDispatcher("/receptionist/generate_bill.jsp").forward(req, resp);
    }

    private void showRooms(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("rooms", roomDAO.getAllRooms());
        req.getRequestDispatcher("/receptionist/rooms.jsp").forward(req, resp);
    }

    private void handleCheckIn(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int apptId = Integer.parseInt(req.getParameter("appointmentId"));
        appointmentDAO.updateStatus(apptId, "CONFIRMED");
        resp.sendRedirect(req.getContextPath() + "/receptionist?action=appointments&msg=checked_in");
    }

    private void handleCancel(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int apptId = Integer.parseInt(req.getParameter("appointmentId"));
        appointmentDAO.updateStatus(apptId, "CANCELLED");
        resp.sendRedirect(req.getContextPath() + "/receptionist?action=appointments&msg=cancelled");
    }

    private void handleRegisterPatient(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            User u = new User();
            u.setFullName(req.getParameter("patientName"));
            u.setEmail(req.getParameter("email"));
            u.setPasswordHash(PasswordUtil.hashPassword(req.getParameter("password")));
            u.setPhone(req.getParameter("phone"));

            Patient p = new Patient();
            p.setDob(Date.valueOf(req.getParameter("dob")));
            p.setGender(req.getParameter("gender"));
            p.setBloodGroup(req.getParameter("bloodGroup"));
            p.setAddress(req.getParameter("address"));
            p.setEmergencyContactName(req.getParameter("emergencyContactName"));
            p.setEmergencyContactPhone(req.getParameter("emergencyContactPhone"));
            p.setMedicalHistorySummary(req.getParameter("medicalHistorySummary"));

            patientDAO.createPatientWithUser(p, u);
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=patients&msg=patient_registered");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=registerPatient&error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleBookAppointment(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            int patientId = Integer.parseInt(req.getParameter("patientId"));
            int doctorId = Integer.parseInt(req.getParameter("doctorId"));
            int deptId = Integer.parseInt(req.getParameter("departmentId"));
            Date date = Date.valueOf(req.getParameter("appointmentDate"));
            Time time = Time.valueOf(req.getParameter("appointmentTime") + ":00");
            String reason = req.getParameter("reason");

            Appointment appt = new Appointment();
            appt.setPatientId(patientId);
            appt.setDoctorId(doctorId);
            appt.setDepartmentId(deptId);
            appt.setAppointmentDate(date);
            appt.setAppointmentTime(time);
            appt.setReason(reason);
            appt.setStatus("CONFIRMED"); // Auto confirmed when booked at desk

            appointmentService.bookAppointment(appt, null, req.getRemoteAddr());
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=appointments&msg=booked_successfully");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=bookAppointment&error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleRescheduleAppointment(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            int apptId = Integer.parseInt(req.getParameter("appointmentId"));
            int doctorId = Integer.parseInt(req.getParameter("doctorId"));
            Date newDate = Date.valueOf(req.getParameter("newDate"));
            Time newTime = Time.valueOf(req.getParameter("newTime") + ":00");

            appointmentService.reschedule(apptId, newDate, newTime, doctorId, null, req.getRemoteAddr());
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=appointments&msg=rescheduled");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=appointments&error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleCreateBill(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            int patientId = Integer.parseInt(req.getParameter("patientId"));
            BigDecimal consultation = new BigDecimal(req.getParameter("consultationCharges"));
            BigDecimal medicine = new BigDecimal(req.getParameter("medicineCharges"));
            BigDecimal lab = new BigDecimal(req.getParameter("labCharges"));
            BigDecimal room = new BigDecimal(req.getParameter("roomCharges"));
            BigDecimal other = new BigDecimal(req.getParameter("otherCharges"));
            BigDecimal discount = new BigDecimal(req.getParameter("discount"));
            BigDecimal tax = new BigDecimal(req.getParameter("tax"));

            Bill bill = new Bill();
            bill.setPatientId(patientId);
            bill.setConsultationCharges(consultation);
            bill.setMedicineCharges(medicine);
            bill.setLabCharges(lab);
            bill.setRoomCharges(room);
            bill.setOtherCharges(other);
            bill.setDiscount(discount);
            bill.setTax(tax);
            bill.calculateTotal();

            billingService.generateBill(bill, null, req.getRemoteAddr());
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=billing&msg=bill_generated");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=generateBill&error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleRecordPayment(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            int billId = Integer.parseInt(req.getParameter("billId"));
            String mode = req.getParameter("paymentMode");
            BigDecimal amount = new BigDecimal(req.getParameter("amountPaid"));
            String ref = req.getParameter("transactionReference");

            billingService.processPayment(billId, mode, amount, ref, null, req.getRemoteAddr());
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=billing&msg=payment_recorded");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/receptionist?action=billing&error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
