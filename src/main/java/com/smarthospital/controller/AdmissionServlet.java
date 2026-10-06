package com.smarthospital.controller;

import com.smarthospital.dao.DoctorDAO;
import com.smarthospital.dao.PatientDAO;
import com.smarthospital.dao.RoomDAO;
import com.smarthospital.model.Admission;
import com.smarthospital.model.User;
import com.smarthospital.service.AdmissionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;

/**
 * Controller for In-Patient Admissions, Ward Bed allocations, and Discharges.
 */
@WebServlet(name = "AdmissionServlet", urlPatterns = {"/admission"})
public class AdmissionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AdmissionService admissionService = new AdmissionService();
    private final PatientDAO patientDAO = new PatientDAO();
    private final DoctorDAO doctorDAO = new DoctorDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if ("new".equals(action)) {
            req.setAttribute("patients", patientDAO.getAllPatients());
            req.setAttribute("doctors", doctorDAO.getAllDoctors());
            req.setAttribute("availableRooms", roomDAO.getAvailableRooms());
            req.getRequestDispatcher("/common/admit_patient.jsp").forward(req, resp);
        } else {
            req.setAttribute("admissions", admissionService.getAllAdmissions());
            req.getRequestDispatcher("/common/admission_list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        Integer userId = (user != null) ? user.getUserId() : null;

        String action = req.getParameter("action");
        try {
            if ("admit".equals(action)) {
                int patientId = Integer.parseInt(req.getParameter("patientId"));
                int doctorId = Integer.parseInt(req.getParameter("doctorId"));
                int roomId = Integer.parseInt(req.getParameter("roomId"));
                String expDateStr = req.getParameter("expectedDischarge");
                String reason = req.getParameter("reason");

                Admission adm = new Admission();
                adm.setPatientId(patientId);
                adm.setDoctorId(doctorId);
                adm.setRoomId(roomId);
                if (expDateStr != null && !expDateStr.trim().isEmpty()) {
                    adm.setExpectedDischarge(Date.valueOf(expDateStr));
                }
                adm.setReason(reason);

                admissionService.admitPatient(adm, userId, req.getRemoteAddr());
                sendRedirectBack(req, resp, "patient_admitted");

            } else if ("discharge".equals(action)) {
                int admissionId = Integer.parseInt(req.getParameter("admissionId"));
                int roomId = Integer.parseInt(req.getParameter("roomId"));
                String summary = req.getParameter("dischargeSummary");

                admissionService.dischargePatient(admissionId, roomId, summary, userId, req.getRemoteAddr());
                sendRedirectBack(req, resp, "patient_discharged");
            }
        } catch (Exception e) {
            String referer = req.getHeader("Referer");
            resp.sendRedirect((referer != null ? referer : req.getContextPath() + "/") + "&error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void sendRedirectBack(HttpServletRequest req, HttpServletResponse resp, String msg) throws IOException {
        String referer = req.getHeader("Referer");
        if (referer != null) {
            resp.sendRedirect(referer + (referer.contains("?") ? "&" : "?") + "msg=" + msg);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin?action=rooms");
        }
    }
}
