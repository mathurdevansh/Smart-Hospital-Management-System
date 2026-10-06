<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Admin Executive Dashboard" />
<c:set var="activePage" value="dashboard" />
<c:set var="pageHeading" value="Hospital Administration Overview" />
<c:set var="pageSubheading" value="Real-time operational telemetry, patient throughput, and department statistics" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Flash Notice / Feedback -->
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Action processed successfully: ${param.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- KPI Metrics Grid -->
        <div class="row g-3 mb-4">
            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Patients</p>
                        <h3>${counts.totalPatients}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-blue">
                        <i class="bi bi-person-heart"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Doctors</p>
                        <h3>${counts.totalDoctors}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-teal">
                        <i class="bi bi-person-badge-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Nursing Staff</p>
                        <h3>${counts.totalNurses}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-purple">
                        <i class="bi bi-heart-pulse-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Revenue</p>
                        <h3>₹<fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00" /></h3>
                    </div>
                    <div class="kpi-icon-box kpi-green">
                        <i class="bi bi-cash-stack"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Today's Appointments</p>
                        <h3>${counts.todayAppointments}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-blue">
                        <i class="bi bi-calendar-check-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Pending Requests</p>
                        <h3>${counts.pendingAppointments}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-amber">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Available Rooms</p>
                        <h3>${counts.availableRooms}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-teal">
                        <i class="bi bi-door-open-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Pending Lab Tests</p>
                        <h3>${counts.pendingLabTests}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-rose">
                        <i class="bi bi-flask-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Administration Toolbar -->
        <div class="d-flex flex-wrap gap-2 mb-4">
            <a href="${pageContext.request.contextPath}/admin?action=doctors" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                <i class="bi bi-person-plus-fill me-1"></i> Register Doctor
            </a>
            <a href="${pageContext.request.contextPath}/admin?action=patients" class="btn btn-outline-success btn-sm rounded-pill px-3">
                <i class="bi bi-person-heart me-1"></i> Register Patient
            </a>
            <a href="${pageContext.request.contextPath}/admin?action=rooms" class="btn btn-outline-info btn-sm rounded-pill px-3 text-dark">
                <i class="bi bi-door-open-fill me-1"></i> Add Room / Ward
            </a>
            <a href="${pageContext.request.contextPath}/admin?action=users" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                <i class="bi bi-people-fill me-1"></i> Manage User Accounts
            </a>
            <a href="${pageContext.request.contextPath}/admin?action=reports" class="btn btn-outline-dark btn-sm rounded-pill px-3">
                <i class="bi bi-file-earmark-bar-graph me-1"></i> Generate Reports
            </a>
        </div>

        <div class="row g-4">
            <!-- Recent Appointments Table -->
            <div class="col-lg-8">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-calendar-event me-2 text-primary"></i> Recent Hospital Appointments</h5>
                        <a href="${pageContext.request.contextPath}/receptionist?action=appointments" class="small text-decoration-none">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-custom">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Patient</th>
                                    <th>Doctor</th>
                                    <th>Department</th>
                                    <th>Date & Time</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty recentAppointments}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted py-4">No appointment bookings logged yet.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="appt" items="${recentAppointments}" begin="0" end="6">
                                            <tr>
                                                <td class="fw-semibold text-muted">#${appt.appointmentId}</td>
                                                <td class="fw-bold">${appt.patientName}</td>
                                                <td>${appt.doctorName}</td>
                                                <td><span class="badge bg-light text-dark border">${appt.departmentName}</span></td>
                                                <td class="small">
                                                    <div><i class="bi bi-calendar3 text-muted me-1"></i> ${appt.appointmentDate}</div>
                                                    <div class="text-muted"><i class="bi bi-clock text-muted me-1"></i> ${appt.appointmentTime}</div>
                                                </td>
                                                <td><span class="badge-status status-${appt.status}">${appt.status}</span></td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Recent Security Audit Events -->
            <div class="col-lg-4">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-shield-check me-2 text-info"></i> System Security Logs</h5>
                        <a href="${pageContext.request.contextPath}/admin?action=audit" class="small text-decoration-none">Full Trail</a>
                    </div>
                    <div class="p-3">
                        <c:choose>
                            <c:when test="${empty recentLogs}">
                                <div class="text-center text-muted py-4 small">No security events logged.</div>
                            </c:when>
                            <c:otherwise>
                                <div class="d-flex flex-column gap-3">
                                    <c:forEach var="log" items="${recentLogs}" begin="0" end="5">
                                        <div class="border-bottom pb-2">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <span class="badge bg-dark bg-opacity-75 text-white" style="font-size:0.68rem;">${log.action}</span>
                                                <span class="text-muted" style="font-size:0.72rem;"><fmt:formatDate value="${log.timestamp}" pattern="dd MMM, HH:mm" /></span>
                                            </div>
                                            <div class="small fw-semibold text-dark text-truncate">${log.details}</div>
                                            <div class="text-muted" style="font-size:0.75rem;">
                                                <i class="bi bi-person me-1"></i> ${log.userName} &bull; <i class="bi bi-globe me-1"></i> ${log.ipAddress}
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/includes/footer.jsp" />
