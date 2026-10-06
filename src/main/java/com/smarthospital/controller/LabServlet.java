package com.smarthospital.controller;

import com.smarthospital.dao.LabDAO;
import com.smarthospital.model.LabTest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Controller for Diagnostic Laboratory tests, report entries, and verification.
 */
@WebServlet(name = "LabServlet", urlPatterns = {"/lab"})
public class LabServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final LabDAO labDAO = new LabDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if ("view".equals(action)) {
            int testId = Integer.parseInt(req.getParameter("id"));
            LabTest test = labDAO.getLabTestById(testId);
            req.setAttribute("labTest", test);
            req.getRequestDispatcher("/common/lab_test_details.jsp").forward(req, resp);
        } else {
            req.setAttribute("labTests", labDAO.getAllLabTests());
            req.getRequestDispatcher("/common/lab_management.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if ("updateResult".equals(action)) {
            try {
                int testId = Integer.parseInt(req.getParameter("testId"));
                String result = req.getParameter("result");
                String normalRange = req.getParameter("normalRange");
                String remarks = req.getParameter("remarks");
                String status = req.getParameter("status");

                labDAO.updateLabResult(testId, result, normalRange, remarks, status);
                String referer = req.getHeader("Referer");
                resp.sendRedirect((referer != null ? referer : req.getContextPath() + "/") + "&msg=report_updated");
            } catch (Exception e) {
                String referer = req.getHeader("Referer");
                resp.sendRedirect((referer != null ? referer : req.getContextPath() + "/") + "&error=" +
                        java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
            }
        }
    }
}
