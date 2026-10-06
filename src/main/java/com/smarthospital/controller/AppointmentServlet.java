package com.smarthospital.controller;

import com.smarthospital.dao.AppointmentDAO;
import com.smarthospital.model.Appointment;
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

/**
 * Controller handling global appointment state transitions, rescheduling, and cancellations.
 */
@WebServlet(name = "AppointmentServlet", urlPatterns = {"/appointment"})
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final AppointmentService appointmentService = new AppointmentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if ("view".equals(action)) {
            int apptId = Integer.parseInt(req.getParameter("id"));
            Appointment appt = appointmentDAO.getAppointmentById(apptId);
            req.setAttribute("appointment", appt);
            req.getRequestDispatcher("/common/appointment_details.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/");
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
            if ("updateStatus".equals(action)) {
                int apptId = Integer.parseInt(req.getParameter("appointmentId"));
                String status = req.getParameter("status");
                appointmentService.updateStatus(apptId, status, userId, req.getRemoteAddr());
                sendRedirectBack(req, resp, "status_updated");

            } else if ("reschedule".equals(action)) {
                int apptId = Integer.parseInt(req.getParameter("appointmentId"));
                int doctorId = Integer.parseInt(req.getParameter("doctorId"));
                Date newDate = Date.valueOf(req.getParameter("newDate"));
                Time newTime = Time.valueOf(req.getParameter("newTime") + ":00");

                appointmentService.reschedule(apptId, newDate, newTime, doctorId, userId, req.getRemoteAddr());
                sendRedirectBack(req, resp, "appointment_rescheduled");
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
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}
