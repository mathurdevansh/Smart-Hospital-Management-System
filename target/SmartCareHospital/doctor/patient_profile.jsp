<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Clinical Patient Chart" />
<c:set var="activePage" value="appointments" />
<c:set var="pageHeading" value="Electronic Patient Health Chart" />
<c:set var="pageSubheading" value="Comprehensive clinical history, past consultations, medications, and pathology" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Patient Demographics Banner -->
        <div class="card border-0 shadow-sm rounded-4 mb-4 bg-white p-4">
            <div class="row align-items-center">
                <div class="col-md-2 text-center border-end">
                    <div class="user-avatar mx-auto mb-2" style="width: 64px; height: 64px; font-size: 1.5rem;">
                        ${patient.patientName.substring(0, 1)}
                    </div>
                    <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 fs-6">${patient.bloodGroup}</span>
                </div>
                <div class="col-md-6 ps-4">
                    <h3 class="fw-bold text-dark mb-1">${patient.patientName}</h3>
                    <div class="text-muted small mb-2">
                        <span>Patient ID: <strong>#PAT-${patient.patientId}</strong></span> &bull;
                        <span>Gender: ${patient.gender}</span> &bull;
                        <span>DOB: ${patient.dob}</span>
                    </div>
                    <div class="small text-muted">
                        <i class="bi bi-geo-alt me-1"></i> ${patient.address}
                    </div>
                </div>
                <div class="col-md-4 border-start ps-4">
                    <div class="small text-muted mb-1">Contact: <strong>${patient.phone}</strong></div>
                    <div class="small text-muted mb-2">Email: <strong>${patient.email}</strong></div>
                    <div class="small text-muted">Emergency: <strong>${patient.emergencyContactName} (${patient.emergencyContactPhone})</strong></div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Medical Record History -->
            <div class="col-lg-6">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-journal-medical me-2 text-primary"></i> Past Diagnoses & Encounters</h5>
                    </div>
                    <div class="p-3">
                        <c:choose>
                            <c:when test="${empty records}">
                                <div class="text-center text-muted py-4 small">No past encounters recorded.</div>
                            </c:when>
                            <c:otherwise>
                                <div class="d-flex flex-column gap-3">
                                    <c:forEach var="r" items="${records}">
                                        <div class="border rounded-3 p-3 bg-light bg-opacity-50">
                                            <div class="d-flex justify-content-between small text-muted mb-1">
                                                <span><i class="bi bi-calendar3 me-1"></i> <fmt:formatDate value="${r.recordDate}" pattern="dd MMM yyyy" /></span>
                                                <span class="fw-semibold text-primary">Dr. ${r.doctorName}</span>
                                            </div>
                                            <div class="fw-bold text-dark fs-6 mb-1">${r.diagnosis}</div>
                                            <div class="small text-muted mb-1"><strong>Symptoms:</strong> ${r.symptoms}</div>
                                            <div class="small text-muted"><strong>Treatment:</strong> ${r.treatment}</div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Prescriptions & Lab History -->
            <div class="col-lg-6">
                <div class="content-panel mb-4">
                    <div class="panel-header">
                        <h5><i class="bi bi-capsule me-2 text-success"></i> Medication Regimens</h5>
                    </div>
                    <div class="p-3">
                        <c:choose>
                            <c:when test="${empty prescriptions}">
                                <div class="text-center text-muted py-3 small">No prescriptions on file.</div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="p" items="${prescriptions}">
                                    <div class="border-bottom pb-2 mb-2">
                                        <div class="d-flex justify-content-between small">
                                            <span class="fw-bold">Rx #${p.prescriptionId} &bull; <fmt:formatDate value="${p.prescriptionDate}" pattern="dd MMM yyyy" /></span>
                                            <a href="${pageContext.request.contextPath}/prescription?action=view&id=${p.prescriptionId}" target="_blank" class="small text-decoration-none">View Rx</a>
                                        </div>
                                        <ul class="mb-0 ps-3 small text-muted">
                                            <c:forEach var="it" items="${p.items}">
                                                <li>${it.medicineName} (${it.dosage}) - ${it.frequency}, ${it.duration}</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-flask me-2 text-danger"></i> Diagnostic Pathology Tests</h5>
                    </div>
                    <div class="p-3">
                        <c:choose>
                            <c:when test="${empty labReports}">
                                <div class="text-center text-muted py-3 small">No lab tests conducted.</div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="l" items="${labReports}">
                                    <div class="border-bottom pb-2 mb-2 small">
                                        <div class="d-flex justify-content-between">
                                            <span class="fw-bold">${l.testName}</span>
                                            <span class="badge-status status-${l.status}">${l.status}</span>
                                        </div>
                                        <div class="text-muted"><fmt:formatDate value="${l.testDate}" pattern="dd MMM yyyy" /></div>
                                        <div class="text-dark fw-semibold mt-1">${empty l.result ? 'Results Pending' : l.result}</div>
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
