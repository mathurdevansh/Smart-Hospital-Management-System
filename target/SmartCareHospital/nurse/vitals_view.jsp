<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Patient Telemetry & Chart" />
<c:set var="activePage" value="patients" />
<c:set var="pageHeading" value="Patient Clinical Chart & Vitals Log" />
<c:set var="pageSubheading" value="Comprehensive chronological telemetry and nursing observations" />

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

        <!-- Patient Demographics Banner -->
        <div class="content-panel mb-4">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center fw-bold fs-3" style="width: 60px; height: 60px;">
                        ${patient.fullName.substring(0, 1)}
                    </div>
                    <div>
                        <h4 class="fw-bold mb-1">${patient.fullName}</h4>
                        <div class="d-flex flex-wrap gap-3 text-muted small">
                            <span><i class="bi bi-person me-1"></i>ID: #${patient.patientId}</span>
                            <span><i class="bi bi-gender-ambiguous me-1"></i>${patient.gender}</span>
                            <span><i class="bi bi-droplet-half text-danger me-1"></i>Blood: <strong>${patient.bloodGroup}</strong></span>
                            <span><i class="bi bi-calendar-event me-1"></i>DOB: ${patient.dob}</span>
                            <span><i class="bi bi-telephone me-1"></i>${patient.emergencyContactPhone}</span>
                        </div>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/nurse?action=recordVitals&patientId=${patient.patientId}" class="btn btn-primary btn-sm">
                        <i class="bi bi-plus-lg me-1"></i> Log New Reading
                    </a>
                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="window.print()">
                        <i class="bi bi-printer me-1"></i> Print Chart
                    </button>
                    <a href="${pageContext.request.contextPath}/nurse?action=patients" class="btn btn-light btn-sm border">
                        <i class="bi bi-arrow-left me-1"></i> Back to Wards
                    </a>
                </div>
            </div>
        </div>

        <!-- Telemetry Table -->
        <div class="content-panel mb-4">
            <div class="panel-header">
                <h5><i class="bi bi-activity me-2 text-primary"></i> Physiological Telemetry Readings</h5>
                <span class="badge bg-secondary">${vitalsList.size()} Records</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Recorded Time</th>
                            <th>Attending Nurse</th>
                            <th>Temperature</th>
                            <th>Blood Pressure</th>
                            <th>Pulse</th>
                            <th>SpO2</th>
                            <th>Observation Notes</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty vitalsList}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-5">
                                        <i class="bi bi-clipboard2-pulse display-6 d-block mb-2 text-secondary"></i>
                                        No vitals recorded for this patient yet.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="v" items="${vitalsList}">
                                    <tr>
                                        <td>
                                            <div class="fw-bold"><fmt:formatDate value="${v.recordedAt}" pattern="dd MMM yyyy" /></div>
                                            <div class="text-muted small"><fmt:formatDate value="${v.recordedAt}" pattern="hh:mm:ss a" /></div>
                                        </td>
                                        <td>
                                            <span class="badge bg-light text-dark border">
                                                <i class="bi bi-person-badge me-1"></i>${v.nurseName}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="fw-bold ${v.temperature > 99.5 ? 'text-danger' : 'text-dark'}">
                                                ${v.temperature}°F
                                            </span>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-dark">${v.bloodPressure}</span> mmHg
                                        </td>
                                        <td>
                                            <span class="fw-bold ${v.pulse > 100 || v.pulse < 60 ? 'text-danger' : 'text-dark'}">
                                                ${v.pulse}
                                            </span> bpm
                                        </td>
                                        <td>
                                            <span class="badge ${v.oxygenLevel < 94 ? 'bg-danger' : 'bg-success'}">
                                                ${v.oxygenLevel}%
                                            </span>
                                        </td>
                                        <td>
                                            <span class="text-secondary small">${empty v.notes ? 'Normal' : v.notes}</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Accompanying Medical Diagnoses -->
        <c:if test="${not empty records}">
            <div class="content-panel">
                <div class="panel-header">
                    <h5><i class="bi bi-journal-medical me-2 text-primary"></i> Clinical Diagnoses & Treatment History</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>Visit Date</th>
                                <th>Attending Doctor</th>
                                <th>Diagnosis</th>
                                <th>Reported Symptoms</th>
                                <th>Clinical Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${records}">
                                <tr>
                                    <td><fmt:formatDate value="${r.visitDate}" pattern="dd MMM yyyy" /></td>
                                    <td>Dr. ${r.doctorName}</td>
                                    <td><span class="fw-bold text-primary">${r.diagnosis}</span></td>
                                    <td>${r.symptoms}</td>
                                    <td><span class="text-muted small">${r.treatmentPlan}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

    </div>

    <jsp:include page="/includes/footer.jsp" />
</main>
</body>
</html>
