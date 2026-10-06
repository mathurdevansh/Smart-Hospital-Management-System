package com.smarthospital.controller;

import com.smarthospital.dao.BillingDAO;
import com.smarthospital.model.Bill;
import com.smarthospital.model.User;
import com.smarthospital.service.BillingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;

/**
 * Controller handling invoice rendering, printable statements, and payment settlement.
 */
@WebServlet(name = "BillingServlet", urlPatterns = {"/billing"})
public class BillingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final BillingDAO billingDAO = new BillingDAO();
    private final BillingService billingService = new BillingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if ("invoice".equals(action)) {
            String idStr = req.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                idStr = req.getParameter("billId");
            }
            int billId = (idStr != null) ? Integer.parseInt(idStr.trim()) : 1;
            Bill bill = billingDAO.getBillById(billId);
            req.setAttribute("bill", bill);
            req.getRequestDispatcher("/common/invoice.jsp").forward(req, resp);
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
        if ("recordPayment".equals(action)) {
            try {
                int billId = Integer.parseInt(req.getParameter("billId"));
                String mode = req.getParameter("paymentMode");
                BigDecimal amount = new BigDecimal(req.getParameter("amountPaid"));
                String ref = req.getParameter("transactionReference");

                billingService.processPayment(billId, mode, amount, ref, userId, req.getRemoteAddr());
                String referer = req.getHeader("Referer");
                resp.sendRedirect((referer != null ? referer : req.getContextPath() + "/") + "&msg=payment_successful");
            } catch (Exception e) {
                String referer = req.getHeader("Referer");
                resp.sendRedirect((referer != null ? referer : req.getContextPath() + "/") + "&error=" +
                        java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
            }
        }
    }
}
