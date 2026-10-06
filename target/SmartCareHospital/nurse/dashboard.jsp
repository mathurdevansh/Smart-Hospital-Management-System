<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Nurse Station Dashboard" />
<c:set var="activePage" value="dashboard" />
<c:set var="pageHeading" value="Nursing Station & Ward Care" />
<c:set var="pageSubheading" value="Active inpatient monitoring, routine vitals tracking, and clinical observations" />

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
        <c:set var="icuCount" value="0" />
        <c:set var="generalCount" value="0" />
        <c:forEach var="adm" items="${admissions}">
            <c:choose>
                <c:when test="${adm.roomType eq 'ICU'}"><c:set var="icuCount" value="${icuCount + 1}" /></c:when>
                <c:otherwise><c:set var="generalCount" value="${generalCount + 1}" /></c:otherwise>
            </c:choose>
        </c:forEach>

        <div class="row g-3 mb-4">
            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Active Inpatients</p>
                        <h3>${admissions.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-blue">
                        <i class="bi bi-people-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>ICU Patients (High Priority)</p>
                        <h3 class="text-danger">${icuCount}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-red">
                        <i class="bi bi-heart-pulse-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>General & Private Wards</p>
                        <h3>${generalCount}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-teal">
                        <i class="bi bi-hospital"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Clinical Station Shift</p>
                        <h3 class="text-success">Active</h3>
                    </div>
                    <div class="kpi-icon-box kpi-green">
                        <i class="bi bi-clock-history"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- In-Patient Rounding List -->
        <div class="content-panel mb-4">
            <div class="panel-header">
                <h5><i class="bi bi-hospital-fill me-2 text-primary"></i> Current Inpatient Bed Roster</h5>
                <span class="badge bg-primary">${admissions.size()} Admitted Patients</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Room / Bed</th>
                            <th>Patient Info</th>
                            <th>Attending Doctor</th>
                            <th>Admission Date</th>
                            <th>Clinical Reason</th>
                            <th class="text-end">Nursing Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty admissions}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">No patients currently admitted in ward.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="a" items="${admissions}">
                                    <tr>
                                        <td>
                                            <span class="badge bg-light text-dark border fw-bold fs-6">
                                                Room ${a.roomNumber}
                                            </span>
                                            <span class="badge ${a.roomType eq 'ICU' ? 'bg-danger' : 'bg-secondary'} ms-1">
                                                ${a.roomType}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="fw-bold">${a.patientName}</div>
                                            <div class="text-muted small">Patient ID: #${a.patientId}</div>
                                        </td>
                                        <td>
                                            <div class="fw-semibold">Dr. ${a.doctorName}</div>
                                        </td>
                                        <td>
                                            <div><fmt:formatDate value="${a.admissionDate}" pattern="dd MMM yyyy" /></div>
                                            <div class="text-muted small"><fmt:formatDate value="${a.admissionDate}" pattern="hh:mm a" /></div>
                                        </td>
                                        <td>
                                            <span class="text-secondary">${a.reason}</span>
                                        </td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/nurse?action=recordVitals&patientId=${a.patientId}" class="btn btn-sm btn-outline-primary me-1">
                                                <i class="bi bi-plus-circle me-1"></i> Record Vitals
                                            </a>
                                            <a href="${pageContext.request.contextPath}/nurse?action=viewVitals&patientId=${a.patientId}" class="btn btn-sm btn-outline-info">
                                                <i class="bi bi-activity me-1"></i> History
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Clinical Guidelines & Standard Ranges -->
        <div class="row g-3">
            <div class="col-md-6">
                <div class="content-panel h-100">
                    <h6 class="fw-bold mb-3"><i class="bi bi-info-circle-fill text-info me-2"></i> Standard Physiological Ranges</h6>
                    <ul class="list-group list-group-flush small">
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span><i class="bi bi-thermometer-half text-danger me-2"></i> Body Temperature</span>
                            <span class="badge bg-light text-dark border">97.0°F - 99.0°F (36.1°C - 37.2°C)</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span><i class="bi bi-heart-pulse-fill text-danger me-2"></i> Pulse Rate</span>
                            <span class="badge bg-light text-dark border">60 - 100 bpm (Resting)</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span><i class="bi bi-speedometer text-primary me-2"></i> Blood Pressure (BP)</span>
                            <span class="badge bg-light text-dark border">90/60 to 120/80 mmHg</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span><i class="bi bi-lungs-fill text-teal me-2"></i> Oxygen Saturation (SpO2)</span>
                            <span class="badge bg-light text-dark border">95% - 100% on Room Air</span>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="col-md-6">
                <div class="content-panel h-100">
                    <h6 class="fw-bold mb-3"><i class="bi bi-shield-exclamation text-warning me-2"></i> Nursing Station Protocols</h6>
                    <div class="small text-secondary">
                        <p class="mb-2"><i class="bi bi-check2 text-success me-1"></i> Check vitals every 4 hours for ICU patients and every 8 hours for General ward patients.</p>
                        <p class="mb-2"><i class="bi bi-check2 text-success me-1"></i> Immediately alert attending doctor if SpO2 drops below 92% or systolic BP exceeds 160 mmHg.</p>
                        <p class="mb-0"><i class="bi bi-check2 text-success me-1"></i> Ensure all medication administration records are logged in patient history notes.</p>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <jsp:include page="/includes/footer.jsp" />
</main>
</body>
</html>
