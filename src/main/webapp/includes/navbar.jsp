<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="app-navbar">
    <div class="navbar-page-title">
        <h4>${pageHeading != null ? pageHeading : 'SmartCare Hospital'}</h4>
        <p>${pageSubheading != null ? pageSubheading : 'Connected Clinical Healthcare & Hospital Operations'}</p>
    </div>

    <div class="d-flex align-items-center gap-3">
        <!-- Branch Tag -->
        <span class="badge bg-light text-dark border px-3 py-2 d-none d-md-inline-block">
            <i class="bi bi-geo-alt-fill text-danger me-1"></i> Main Campus (OPD & Specialty)
        </span>

        <!-- User Role Indicator -->
        <span class="role-badge role-${sessionScope.currentUser.roleName}">
            <i class="bi bi-shield-check me-1"></i> ${sessionScope.currentUser.roleName}
        </span>

        <!-- Logout Action Button -->
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm px-3 rounded-pill">
            <i class="bi bi-box-arrow-right me-1"></i> Logout
        </a>
    </div>
</header>
