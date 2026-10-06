<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Manage Outpatient Appointments" />
<c:set var="activePage" value="appointments" />
<c:set var="pageHeading" value="Centralized Clinic Scheduling" />
<c:set var="pageSubheading" value="Monitor patient arrivals, confirm check-ins, reschedule slots, and manage cancellations" />

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

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Filter & Actions -->
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
            <form action="${pageContext.request.contextPath}/receptionist" method="GET" class="d-flex gap-2 flex-wrap">
                <input type="hidden" name="action" value="appointments">
                <input type="date" name="date" class="form-control" value="${param.date}">
                <select name="status" class="form-select">
                    <option value="">All Statuses</option>
                    <option value="PENDING" ${param.status eq 'PENDING' ? 'selected' : ''}>Pending</option>
                    <option value="CONFIRMED" ${param.status eq 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                    <option value="COMPLETED" ${param.status eq 'COMPLETED' ? 'selected' : ''}>Completed</option>
                    <option value="CANCELLED" ${param.status eq 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                </select>
                <button type="submit" class="btn btn-outline-primary">Filter</button>
                <a href="${pageContext.request.contextPath}/receptionist?action=appointments" class="btn btn-outline-secondary">Reset</a>
            </form>

            <a href="${pageContext.request.contextPath}/receptionist?action=bookAppointment" class="btn btn-primary rounded-pill px-4 shadow-sm">
                <i class="bi bi-calendar-plus-fill me-1"></i> Book New Appointment
            </a>
        </div>

        <!-- Appointments Table -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-calendar3 me-2 text-primary"></i> Master Appointment Queue</h5>
                <span class="badge bg-secondary">${appointments.size()} Appointments</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Patient Name</th>
                            <th>Attending Doctor</th>
                            <th>Department</th>
                            <th>Date & Time</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty appointments}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">No appointments found matching filter.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="a" items="${appointments}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#${a.appointmentId}</td>
                                        <td>
                                            <div class="fw-bold">${a.patientName}</div>
                                            <div class="text-muted small">${a.patientPhone}</div>
                                        </td>
                                        <td>${a.doctorName}</td>
                                        <td><span class="badge bg-light text-dark border">${a.departmentName}</span></td>
                                        <td>
                                            <div class="fw-semibold">${a.appointmentDate}</div>
                                            <div class="text-muted small">${a.appointmentTime}</div>
                                        </td>
                                        <td class="small" style="max-width: 200px;">${a.reason}</td>
                                        <td><span class="badge-status status-${a.status}">${a.status}</span></td>
                                        <td class="text-end">
                                            <c:if test="${a.status eq 'PENDING'}">
                                                <a href="${pageContext.request.contextPath}/receptionist?action=checkIn&appointmentId=${a.appointmentId}" 
                                                   class="btn btn-sm btn-outline-success me-1">
                                                    <i class="bi bi-check2"></i> Check-In
                                                </a>
                                            </c:if>

                                            <c:if test="${a.status eq 'PENDING' or a.status eq 'CONFIRMED'}">
                                                <!-- Reschedule Modal Trigger -->
                                                <button type="button" class="btn btn-sm btn-outline-warning me-1" 
                                                        data-bs-toggle="modal" data-bs-target="#reschedModal${a.appointmentId}">
                                                    <i class="bi bi-calendar2-range"></i> Reschedule
                                                </button>

                                                <a href="${pageContext.request.contextPath}/receptionist?action=cancelAppointment&appointmentId=${a.appointmentId}" 
                                                   class="btn btn-sm btn-outline-danger" onclick="return confirm('Cancel appointment #${a.appointmentId}?');">
                                                    <i class="bi bi-x-circle"></i> Cancel
                                                </a>

                                                <!-- Reschedule Modal -->
                                                <div class="modal fade text-start" id="reschedModal${a.appointmentId}" tabindex="-1" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <form action="${pageContext.request.contextPath}/receptionist" method="POST">
                                                                <input type="hidden" name="action" value="rescheduleAppointment">
                                                                <input type="hidden" name="appointmentId" value="${a.appointmentId}">
                                                                <input type="hidden" name="doctorId" value="${a.doctorId}">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title fw-bold">Reschedule Appointment #${a.appointmentId}</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <p class="small text-muted mb-3">Patient: <strong>${a.patientName}</strong> &bull; Doctor: <strong>${a.doctorName}</strong></p>
                                                                    <div class="mb-3">
                                                                        <label class="form-label small fw-bold">Select New Consultation Date</label>
                                                                        <input type="date" name="newDate" class="form-control" required value="${a.appointmentDate}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label class="form-label small fw-bold">Select New Time Slot</label>
                                                                        <select name="newTime" class="form-select" required>
                                                                            <option value="09:00">09:00 AM</option>
                                                                            <option value="09:30">09:30 AM</option>
                                                                            <option value="10:00">10:00 AM</option>
                                                                            <option value="10:30">10:30 AM</option>
                                                                            <option value="11:00">11:00 AM</option>
                                                                            <option value="11:30">11:30 AM</option>
                                                                            <option value="12:00">12:00 PM</option>
                                                                            <option value="14:00">02:00 PM</option>
                                                                            <option value="14:30">02:30 PM</option>
                                                                            <option value="15:00">03:00 PM</option>
                                                                            <option value="15:30">03:30 PM</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-warning"><i class="bi bi-clock-history me-1"></i> Update Slot</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
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
