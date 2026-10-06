<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Patient Personal Health Portal" />
<c:set var="activePage" value="dashboard" />
<c:set var="pageHeading" value="Welcome, ${patient.patientName}" />
<c:set var="pageSubheading" value="Your personal electronic health records, active appointments, prescriptions, and billing" />

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

        <!-- Patient Quick Summary Cards -->
        <div class="row g-3 mb-4">
            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Consultations</p>
                        <h3>${appointments.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-blue">
                        <i class="bi bi-calendar2-check-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Active Prescriptions</p>
                        <h3>${recentPrescriptions.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-purple">
                        <i class="bi bi-capsule"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Diagnostic Lab Reports</p>
                        <h3>${recentLabReports.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-teal">
                        <i class="bi bi-flask-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Blood Group</p>
                        <h3 class="text-danger">${patient.bloodGroup}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-rose">
                        <i class="bi bi-droplet-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Action Shortcut -->
        <div class="mb-4">
            <a href="${pageContext.request.contextPath}/patient?action=bookAppointment" class="btn btn-primary rounded-pill px-4 py-2 fw-semibold shadow-sm">
                <i class="bi bi-calendar-plus-fill me-2"></i> Schedule New Doctor Appointment
            </a>
        </div>

        <div class="row g-4">
            <!-- Appointments Summary -->
            <div class="col-lg-7">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-calendar-event me-2 text-primary"></i> My Upcoming & Recent Appointments</h5>
                        <a href="${pageContext.request.contextPath}/patient?action=myAppointments" class="small text-decoration-none">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-custom">
                            <thead>
                                <tr>
                                    <th>Doctor</th>
                                    <th>Department</th>
                                    <th>Date & Time</th>
                                    <th>Status</th>
                                    <th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty appointments}">
                                        <tr>
                                            <td colspan="5" class="text-center text-muted py-4">You have no booked appointments.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="a" items="${appointments}" begin="0" end="4">
                                            <tr>
                                                <td class="fw-bold">${a.doctorName}</td>
                                                <td><span class="badge bg-light text-dark border">${a.departmentName}</span></td>
                                                <td class="small">
                                                    <div>${a.appointmentDate}</div>
                                                    <div class="text-muted">${a.appointmentTime}</div>
                                                </td>
                                                <td><span class="badge-status status-${a.status}">${a.status}</span></td>
                                                <td class="text-end">
                                                    <c:if test="${a.status eq 'PENDING' or a.status eq 'CONFIRMED'}">
                                                        <a href="${pageContext.request.contextPath}/patient?action=cancelAppointment&appointmentId=${a.appointmentId}" 
                                                           class="btn btn-sm btn-outline-danger" onclick="return confirm('Cancel this appointment?');">
                                                            Cancel
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

            <!-- Health Summary & Feedback -->
            <div class="col-lg-5">
                <div class="content-panel mb-4">
                    <div class="panel-header">
                        <h5><i class="bi bi-file-earmark-medical me-2 text-success"></i> Recent Prescriptions</h5>
                        <a href="${pageContext.request.contextPath}/patient?action=prescriptions" class="small text-decoration-none">View All</a>
                    </div>
                    <div class="p-3">
                        <c:choose>
                            <c:when test="${empty recentPrescriptions}">
                                <div class="text-center text-muted py-3 small">No active prescriptions.</div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="p" items="${recentPrescriptions}" begin="0" end="2">
                                    <div class="border rounded-3 p-3 mb-2 bg-light bg-opacity-50">
                                        <div class="d-flex justify-content-between small fw-bold mb-1">
                                            <span>Dr. ${p.doctorName}</span>
                                            <a href="${pageContext.request.contextPath}/prescription?action=view&id=${p.prescriptionId}" target="_blank" class="text-decoration-none">Print Rx</a>
                                        </div>
                                        <div class="small text-muted mb-2"><fmt:formatDate value="${p.prescriptionDate}" pattern="dd MMM yyyy" /></div>
                                        <div class="small text-dark">${p.notes}</div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/includes/footer.jsp" />
