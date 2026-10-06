<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="In-Patient Admissions & Discharges" />
<c:set var="activePage" value="admissions" />
<c:set var="pageHeading" value="Inpatient Ward Admissions & Bed Management" />
<c:set var="pageSubheading" value="Hospitalization tracking, bed allocation, length of stay, and clinical discharge summaries" />

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

        <!-- KPI Metrics Grid -->
        <c:set var="activeAdmCount" value="0" />
        <c:set var="dischargedCount" value="0" />
        <c:forEach var="a" items="${admissions}">
            <c:choose>
                <c:when test="${a.status eq 'ADMITTED'}"><c:set var="activeAdmCount" value="${activeAdmCount + 1}" /></c:when>
                <c:otherwise><c:set var="dischargedCount" value="${dischargedCount + 1}" /></c:otherwise>
            </c:choose>
        </c:forEach>

        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Hospitalizations</p>
                        <h3>${admissions.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-blue">
                        <i class="bi bi-box-arrow-in-right"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Currently Admitted</p>
                        <h3 class="text-success">${activeAdmCount}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-green">
                        <i class="bi bi-hospital"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Discharged Cases</p>
                        <h3 class="text-secondary">${dischargedCount}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-teal">
                        <i class="bi bi-box-arrow-right"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Toolbar -->
        <div class="d-flex flex-wrap gap-2 justify-content-between align-items-center mb-4">
            <div class="input-group" style="max-width: 380px;">
                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                <input type="text" id="admSearchInput" class="form-control border-start-0" placeholder="Search patient, room, doctor..." onkeyup="filterAdmissions()">
            </div>

            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admission?action=new" class="btn btn-primary btn-sm">
                    <i class="bi bi-plus-circle me-1"></i> Admit New Patient
                </a>
            </div>
        </div>

        <!-- Admissions Table -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-journal-check me-2 text-primary"></i> Hospital Inpatient Records</h5>
                <span class="badge bg-secondary">${admissions.size()} Records</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Adm ID</th>
                            <th>Patient Name</th>
                            <th>Room / Bed</th>
                            <th>Attending Doctor</th>
                            <th>Admission Date</th>
                            <th>Discharge Date</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty admissions}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-5">
                                        <i class="bi bi-inbox display-4 d-block mb-3 text-secondary"></i>
                                        No admission records recorded.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="adm" items="${admissions}">
                                    <tr class="adm-row" data-search="${adm.patientName} ${adm.roomNumber} ${adm.doctorName} ${adm.status}">
                                        <td><strong>#ADM-${adm.admissionId}</strong></td>
                                        <td>
                                            <div class="fw-bold">${adm.patientName}</div>
                                            <div class="text-muted small">ID: #${adm.patientId}</div>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-dark">Room ${adm.roomNumber}</span>
                                            <span class="badge bg-light text-secondary border ms-1">${adm.roomType}</span>
                                        </td>
                                        <td>Dr. ${adm.doctorName}</td>
                                        <td>
                                            <div><fmt:formatDate value="${adm.admissionDate}" pattern="dd MMM yyyy" /></div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty adm.dischargeDate}">
                                                    <fmt:formatDate value="${adm.dischargeDate}" pattern="dd MMM yyyy" />
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted small">Active Inpatient</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="badge ${adm.status eq 'ADMITTED' ? 'badge-confirmed' : 'badge-completed'}">
                                                ${adm.status}
                                            </span>
                                        </td>
                                        <td class="text-end">
                                            <c:if test="${adm.status eq 'ADMITTED'}">
                                                <button type="button" class="btn btn-sm btn-outline-danger"
                                                        data-bs-toggle="modal" data-bs-target="#dischargeModal"
                                                        data-admid="${adm.admissionId}"
                                                        data-roomid="${adm.roomId}"
                                                        data-patient="${adm.patientName}"
                                                        data-roomnum="${adm.roomNumber}"
                                                        onclick="populateDischargeModal(this)">
                                                    <i class="bi bi-box-arrow-right me-1"></i> Discharge
                                                </button>
                                            </c:if>
                                            <c:if test="${adm.status eq 'DISCHARGED'}">
                                                <span class="text-muted small"><i class="bi bi-check2-all text-success me-1"></i> Completed</span>
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

    <!-- Modal for Patient Discharge -->
    <div class="modal fade" id="dischargeModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admission" method="POST">
                    <input type="hidden" name="action" value="discharge">
                    <input type="hidden" name="admissionId" id="disAdmId">
                    <input type="hidden" name="roomId" id="disRoomId">

                    <div class="modal-header">
                        <h5 class="modal-title fw-bold text-danger"><i class="bi bi-box-arrow-right me-2"></i> Discharge In-Patient</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="p-3 bg-light rounded mb-3">
                            <div class="fw-bold text-dark" id="disPatientInfo"></div>
                            <div class="text-muted small">Releasing Room / Bed: <strong id="disRoomInfo"></strong></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Discharge Summary & Medical Advice <span class="text-danger">*</span></label>
                            <textarea name="dischargeSummary" class="form-control" rows="3" placeholder="Condition at discharge: Stable. Prescribed oral medications for 10 days. Follow up in OPD after 1 week..." required></textarea>
                        </div>
                        <div class="alert alert-warning small mb-0">
                            <i class="bi bi-exclamation-circle me-1"></i> Confirming discharge will free this bed and mark its status as <strong>AVAILABLE</strong> for new admissions.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Confirm Discharge</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</main>

<script>
function populateDischargeModal(btn) {
    document.getElementById("disAdmId").value = btn.getAttribute("data-admid");
    document.getElementById("disRoomId").value = btn.getAttribute("data-roomid");
    document.getElementById("disPatientInfo").textContent = "Patient: " + btn.getAttribute("data-patient");
    document.getElementById("disRoomInfo").textContent = "Room " + btn.getAttribute("data-roomnum");
}

function filterAdmissions() {
    let q = document.getElementById("admSearchInput").value.toLowerCase();
    document.querySelectorAll(".adm-row").forEach(row => {
        let t = row.getAttribute("data-search").toLowerCase();
        row.style.display = t.includes(q) ? "" : "none";
    });
}
</script>
</body>
</html>
