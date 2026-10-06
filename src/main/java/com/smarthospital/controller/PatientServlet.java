package com.smarthospital.controller;

import com.smarthospital.dao.AppointmentDAO;
import com.smarthospital.dao.BillingDAO;
import com.smarthospital.dao.DepartmentDAO;
import com.smarthospital.dao.DoctorDAO;
import com.smarthospital.dao.FeedbackDAO;
import com.smarthospital.dao.LabDAO;
import com.smarthospital.dao.MedicalRecordDAO;
import com.smarthospital.dao.PatientDAO;
import com.smarthospital.dao.PrescriptionDAO;
import com.smarthospital.model.Appointment;
import com.smarthospital.model.Bill;
import com.smarthospital.model.Feedback;
import com.smarthospital.model.Patient;
import com.smarthospital.model.User;
import com.smarthospital.service.AppointmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

/**
 * Controller for Patient Portal: Personal health record access, Self-service
 * appointment scheduling, e-Prescriptions, Invoices, and Doctor reviews.
 */
@WebServlet(name = "PatientServlet", urlPatterns = {"/patient"})
public class PatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PatientDAO patientDAO = new PatientDAO();
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final AppointmentService appointmentService = new AppointmentService();
    private final DoctorDAO doctorDAO = new DoctorDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();
    private final MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();
    private final PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
    private final LabDAO labDAO = new LabDAO();
    private final BillingDAO billingDAO = new BillingDAO();
    private final FeedbackDAO feedbackDAO = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Patient currentPatient = getLoggedInPatient(req);
        if (currentPatient == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "dashboard";
        }

        switch (action) {
            case "dashboard":
                showDashboard(req, resp, currentPatient);
                break;
            case "bookAppointment":
                showBookingForm(req, resp, currentPatient);
                break;
            case "myAppointments":
                showMyAppointments(req, resp, currentPatient);
                break;
            case "records":
                showMedicalRecords(req, resp, currentPatient);
                break;
            case "prescriptions":
                showPrescriptions(req, resp, currentPatient);
                break;
            case "labReports":
                showLabReports(req, resp, currentPatient);
                break;
            case "bills":
                showBills(req, resp, currentPatient);
                break;
            case "billInvoice":
                showBillInvoice(req, resp, currentPatient);
                break;
            case "feedback":
                showFeedbackForm(req, resp, currentPatient);
                break;
            case "profile":
                showProfile(req, resp, currentPatient);
                break;
            case "cancelAppointment":
                handleCancelAppointment(req, resp, currentPatient);
                break;
            default:
                showDashboard(req, resp, currentPatient);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Patient currentPatient = getLoggedInPatient(req);
        if (currentPatient == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "bookAppointment":
                handleBookAppointment(req, resp, currentPatient);
                break;
            case "updateProfile":
                handleUpdateProfile(req, resp, currentPatient);
                break;
            case "submitFeedback":
                handleSubmitFeedback(req, resp, currentPatient);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/patient?action=dashboard");
                break;
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        List<Appointment> appts = appointmentDAO.getAppointmentsByPatient(patient.getPatientId());
        req.setAttribute("patient", patient);
        req.setAttribute("appointments", appts);
        req.setAttribute("recentRecords", medicalRecordDAO.getRecordsByPatient(patient.getPatientId()));
        req.setAttribute("recentPrescriptions", prescriptionDAO.getPrescriptionsByPatient(patient.getPatientId()));
        req.setAttribute("recentLabReports", labDAO.getLabTestsByPatient(patient.getPatientId()));
        req.setAttribute("bills", billingDAO.getBillsByPatient(patient.getPatientId()));
        req.getRequestDispatcher("/patient/dashboard.jsp").forward(req, resp);
    }

    private void showBookingForm(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        req.setAttribute("departments", departmentDAO.getAllDepartments());
        req.setAttribute("doctors", doctorDAO.getAllDoctors());
        req.getRequestDispatcher("/patient/book_appointment.jsp").forward(req, resp);
    }

    private void showMyAppointments(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        req.setAttribute("appointments", appointmentDAO.getAppointmentsByPatient(patient.getPatientId()));
        req.getRequestDispatcher("/patient/appointments.jsp").forward(req, resp);
    }

    private void showMedicalRecords(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        req.setAttribute("records", medicalRecordDAO.getRecordsByPatient(patient.getPatientId()));
        req.getRequestDispatcher("/patient/medical_records.jsp").forward(req, resp);
    }

    private void showPrescriptions(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        req.setAttribute("prescriptions", prescriptionDAO.getPrescriptionsByPatient(patient.getPatientId()));
        req.getRequestDispatcher("/patient/prescriptions.jsp").forward(req, resp);
    }

    private void showLabReports(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        req.setAttribute("labReports", labDAO.getLabTestsByPatient(patient.getPatientId()));
        req.getRequestDispatcher("/patient/lab_reports.jsp").forward(req, resp);
    }

    private void showBills(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        req.setAttribute("bills", billingDAO.getBillsByPatient(patient.getPatientId()));
        req.getRequestDispatcher("/patient/bills.jsp").forward(req, resp);
    }

    private void showBillInvoice(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        int billId = Integer.parseInt(req.getParameter("billId"));
        Bill bill = billingDAO.getBillById(billId);

        // Security verification: Ensure patient owns this bill
        if (bill == null || bill.getPatientId() != patient.getPatientId()) {
            resp.sendRedirect(req.getContextPath() + "/patient?action=bills&error=access_denied");
            return;
        }

        req.setAttribute("bill", bill);
        req.getRequestDispatcher("/patient/invoice.jsp").forward(req, resp);
    }

    private void showFeedbackForm(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        req.setAttribute("doctors", doctorDAO.getAllDoctors());
        req.getRequestDispatcher("/patient/feedback.jsp").forward(req, resp);
    }

    private void showProfile(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        req.setAttribute("patient", patientDAO.getPatientById(patient.getPatientId()));
        req.getRequestDispatcher("/patient/profile.jsp").forward(req, resp);
    }

    private void handleBookAppointment(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws IOException {
        try {
            int doctorId = Integer.parseInt(req.getParameter("doctorId"));
            int deptId = Integer.parseInt(req.getParameter("departmentId"));
            Date apptDate = Date.valueOf(req.getParameter("appointmentDate"));
            Time apptTime = Time.valueOf(req.getParameter("appointmentTime") + ":00");
            String reason = req.getParameter("reason");

            Appointment appt = new Appointment();
            appt.setPatientId(patient.getPatientId());
            appt.setDoctorId(doctorId);
            appt.setDepartmentId(deptId);
            appt.setAppointmentDate(apptDate);
            appt.setAppointmentTime(apptTime);
            appt.setReason(reason);
            appt.setStatus("PENDING");

            appointmentService.bookAppointment(appt, patient.getUserId(), req.getRemoteAddr());
            resp.sendRedirect(req.getContextPath() + "/patient?action=myAppointments&msg=appointment_booked");

        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/patient?action=bookAppointment&error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleCancelAppointment(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws IOException {
        int apptId = Integer.parseInt(req.getParameter("appointmentId"));
        Appointment appt = appointmentDAO.getAppointmentById(apptId);

        // Security check
        if (appt != null && appt.getPatientId() == patient.getPatientId()) {
            appointmentDAO.updateStatus(apptId, "CANCELLED");
        }
        resp.sendRedirect(req.getContextPath() + "/patient?action=myAppointments&msg=appointment_cancelled");
    }

    private void handleUpdateProfile(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws IOException {
        try {
            patient.setPatientName(req.getParameter("patientName"));
            patient.setPhone(req.getParameter("phone"));
            patient.setDob(Date.valueOf(req.getParameter("dob")));
            patient.setGender(req.getParameter("gender"));
            patient.setBloodGroup(req.getParameter("bloodGroup"));
            patient.setAddress(req.getParameter("address"));
            patient.setEmergencyContactName(req.getParameter("emergencyContactName"));
            patient.setEmergencyContactPhone(req.getParameter("emergencyContactPhone"));
            patient.setMedicalHistorySummary(req.getParameter("medicalHistorySummary"));

            patientDAO.updatePatient(patient);
            resp.sendRedirect(req.getContextPath() + "/patient?action=profile&msg=profile_updated");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/patient?action=profile&error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleSubmitFeedback(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws IOException {
        try {
            String docIdStr = req.getParameter("doctorId");
            Integer docId = (docIdStr != null && !docIdStr.isEmpty()) ? Integer.parseInt(docIdStr) : null;
            int rating = Integer.parseInt(req.getParameter("rating"));
            String comments = req.getParameter("comments");

            Feedback fb = new Feedback();
            fb.setPatientId(patient.getPatientId());
            fb.setDoctorId(docId);
            fb.setRating(rating);
            fb.setComments(comments);

            feedbackDAO.createFeedback(fb);
            resp.sendRedirect(req.getContextPath() + "/patient?action=feedback&msg=feedback_submitted");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/patient?action=feedback&error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private Patient getLoggedInPatient(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            User u = (User) session.getAttribute("currentUser");
            if ("PATIENT".equalsIgnoreCase(u.getRoleName())) {
                return patientDAO.getPatientByUserId(u.getUserId());
            }
        }
        return null;
    }
}
