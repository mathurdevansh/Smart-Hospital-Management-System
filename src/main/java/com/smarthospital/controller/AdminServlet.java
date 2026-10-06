package com.smarthospital.controller;

import com.smarthospital.dao.AppointmentDAO;
import com.smarthospital.dao.AuditDAO;
import com.smarthospital.dao.BillingDAO;
import com.smarthospital.dao.DepartmentDAO;
import com.smarthospital.dao.DoctorDAO;
import com.smarthospital.dao.LabDAO;
import com.smarthospital.dao.MedicineDAO;
import com.smarthospital.dao.PatientDAO;
import com.smarthospital.dao.RoomDAO;
import com.smarthospital.dao.UserDAO;
import com.smarthospital.model.Department;
import com.smarthospital.model.Doctor;
import com.smarthospital.model.Patient;
import com.smarthospital.model.Room;
import com.smarthospital.model.User;
import com.smarthospital.util.PasswordUtil;
import com.smarthospital.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.Map;

/**
 * Controller for Administrator operations: Dashboards, User & Staff Management,
 * Departments, Rooms, Analytics, and Financial Reporting.
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();
    private final DoctorDAO doctorDAO = new DoctorDAO();
    private final PatientDAO patientDAO = new PatientDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();
    private final RoomDAO roomDAO = new RoomDAO();
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final BillingDAO billingDAO = new BillingDAO();
    private final MedicineDAO medicineDAO = new MedicineDAO();
    private final LabDAO labDAO = new LabDAO();
    private final AuditDAO auditDAO = new AuditDAO();

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
            case "users":
                showUsers(req, resp);
                break;
            case "doctors":
                showDoctors(req, resp);
                break;
            case "patients":
                showPatients(req, resp);
                break;
            case "departments":
                showDepartments(req, resp);
                break;
            case "rooms":
                showRooms(req, resp);
                break;
            case "billing":
                showBilling(req, resp);
                break;
            case "reports":
                showReports(req, resp);
                break;
            case "audit":
                showAuditLogs(req, resp);
                break;
            case "deactivateUser":
                handleDeactivateUser(req, resp);
                break;
            case "activateUser":
                handleActivateUser(req, resp);
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
            case "addUser":
                handleAddUser(req, resp);
                break;
            case "addDoctor":
                handleAddDoctor(req, resp);
                break;
            case "addPatient":
                handleAddPatient(req, resp);
                break;
            case "addDepartment":
                handleAddDepartment(req, resp);
                break;
            case "addRoom":
                handleAddRoom(req, resp);
                break;
            case "updateRoomStatus":
                handleUpdateRoomStatus(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin?action=dashboard");
                break;
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Map<String, Integer> counts = userDAO.getSystemCounts();
        BigDecimal totalRevenue = billingDAO.getTotalRevenue();

        req.setAttribute("counts", counts);
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("recentAppointments", appointmentDAO.getAllAppointments());
        req.setAttribute("recentLogs", auditDAO.getRecentLogs(10));
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }

    private void showUsers(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword != null && !keyword.trim().isEmpty()) {
            req.setAttribute("userList", userDAO.searchUsers(keyword));
            req.setAttribute("keyword", keyword);
        } else {
            req.setAttribute("userList", userDAO.getAllUsers());
        }
        req.setAttribute("roles", userDAO.getAllRoles());
        req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
    }

    private void showDoctors(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String deptIdStr = req.getParameter("deptId");
        Integer deptId = (deptIdStr != null && !deptIdStr.isEmpty()) ? Integer.parseInt(deptIdStr) : null;

        req.setAttribute("doctorList", doctorDAO.searchDoctors(keyword, deptId));
        req.setAttribute("departments", departmentDAO.getAllDepartments());
        req.getRequestDispatcher("/admin/doctors.jsp").forward(req, resp);
    }

    private void showPatients(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword != null && !keyword.trim().isEmpty()) {
            req.setAttribute("patientList", patientDAO.searchPatients(keyword));
            req.setAttribute("keyword", keyword);
        } else {
            req.setAttribute("patientList", patientDAO.getAllPatients());
        }
        req.getRequestDispatcher("/admin/patients.jsp").forward(req, resp);
    }

    private void showDepartments(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("departments", departmentDAO.getAllDepartments());
        req.getRequestDispatcher("/admin/departments.jsp").forward(req, resp);
    }

    private void showRooms(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("rooms", roomDAO.getAllRooms());
        req.getRequestDispatcher("/admin/rooms.jsp").forward(req, resp);
    }

    private void showBilling(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("bills", billingDAO.getAllBills());
        req.setAttribute("totalRevenue", billingDAO.getTotalRevenue());
        req.getRequestDispatcher("/admin/billing.jsp").forward(req, resp);
    }

    private void showReports(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String reportType = req.getParameter("type");
        if (reportType == null) {
            reportType = "revenue";
        }

        switch (reportType) {
            case "revenue":
                String from = req.getParameter("from");
                String to = req.getParameter("to");
                req.setAttribute("reportData", billingDAO.getRevenueReport(from, to));
                break;
            case "inventory":
                req.setAttribute("reportData", medicineDAO.getAllInventory());
                break;
            case "appointments":
                req.setAttribute("reportData", appointmentDAO.getAllAppointments());
                break;
            case "lab":
                req.setAttribute("reportData", labDAO.getAllLabTests());
                break;
            default:
                req.setAttribute("reportData", billingDAO.getAllBills());
                break;
        }

        req.setAttribute("selectedType", reportType);
        req.getRequestDispatcher("/admin/reports.jsp").forward(req, resp);
    }

    private void showAuditLogs(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("auditLogs", auditDAO.getRecentLogs(100));
        req.getRequestDispatcher("/admin/audit.jsp").forward(req, resp);
    }

    private void handleAddUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");
            int roleId = Integer.parseInt(req.getParameter("roleId"));

            User u = new User();
            u.setFullName(fullName);
            u.setEmail(email);
            u.setPasswordHash(PasswordUtil.hashPassword(password));
            u.setPhone(phone);
            u.setRoleId(roleId);
            u.setStatus("ACTIVE");

            userDAO.createUser(u);
            resp.sendRedirect(req.getContextPath() + "/admin?action=users&msg=user_created");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin?action=users&error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleAddDoctor(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            User u = new User();
            u.setFullName(req.getParameter("doctorName"));
            u.setEmail(req.getParameter("email"));
            u.setPasswordHash(PasswordUtil.hashPassword(req.getParameter("password")));
            u.setPhone(req.getParameter("phone"));

            Doctor d = new Doctor();
            d.setDepartmentId(Integer.parseInt(req.getParameter("departmentId")));
            d.setSpecialization(req.getParameter("specialization"));
            d.setQualification(req.getParameter("qualification"));
            d.setExperienceYears(Integer.parseInt(req.getParameter("experienceYears")));
            d.setConsultationFee(new BigDecimal(req.getParameter("consultationFee")));
            d.setRoomNo(req.getParameter("roomNo"));
            d.setAvailableDays(req.getParameter("availableDays"));
            d.setAvailableTime(req.getParameter("availableTime"));

            doctorDAO.createDoctorWithUser(d, u);
            resp.sendRedirect(req.getContextPath() + "/admin?action=doctors&msg=doctor_added");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin?action=doctors&error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleAddPatient(HttpServletRequest req, HttpServletResponse resp)
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
            resp.sendRedirect(req.getContextPath() + "/admin?action=patients&msg=patient_added");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin?action=patients&error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleAddDepartment(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            Department dept = new Department();
            dept.setName(name);
            dept.setDescription(description);
            dept.setStatus("ACTIVE");

            departmentDAO.createDepartment(dept);
            resp.sendRedirect(req.getContextPath() + "/admin?action=departments&msg=dept_added");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin?action=departments&error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleAddRoom(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            String roomNumber = req.getParameter("roomNumber");
            String roomType = req.getParameter("roomType");
            String floor = req.getParameter("floor");
            BigDecimal charges = new BigDecimal(req.getParameter("chargesPerDay"));

            Room r = new Room(0, roomNumber, roomType, floor, charges, "AVAILABLE");
            roomDAO.createRoom(r);
            resp.sendRedirect(req.getContextPath() + "/admin?action=rooms&msg=room_added");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin?action=rooms&error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleUpdateRoomStatus(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            String status = req.getParameter("status");
            roomDAO.updateRoomStatus(roomId, status);
            resp.sendRedirect(req.getContextPath() + "/admin?action=rooms&msg=status_updated");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin?action=rooms&error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void handleDeactivateUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        userDAO.updateStatus(userId, "INACTIVE");
        resp.sendRedirect(req.getContextPath() + "/admin?action=users&msg=user_deactivated");
    }

    private void handleActivateUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        userDAO.updateStatus(userId, "ACTIVE");
        resp.sendRedirect(req.getContextPath() + "/admin?action=users&msg=user_activated");
    }
}
