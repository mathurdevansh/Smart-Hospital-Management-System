package com.smarthospital.controller;

import com.smarthospital.exception.ApplicationException;
import com.smarthospital.model.User;
import com.smarthospital.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Controller handling user authentication and role-based dashboard redirection.
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            User user = (User) session.getAttribute("currentUser");
            redirectToDashboard(req, resp, user.getRoleName());
            return;
        }

        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        String ipAddress = req.getRemoteAddr();

        try {
            User user = authService.login(email, password, role, ipAddress);

            // Session Fixation Prevention: Invalidate old session and create fresh session
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession newSession = req.getSession(true);
            newSession.setMaxInactiveInterval(30 * 60); // 30 minutes timeout
            newSession.setAttribute("currentUser", user);
            newSession.setAttribute("userProfile", authService.getRoleSpecificProfile(user));

            redirectToDashboard(req, resp, user.getRoleName());

        } catch (ApplicationException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("enteredEmail", email);
            req.setAttribute("selectedRole", role);
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("errorMessage", "An unexpected system error occurred. Please try again.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }

    private void redirectToDashboard(HttpServletRequest req, HttpServletResponse resp, String roleName)
            throws IOException {
        String cp = req.getContextPath();
        if (roleName == null) {
            resp.sendRedirect(cp + "/login.jsp");
            return;
        }

        switch (roleName.toUpperCase()) {
            case "ADMIN":
                resp.sendRedirect(cp + "/admin");
                break;
            case "DOCTOR":
                resp.sendRedirect(cp + "/doctor");
                break;
            case "RECEPTIONIST":
                resp.sendRedirect(cp + "/receptionist");
                break;
            case "NURSE":
                resp.sendRedirect(cp + "/nurse");
                break;
            case "PATIENT":
                resp.sendRedirect(cp + "/patient");
                break;
            default:
                resp.sendRedirect(cp + "/login.jsp");
                break;
        }
    }
}
