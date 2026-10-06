package com.smarthospital.filter;

import com.smarthospital.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter that enforces strict role-based access control (RBAC).
 * Prevents unauthorized users from tampering with URLs or crossing role boundaries.
 */
@WebFilter(filterName = "AuthorizationFilter", urlPatterns = {
        "/admin/*", "/doctor/*", "/patient/*", "/receptionist/*", "/nurse/*",
        "/admin", "/doctor", "/patient", "/receptionist", "/nurse"
})
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String relativePath = uri.substring(contextPath.length());
        String role = currentUser.getRoleName() != null ? currentUser.getRoleName().toUpperCase() : "";

        boolean authorized = true;

        if (relativePath.startsWith("/admin")) {
            authorized = "ADMIN".equals(role);
        } else if (relativePath.startsWith("/doctor")) {
            authorized = "DOCTOR".equals(role);
        } else if (relativePath.startsWith("/patient")) {
            authorized = "PATIENT".equals(role);
        } else if (relativePath.startsWith("/receptionist")) {
            authorized = "RECEPTIONIST".equals(role) || "ADMIN".equals(role);
        } else if (relativePath.startsWith("/nurse")) {
            authorized = "NURSE".equals(role) || "ADMIN".equals(role);
        }

        if (!authorized) {
            req.setAttribute("errorMessage", "Access Denied: You do not have permission to access " + relativePath);
            req.getRequestDispatcher("/errors/403.jsp").forward(req, resp);
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
