package com.smarthospital.controller;

import com.smarthospital.dao.MedicineDAO;
import com.smarthospital.model.Medicine;
import com.smarthospital.model.MedicineInventory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

/**
 * Controller for Medicine catalog, Pharmacy inventory, and Batch restocking.
 */
@WebServlet(name = "MedicineServlet", urlPatterns = {"/inventory"})
public class MedicineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final MedicineDAO medicineDAO = new MedicineDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("medicines", medicineDAO.getAllMedicines());
        req.setAttribute("inventory", medicineDAO.getAllInventory());
        req.setAttribute("lowStock", medicineDAO.getLowStockItems());
        req.setAttribute("expiring", medicineDAO.getExpiringItems());
        req.getRequestDispatcher("/common/inventory.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        try {
            if ("addMedicine".equals(action)) {
                String name = req.getParameter("medicineName");
                String cat = req.getParameter("category");
                String mfr = req.getParameter("manufacturer");
                BigDecimal price = new BigDecimal(req.getParameter("price"));
                String desc = req.getParameter("description");

                Medicine m = new Medicine(0, name, cat, mfr, price, desc);
                medicineDAO.createMedicine(m);
                resp.sendRedirect(req.getContextPath() + "/inventory?msg=medicine_added");

            } else if ("addBatch".equals(action)) {
                int medId = Integer.parseInt(req.getParameter("medicineId"));
                String batch = req.getParameter("batchNumber");
                int qty = Integer.parseInt(req.getParameter("quantity"));
                int reorder = Integer.parseInt(req.getParameter("reorderLevel"));
                Date expiry = Date.valueOf(req.getParameter("expiryDate"));

                MedicineInventory inv = new MedicineInventory();
                inv.setMedicineId(medId);
                inv.setBatchNumber(batch);
                inv.setQuantity(qty);
                inv.setReorderLevel(reorder);
                inv.setExpiryDate(expiry);

                medicineDAO.addStockBatch(inv);
                resp.sendRedirect(req.getContextPath() + "/inventory?msg=batch_added");

            } else if ("updateQuantity".equals(action)) {
                int invId = Integer.parseInt(req.getParameter("inventoryId"));
                int qty = Integer.parseInt(req.getParameter("quantity"));

                medicineDAO.updateBatchQuantity(invId, qty);
                resp.sendRedirect(req.getContextPath() + "/inventory?msg=stock_updated");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/inventory?error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}
