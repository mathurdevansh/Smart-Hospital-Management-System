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
 * Filter that verifies active user authentication and session validity.
 */
@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {
        "/admin/*", "/doctor/*", "/patient/*", "/receptionist/*", "/nurse/*",
        "/admin", "/doctor", "/patient", "/receptionist", "/nurse",
        "/appointment", "/billing", "/prescription", "/lab", "/admission", "/vitals", "/inventory"
})
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // Set response headers to prevent caching of authenticated pages
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            String contextPath = req.getContextPath();
            resp.sendRedirect(contextPath + "/login.jsp?error=session_expired");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
