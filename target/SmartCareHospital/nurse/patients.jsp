<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="In-Patient Ward Rounding" />
<c:set var="activePage" value="patients" />
<c:set var="pageHeading" value="In-Patient Ward Care Roster" />
<c:set var="pageSubheading" value="Round-the-clock patient care, telemetry, bedside charting, and vital sign logs" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Search Bar and Quick Filter -->
        <div class="content-panel mb-4">
            <div class="row g-2 align-items-center">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" id="wardSearchInput" class="form-control border-start-0" placeholder="Search patient name, room number, doctor..." onkeyup="filterWardPatients()">
                    </div>
                </div>
                <div class="col-md-6 text-md-end">
                    <span class="badge bg-primary px-3 py-2 fs-6">
                        <i class="bi bi-person-check-fill me-1"></i> ${admissions.size()} Inpatients Currently Under Care
                    </span>
                </div>
            </div>
        </div>

        <!-- In-Patients Table -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-hospital me-2 text-primary"></i> Ward Rounding Roster</h5>
            </div>
            <div class="table-responsive">
                <table class="table table-custom" id="wardTable">
                    <thead>
                        <tr>
                            <th>Room / Bed</th>
                            <th>Patient Name</th>
                            <th>Attending Physician</th>
                            <th>Admitted On</th>
                            <th>Diagnosis / Notes</th>
                            <th>Status</th>
                            <th class="text-end">Nursing Care</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty admissions}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-5">
                                        <i class="bi bi-door-closed display-4 d-block mb-3 text-secondary"></i>
                                        No active patients in wards currently.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="adm" items="${admissions}">
                                    <tr class="patient-ward-row" data-search="${adm.patientName} ${adm.roomNumber} ${adm.doctorName} ${adm.roomType}">
                                        <td>
                                            <div class="fw-bold fs-6 text-dark">Room ${adm.roomNumber}</div>
                                            <span class="badge ${adm.roomType eq 'ICU' ? 'bg-danger' : 'bg-info'} small">${adm.roomType}</span>
                                        </td>
                                        <td>
                                            <div class="fw-bold">${adm.patientName}</div>
                                            <div class="text-muted small">Patient ID: #${adm.patientId}</div>
                                        </td>
                                        <td>
                                            <div class="fw-semibold">Dr. ${adm.doctorName}</div>
                                        </td>
                                        <td>
                                            <div><fmt:formatDate value="${adm.admissionDate}" pattern="dd MMM yyyy" /></div>
                                            <div class="text-muted small"><fmt:formatDate value="${adm.admissionDate}" pattern="hh:mm a" /></div>
                                        </td>
                                        <td>
                                            <span class="text-secondary small">${adm.reason}</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success"><i class="bi bi-heart-pulse me-1"></i>Admitted</span>
                                        </td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/nurse?action=recordVitals&patientId=${adm.patientId}" class="btn btn-sm btn-primary me-1">
                                                <i class="bi bi-plus-lg me-1"></i> Log Vitals
                                            </a>
                                            <a href="${pageContext.request.contextPath}/nurse?action=viewVitals&patientId=${adm.patientId}" class="btn btn-sm btn-outline-secondary">
                                                <i class="bi bi-graph-up me-1"></i> Chart
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

    </div>

    <jsp:include page="/includes/footer.jsp" />
</main>

<script>
function filterWardPatients() {
    let query = document.getElementById("wardSearchInput").value.toLowerCase();
    let rows = document.querySelectorAll(".patient-ward-row");
    rows.forEach(row => {
        let text = row.getAttribute("data-search").toLowerCase();
        if (text.includes(query)) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}
</script>
</body>
</html>
