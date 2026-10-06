<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Doctor Appointments Schedule" />
<c:set var="activePage" value="appointments" />
<c:set var="pageHeading" value="My Clinical Appointments" />
<c:set var="pageSubheading" value="Review incoming patient consultations, accept/reject slots, and initiate encounters" />

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

        <!-- Status Filter Tabs -->
        <div class="d-flex flex-wrap gap-2 mb-4">
            <a href="${pageContext.request.contextPath}/doctor?action=appointments&status=ALL" 
               class="btn btn-sm ${selectedStatus eq 'ALL' ? 'btn-primary' : 'btn-outline-secondary'} rounded-pill px-3">
                All Consultations
            </a>
            <a href="${pageContext.request.contextPath}/doctor?action=appointments&status=PENDING" 
               class="btn btn-sm ${selectedStatus eq 'PENDING' ? 'btn-warning text-dark' : 'btn-outline-secondary'} rounded-pill px-3">
                Pending Requests
            </a>
            <a href="${pageContext.request.contextPath}/doctor?action=appointments&status=CONFIRMED" 
               class="btn btn-sm ${selectedStatus eq 'CONFIRMED' ? 'btn-info text-dark' : 'btn-outline-secondary'} rounded-pill px-3">
                Confirmed Slots
            </a>
            <a href="${pageContext.request.contextPath}/doctor?action=appointments&status=COMPLETED" 
               class="btn btn-sm ${selectedStatus eq 'COMPLETED' ? 'btn-success' : 'btn-outline-secondary'} rounded-pill px-3">
                Completed
            </a>
        </div>

        <!-- Appointments Table -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-calendar2-check me-2 text-primary"></i> Patient Appointments</h5>
                <span class="badge bg-secondary">${appointments.size()} Total</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Patient Name</th>
                            <th>Date & Time</th>
                            <th>Reason / Symptoms</th>
                            <th>Current Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty appointments}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">No appointments found matching filter.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="appt" items="${appointments}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#${appt.appointmentId}</td>
                                        <td>
                                            <div class="fw-bold">${appt.patientName}</div>
                                            <div class="text-muted small"><i class="bi bi-telephone me-1"></i>${appt.patientPhone}</div>
                                        </td>
                                        <td>
                                            <div class="fw-semibold"><i class="bi bi-calendar3 me-1 text-muted"></i>${appt.appointmentDate}</div>
                                            <div class="text-muted small"><i class="bi bi-clock me-1"></i>${appt.appointmentTime}</div>
                                        </td>
                                        <td class="small" style="max-width: 250px;">${appt.reason}</td>
                                        <td><span class="badge-status status-${appt.status}">${appt.status}</span></td>
                                        <td class="text-end">
                                            <c:if test="${appt.status eq 'PENDING'}">
                                                <form action="${pageContext.request.contextPath}/doctor" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="confirmAppointment">
                                                    <input type="hidden" name="appointmentId" value="${appt.appointmentId}">
                                                    <button type="submit" class="btn btn-sm btn-outline-success me-1">
                                                        <i class="bi bi-check-lg"></i> Accept
                                                    </button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/doctor" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="rejectAppointment">
                                                    <input type="hidden" name="appointmentId" value="${appt.appointmentId}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger">
                                                        <i class="bi bi-x-lg"></i> Reject
                                                    </button>
                                                </form>
                                            </c:if>

                                            <c:if test="${appt.status eq 'CONFIRMED'}">
                                                <a href="${pageContext.request.contextPath}/doctor?action=consultation&appointmentId=${appt.appointmentId}" 
                                                   class="btn btn-sm btn-primary rounded-pill px-3">
                                                    <i class="bi bi-stethoscope me-1"></i> Consult
                                                </a>
                                            </c:if>

                                            <c:if test="${appt.status eq 'COMPLETED'}">
                                                <span class="badge bg-light text-muted border">Consulted</span>
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
