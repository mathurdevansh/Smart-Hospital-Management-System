package com.smarthospital.controller;

import com.smarthospital.dao.AppointmentDAO;
import com.smarthospital.dao.BillingDAO;
import com.smarthospital.dao.DoctorDAO;
import com.smarthospital.dao.LabDAO;
import com.smarthospital.dao.MedicalRecordDAO;
import com.smarthospital.dao.MedicineDAO;
import com.smarthospital.dao.PatientDAO;
import com.smarthospital.dao.PrescriptionDAO;
import com.smarthospital.model.Appointment;
import com.smarthospital.model.Bill;
import com.smarthospital.model.Doctor;
import com.smarthospital.model.LabTest;
import com.smarthospital.model.MedicalRecord;
import com.smarthospital.model.Patient;
import com.smarthospital.model.Prescription;
import com.smarthospital.model.PrescriptionItem;
import com.smarthospital.model.User;
import com.smarthospital.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 * Controller for Doctor portal: Patient consultations, Medical records,
 * E-Prescribing, and Diagnostic test orders.
 */
@WebServlet(name = "DoctorServlet", urlPatterns = {"/doctor"})
public class DoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final DoctorDAO doctorDAO = new DoctorDAO();
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final PatientDAO patientDAO = new PatientDAO();
    private final MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();
    private final PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
    private final MedicineDAO medicineDAO = new MedicineDAO();
    private final LabDAO labDAO = new LabDAO();
    private final BillingDAO billingDAO = new BillingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Doctor currentDoctor = getLoggedInDoctor(req);
        if (currentDoctor == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "dashboard";
        }

        switch (action) {
            case "dashboard":
                showDashboard(req, resp, currentDoctor);
                break;
            case "appointments":
                showAppointments(req, resp, currentDoctor);
                break;
            case "consultation":
                showConsultationForm(req, resp, currentDoctor);
                break;
            case "records":
                showRecords(req, resp, currentDoctor);
                break;
            case "prescriptions":
                showPrescriptions(req, resp, currentDoctor);
                break;
            case "lab":
                showLabReports(req, resp, currentDoctor);
                break;
            case "patientProfile":
                showPatientProfile(req, resp, currentDoctor);
                break;
            default:
                showDashboard(req, resp, currentDoctor);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Doctor currentDoctor = getLoggedInDoctor(req);
        if (currentDoctor == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "confirmAppointment":
                handleUpdateStatus(req, resp, "CONFIRMED");
                break;
            case "rejectAppointment":
                handleUpdateStatus(req, resp, "REJECTED");
                break;
            case "saveConsultation":
                handleSaveConsultation(req, resp, currentDoctor);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/doctor?action=dashboard");
                break;
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp, Doctor doc)
            throws ServletException, IOException {
        List<Appointment> todayAppts = appointmentDAO.getTodayAppointmentsForDoctor(doc.getDoctorId());
        List<Appointment> allAppts = appointmentDAO.getAppointmentsByDoctor(doc.getDoctorId(), "ALL");
        List<MedicalRecord> recentRecords = medicalRecordDAO.getRecordsByDoctor(doc.getDoctorId());

        long pendingCount = allAppts.stream().filter(a -> "PENDING".equalsIgnoreCase(a.getStatus())).count();
        long completedCount = allAppts.stream().filter(a -> "COMPLETED".equalsIgnoreCase(a.getStatus())).count();

        req.setAttribute("doctor", doc);
        req.setAttribute("todayAppointments", todayAppts);
        req.setAttribute("allAppointments", allAppts);
        req.setAttribute("recentRecords", recentRecords);
        req.setAttribute("pendingCount", pendingCount);
        req.setAttribute("completedCount", completedCount);

        req.getRequestDispatcher("/doctor/dashboard.jsp").forward(req, resp);
    }

    private void showAppointments(HttpServletRequest req, HttpServletResponse resp, Doctor doc)
            throws ServletException, IOException {
        String status = req.getParameter("status");
        req.setAttribute("appointments", appointmentDAO.getAppointmentsByDoctor(doc.getDoctorId(), status));
        req.setAttribute("selectedStatus", status != null ? status : "ALL");
        req.getRequestDispatcher("/doctor/appointments.jsp").forward(req, resp);
    }

    private void showConsultationForm(HttpServletRequest req, HttpServletResponse resp, Doctor doc)
            throws ServletException, IOException {
        int apptId = Integer.parseInt(req.getParameter("appointmentId"));
        Appointment appt = appointmentDAO.getAppointmentById(apptId);
        Patient patient = patientDAO.getPatientById(appt.getPatientId());

        req.setAttribute("appointment", appt);
        req.setAttribute("patient", patient);
        req.setAttribute("previousRecords", medicalRecordDAO.getRecordsByPatient(patient.getPatientId()));
        req.setAttribute("medicines", medicineDAO.getAllMedicines());
        req.getRequestDispatcher("/doctor/consultation.jsp").forward(req, resp);
    }

    private void showRecords(HttpServletRequest req, HttpServletResponse resp, Doctor doc)
            throws ServletException, IOException {
        req.setAttribute("records", medicalRecordDAO.getRecordsByDoctor(doc.getDoctorId()));
        req.getRequestDispatcher("/doctor/records.jsp").forward(req, resp);
    }

    private void showPrescriptions(HttpServletRequest req, HttpServletResponse resp, Doctor doc)
            throws ServletException, IOException {
        req.setAttribute("prescriptions", prescriptionDAO.getPrescriptionsByDoctor(doc.getDoctorId()));
        req.getRequestDispatcher("/doctor/prescriptions.jsp").forward(req, resp);
    }

    private void showLabReports(HttpServletRequest req, HttpServletResponse resp, Doctor doc)
            throws ServletException, IOException {
        req.setAttribute("labReports", labDAO.getLabTestsByDoctor(doc.getDoctorId()));
        req.getRequestDispatcher("/doctor/lab_reports.jsp").forward(req, resp);
    }

    private void showPatientProfile(HttpServletRequest req, HttpServletResponse resp, Doctor doc)
            throws ServletException, IOException {
        int patientId = Integer.parseInt(req.getParameter("patientId"));
        req.setAttribute("patient", patientDAO.getPatientById(patientId));
        req.setAttribute("records", medicalRecordDAO.getRecordsByPatient(patientId));
        req.setAttribute("prescriptions", prescriptionDAO.getPrescriptionsByPatient(patientId));
        req.setAttribute("labReports", labDAO.getLabTestsByPatient(patientId));
        req.getRequestDispatcher("/doctor/patient_profile.jsp").forward(req, resp);
    }

    private void handleUpdateStatus(HttpServletRequest req, HttpServletResponse resp, String status)
            throws IOException {
        int apptId = Integer.parseInt(req.getParameter("appointmentId"));
        appointmentDAO.updateStatus(apptId, status);
        resp.sendRedirect(req.getContextPath() + "/doctor?action=appointments&msg=status_updated");
    }

    private void handleSaveConsultation(HttpServletRequest req, HttpServletResponse resp, Doctor doc)
            throws IOException {
        try {
            int apptId = Integer.parseInt(req.getParameter("appointmentId"));
            int patientId = Integer.parseInt(req.getParameter("patientId"));
            String symptoms = req.getParameter("symptoms");
            String diagnosis = req.getParameter("diagnosis");
            String treatment = req.getParameter("treatment");
            String notes = req.getParameter("notes");
            String followUpStr = req.getParameter("followUpDate");

            // 1. Create Medical Record
            MedicalRecord record = new MedicalRecord();
            record.setAppointmentId(apptId);
            record.setPatientId(patientId);
            record.setDoctorId(doc.getDoctorId());
            record.setSymptoms(symptoms);
            record.setDiagnosis(diagnosis);
            record.setTreatment(treatment);
            record.setNotes(notes);
            if (ValidationUtil.isNotEmpty(followUpStr)) {
                record.setFollowUpDate(Date.valueOf(followUpStr));
            }
            int recordId = medicalRecordDAO.createRecord(record);

            // 2. Create Prescription if medicines added
            String[] medicineIds = req.getParameterValues("medicineId");
            String[] dosages = req.getParameterValues("dosage");
            String[] frequencies = req.getParameterValues("frequency");
            String[] durations = req.getParameterValues("duration");
            String[] instructions = req.getParameterValues("instruction");

            if (medicineIds != null && medicineIds.length > 0 && ValidationUtil.isNotEmpty(medicineIds[0])) {
                Prescription p = new Prescription();
                p.setRecordId(recordId);
                p.setPatientId(patientId);
                p.setDoctorId(doc.getDoctorId());
                p.setNotes(notes);

                for (int i = 0; i < medicineIds.length; i++) {
                    if (ValidationUtil.isNotEmpty(medicineIds[i])) {
                        int medId = Integer.parseInt(medicineIds[i]);
                        String dosage = (dosages != null && dosages.length > i) ? dosages[i] : "";
                        String freq = (frequencies != null && frequencies.length > i) ? frequencies[i] : "";
                        String dur = (durations != null && durations.length > i) ? durations[i] : "";
                        String inst = (instructions != null && instructions.length > i) ? instructions[i] : "";
                        p.addItem(new PrescriptionItem(medId, dosage, freq, dur, inst));
                    }
                }
                prescriptionDAO.createPrescription(p);
            }

            // 3. Create Lab Test if ordered
            String labTestName = req.getParameter("labTestName");
            if (ValidationUtil.isNotEmpty(labTestName)) {
                LabTest test = new LabTest();
                test.setPatientId(patientId);
                test.setDoctorId(doc.getDoctorId());
                test.setAppointmentId(apptId);
                test.setTestName(labTestName);
                test.setNormalRange(req.getParameter("labTestNormalRange"));
                test.setRemarks(req.getParameter("labTestRemarks"));
                test.setStatus("PENDING");
                labDAO.createLabTest(test);
            }

            // 4. Mark appointment as COMPLETED
            appointmentDAO.updateStatus(apptId, "COMPLETED");

            // 5. Generate Consultation Bill
            Bill bill = new Bill();
            bill.setPatientId(patientId);
            bill.setAppointmentId(apptId);
            bill.setConsultationCharges(doc.getConsultationFee());
            bill.calculateTotal();
            billingDAO.createBill(bill);

            resp.sendRedirect(req.getContextPath() + "/doctor?action=appointments&msg=consultation_completed");

        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/doctor?action=consultation&appointmentId=" +
                    req.getParameter("appointmentId") + "&error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private Doctor getLoggedInDoctor(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            User u = (User) session.getAttribute("currentUser");
            if ("DOCTOR".equalsIgnoreCase(u.getRoleName())) {
                return doctorDAO.getDoctorByUserId(u.getUserId());
            }
        }
        return null;
    }
}
