<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Doctor Clinical Station" />
<c:set var="activePage" value="dashboard" />
<c:set var="pageHeading" value="Doctor Clinical Dashboard" />
<c:set var="pageSubheading" value="Welcome, ${doctor.doctorName} &bull; ${doctor.specialization} &bull; ${doctor.roomNo}" />

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

        <!-- KPI Metrics Grid -->
        <div class="row g-3 mb-4">
            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Today's OPD Appointments</p>
                        <h3>${todayAppointments.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-blue">
                        <i class="bi bi-calendar-check-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Pending Consultations</p>
                        <h3>${pendingCount}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-amber">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Completed Encounters</p>
                        <h3>${completedCount}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-green">
                        <i class="bi bi-check-circle-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Consultation Fee</p>
                        <h3>₹<fmt:formatNumber value="${doctor.consultationFee}" pattern="#,##0.00" /></h3>
                    </div>
                    <div class="kpi-icon-box kpi-teal">
                        <i class="bi bi-tag-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Today's Consultations Queue Panel -->
        <div class="content-panel mb-4">
            <div class="panel-header">
                <h5><i class="bi bi-clock-history me-2 text-primary"></i> Today's Patient Queue</h5>
                <a href="${pageContext.request.contextPath}/doctor?action=appointments" class="btn btn-outline-primary btn-sm rounded-pill">
                    View Complete Schedule
                </a>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Time</th>
                            <th>Patient Name</th>
                            <th>Phone</th>
                            <th>Reason / Symptoms</th>
                            <th>Status</th>
                            <th class="text-end">Clinical Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty todayAppointments}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">No outpatient consultations scheduled for today.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="appt" items="${todayAppointments}">
                                    <tr>
                                        <td class="fw-bold text-primary">${appt.appointmentTime}</td>
                                        <td class="fw-bold">
                                            <a href="${pageContext.request.contextPath}/doctor?action=patientProfile&patientId=${appt.patientId}" class="text-decoration-none text-dark">
                                                ${appt.patientName} <i class="bi bi-box-arrow-up-right small text-muted"></i>
                                            </a>
                                        </td>
                                        <td class="small text-muted">${appt.patientPhone}</td>
                                        <td class="small">${appt.reason}</td>
                                        <td><span class="badge-status status-${appt.status}">${appt.status}</span></td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${appt.status eq 'CONFIRMED' or appt.status eq 'PENDING'}">
                                                    <a href="${pageContext.request.contextPath}/doctor?action=consultation&appointmentId=${appt.appointmentId}" 
                                                       class="btn btn-sm btn-primary rounded-pill px-3">
                                                        <i class="bi bi-stethoscope me-1"></i> Start Consultation
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-light text-muted border">Completed</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Recent Medical Records Completed -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-journal-medical me-2 text-primary"></i> Recently Logged Medical Diagnoses</h5>
                <a href="${pageContext.request.contextPath}/doctor?action=records" class="small text-decoration-none">View All Records</a>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Record #</th>
                            <th>Date</th>
                            <th>Patient Name</th>
                            <th>Diagnosis</th>
                            <th>Treatment Plan</th>
                            <th>Follow-up</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty recentRecords}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">No recent records.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="rec" items="${recentRecords}" begin="0" end="4">
                                    <tr>
                                        <td class="fw-semibold text-muted">#REC-${rec.recordId}</td>
                                        <td class="small text-muted"><fmt:formatDate value="${rec.recordDate}" pattern="dd MMM yyyy" /></td>
                                        <td class="fw-bold">${rec.patientName}</td>
                                        <td class="fw-semibold text-dark">${rec.diagnosis}</td>
                                        <td class="small text-muted">${rec.treatment}</td>
                                        <td class="small text-muted">${rec.followUpDate != null ? rec.followUpDate : 'None'}</td>
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
