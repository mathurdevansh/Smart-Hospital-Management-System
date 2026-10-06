package com.smarthospital.controller;

import com.smarthospital.dao.AdmissionDAO;
import com.smarthospital.dao.MedicalRecordDAO;
import com.smarthospital.dao.PatientDAO;
import com.smarthospital.dao.VitalDAO;
import com.smarthospital.model.Admission;
import com.smarthospital.model.Nurse;
import com.smarthospital.model.Patient;
import com.smarthospital.model.PatientVital;
import com.smarthospital.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * Controller for Clinical Nursing Staff: Patient Vital Monitoring, Inpatient Wards,
 * Bedside telemetry, and Nursing Encounter notes.
 */
@WebServlet(name = "NurseServlet", urlPatterns = {"/nurse"})
public class NurseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final VitalDAO vitalDAO = new VitalDAO();
    private final AdmissionDAO admissionDAO = new AdmissionDAO();
    private final PatientDAO patientDAO = new PatientDAO();
    private final MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Nurse currentNurse = getLoggedInNurse(req);
        if (currentNurse == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "dashboard";
        }

        switch (action) {
            case "dashboard":
                showDashboard(req, resp, currentNurse);
                break;
            case "patients":
                showInpatients(req, resp, currentNurse);
                break;
            case "recordVitals":
                showRecordVitalsForm(req, resp, currentNurse);
                break;
            case "viewVitals":
                showPatientVitals(req, resp, currentNurse);
                break;
            default:
                showDashboard(req, resp, currentNurse);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Nurse currentNurse = getLoggedInNurse(req);
        if (currentNurse == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getParameter("action");
        if ("saveVitals".equals(action)) {
            handleSaveVitals(req, resp, currentNurse);
        } else {
            resp.sendRedirect(req.getContextPath() + "/nurse?action=dashboard");
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp, Nurse nurse)
            throws ServletException, IOException {
        List<Admission> activeAdmissions = admissionDAO.getActiveAdmissions();
        req.setAttribute("nurse", nurse);
        req.setAttribute("admissions", activeAdmissions);
        req.getRequestDispatcher("/nurse/dashboard.jsp").forward(req, resp);
    }

    private void showInpatients(HttpServletRequest req, HttpServletResponse resp, Nurse nurse)
            throws ServletException, IOException {
        req.setAttribute("admissions", admissionDAO.getActiveAdmissions());
        req.getRequestDispatcher("/nurse/patients.jsp").forward(req, resp);
    }

    private void showRecordVitalsForm(HttpServletRequest req, HttpServletResponse resp, Nurse nurse)
            throws ServletException, IOException {
        int patientId = Integer.parseInt(req.getParameter("patientId"));
        Patient patient = patientDAO.getPatientById(patientId);
        List<PatientVital> history = vitalDAO.getVitalsByPatient(patientId);

        req.setAttribute("patient", patient);
        req.setAttribute("vitalsHistory", history);
        req.getRequestDispatcher("/nurse/record_vitals.jsp").forward(req, resp);
    }

    private void showPatientVitals(HttpServletRequest req, HttpServletResponse resp, Nurse nurse)
            throws ServletException, IOException {
        int patientId = Integer.parseInt(req.getParameter("patientId"));
        req.setAttribute("patient", patientDAO.getPatientById(patientId));
        req.setAttribute("vitalsList", vitalDAO.getVitalsByPatient(patientId));
        req.setAttribute("records", medicalRecordDAO.getRecordsByPatient(patientId));
        req.getRequestDispatcher("/nurse/vitals_view.jsp").forward(req, resp);
    }

    private void handleSaveVitals(HttpServletRequest req, HttpServletResponse resp, Nurse nurse)
            throws IOException {
        try {
            int patientId = Integer.parseInt(req.getParameter("patientId"));
            BigDecimal temperature = new BigDecimal(req.getParameter("temperature"));
            String bp = req.getParameter("bloodPressure");
            int pulse = Integer.parseInt(req.getParameter("pulse"));
            int spo2 = Integer.parseInt(req.getParameter("oxygenLevel"));
            String notes = req.getParameter("notes");

            PatientVital vital = new PatientVital();
            vital.setPatientId(patientId);
            vital.setNurseId(nurse.getNurseId());
            vital.setTemperature(temperature);
            vital.setBloodPressure(bp);
            vital.setPulse(pulse);
            vital.setOxygenLevel(spo2);
            vital.setNotes(notes);

            vitalDAO.recordVitals(vital);
            resp.sendRedirect(req.getContextPath() + "/nurse?action=viewVitals&patientId=" + patientId + "&msg=vitals_saved");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/nurse?action=recordVitals&patientId=" +
                    req.getParameter("patientId") + "&error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private Nurse getLoggedInNurse(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            User u = (User) session.getAttribute("currentUser");
            if ("NURSE".equalsIgnoreCase(u.getRoleName()) || "ADMIN".equalsIgnoreCase(u.getRoleName())) {
                Nurse n = vitalDAO.getNurseByUserId(u.getUserId());
                if (n == null && "ADMIN".equalsIgnoreCase(u.getRoleName())) {
                    // Fallback stub for Admin previewing Nurse view
                    n = new Nurse();
                    n.setNurseId(1);
                    n.setNurseName(u.getFullName());
                }
                return n;
            }
        }
        return null;
    }
}
