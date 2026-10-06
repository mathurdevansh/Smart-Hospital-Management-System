package com.smarthospital.controller;

import com.smarthospital.dao.PrescriptionDAO;
import com.smarthospital.model.Prescription;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Controller for retrieving and rendering printable clinical prescriptions.
 */
@WebServlet(name = "PrescriptionServlet", urlPatterns = {"/prescription"})
public class PrescriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final PrescriptionDAO prescriptionDAO = new PrescriptionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if ("view".equals(action) || "print".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Prescription presc = prescriptionDAO.getPrescriptionById(id);
            req.setAttribute("prescription", presc);
            req.getRequestDispatcher("/common/prescription_view.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}
