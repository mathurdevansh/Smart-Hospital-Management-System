<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Record Patient Vitals" />
<c:set var="activePage" value="patients" />
<c:set var="pageHeading" value="Bedside Telemetry & Vital Signs Entry" />
<c:set var="pageSubheading" value="Record current physiological observations for patient chart" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Error & Alert Messages -->
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <!-- Patient Banner & Entry Form -->
            <div class="col-lg-7">
                <div class="content-panel mb-4">
                    <div class="d-flex align-items-center gap-3 pb-3 border-bottom mb-4">
                        <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center fw-bold fs-4" style="width: 54px; height: 54px;">
                            ${patient.fullName.substring(0, 1)}
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">${patient.fullName}</h5>
                            <span class="text-muted small">Patient ID: #${patient.patientId} | Gender: ${patient.gender} | Blood: <strong>${patient.bloodGroup}</strong></span>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/nurse" method="POST" id="vitalsForm">
                        <input type="hidden" name="action" value="saveVitals">
                        <input type="hidden" name="patientId" value="${patient.patientId}">

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-thermometer-half text-danger me-1"></i> Body Temperature (°F) <span class="text-danger">*</span>
                                </label>
                                <input type="number" step="0.1" min="90" max="110" name="temperature" class="form-control" placeholder="e.g. 98.6" required>
                                <div class="form-text small">Standard normal range: 97.0°F - 99.0°F</div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-speedometer text-primary me-1"></i> Blood Pressure (mmHg) <span class="text-danger">*</span>
                                </label>
                                <input type="text" name="bloodPressure" class="form-control" placeholder="e.g. 120/80" pattern="\d{2,3}/\d{2,3}" title="Format: 120/80" required>
                                <div class="form-text small">Systolic / Diastolic (e.g. 120/80)</div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-heart-pulse-fill text-danger me-1"></i> Pulse Rate (bpm) <span class="text-danger">*</span>
                                </label>
                                <input type="number" min="30" max="220" name="pulse" class="form-control" placeholder="e.g. 72" required>
                                <div class="form-text small">Resting heart rate in beats per min</div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-lungs-fill text-teal me-1"></i> Oxygen Saturation (SpO2 %) <span class="text-danger">*</span>
                                </label>
                                <input type="number" min="50" max="100" name="oxygenLevel" class="form-control" placeholder="e.g. 98" required>
                                <div class="form-text small">Pulse oximetry percentage (95-100%)</div>
                            </div>

                            <div class="col-12">
                                <label class="form-label fw-semibold">Clinical Observation & Nursing Notes</label>
                                <textarea name="notes" class="form-control" rows="3" placeholder="Patient conscious, oriented, no acute distress. Routine morning assessment completed..."></textarea>
                            </div>

                            <div class="col-12 pt-2">
                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary px-4">
                                        <i class="bi bi-check2-circle me-1"></i> Save & Commit Vitals
                                    </button>
                                    <a href="${pageContext.request.contextPath}/nurse?action=patients" class="btn btn-outline-secondary">
                                        Cancel
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Historical Vitals Feed -->
            <div class="col-lg-5">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-clock-history me-2 text-primary"></i> Previous Readings</h5>
                    </div>

                    <c:choose>
                        <c:when test="${empty vitalsHistory}">
                            <div class="text-center py-4 text-muted">
                                <i class="bi bi-clipboard2-pulse display-6 d-block mb-2 text-secondary"></i>
                                No previous vitals logged for this patient yet.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="list-group list-group-flush">
                                <c:forEach var="v" items="${vitalsHistory}">
                                    <div class="list-group-item px-0 py-3">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="fw-bold small text-dark">
                                                <fmt:formatDate value="${v.recordedAt}" pattern="dd MMM yyyy, hh:mm a" />
                                            </span>
                                            <span class="badge bg-light text-secondary border">Nurse: ${v.nurseName}</span>
                                        </div>
                                        <div class="d-flex flex-wrap gap-2 text-secondary small mb-1">
                                            <span><strong>Temp:</strong> ${v.temperature}°F</span> |
                                            <span><strong>BP:</strong> ${v.bloodPressure}</span> |
                                            <span><strong>Pulse:</strong> ${v.pulse} bpm</span> |
                                            <span><strong>SpO2:</strong> ${v.oxygenLevel}%</span>
                                        </div>
                                        <c:if test="${not empty v.notes}">
                                            <div class="text-muted small fst-italic bg-light p-2 rounded">
                                                "${v.notes}"
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

    </div>

    <jsp:include page="/includes/footer.jsp" />
</main>
</body>
</html>
