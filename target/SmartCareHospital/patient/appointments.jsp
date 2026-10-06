<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Clinical Appointments" />
<c:set var="activePage" value="appointments" />
<c:set var="pageHeading" value="My Scheduled Consultations" />
<c:set var="pageSubheading" value="Track upcoming clinic appointments and review consultation history" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Flash Messages -->
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${param.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="d-flex justify-content-end mb-4">
            <a href="${pageContext.request.contextPath}/patient?action=bookAppointment" class="btn btn-primary rounded-pill px-4 shadow-sm">
                <i class="bi bi-plus-circle me-1"></i> Book New Appointment
            </a>
        </div>

        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-calendar-event me-2 text-primary"></i> Consultations Timeline</h5>
                <span class="badge bg-secondary">${appointments.size()} Appointments</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Doctor Name</th>
                            <th>Department</th>
                            <th>Date & Time</th>
                            <th>Fee</th>
                            <th>Chief Reason</th>
                            <th>Status</th>
                            <th class="text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty appointments}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">No appointments recorded.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="a" items="${appointments}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#${a.appointmentId}</td>
                                        <td class="fw-bold">${a.doctorName}</td>
                                        <td><span class="badge bg-light text-dark border">${a.departmentName}</span></td>
                                        <td>
                                            <div class="fw-semibold"><i class="bi bi-calendar3 me-1 text-muted"></i>${a.appointmentDate}</div>
                                            <div class="text-muted small"><i class="bi bi-clock me-1"></i>${a.appointmentTime}</div>
                                        </td>
                                        <td class="text-success fw-bold">₹<fmt:formatNumber value="${a.consultationFee}" pattern="#,##0.00" /></td>
                                        <td class="small" style="max-width: 250px;">${a.reason}</td>
                                        <td><span class="badge-status status-${a.status}">${a.status}</span></td>
                                        <td class="text-end">
                                            <c:if test="${a.status eq 'PENDING' or a.status eq 'CONFIRMED'}">
                                                <a href="${pageContext.request.contextPath}/patient?action=cancelAppointment&appointmentId=${a.appointmentId}" 
                                                   class="btn btn-sm btn-outline-danger" onclick="return confirm('Cancel this appointment?');">
                                                    <i class="bi bi-x-circle me-1"></i> Cancel
                                                </a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/includes/footer.jsp" />
