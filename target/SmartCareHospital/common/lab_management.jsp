<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Laboratory Investigation Management" />
<c:set var="activePage" value="lab" />
<c:set var="pageHeading" value="Pathology & Diagnostic Laboratory Desk" />
<c:set var="pageSubheading" value="Clinical investigation queue, specimen processing, and test result entry" />

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

        <!-- KPI Metrics -->
        <c:set var="pendingTests" value="0" />
        <c:set var="completedTests" value="0" />
        <c:forEach var="t" items="${labTests}">
            <c:choose>
                <c:when test="${t.status eq 'COMPLETED'}"><c:set var="completedTests" value="${completedTests + 1}" /></c:when>
                <c:otherwise><c:set var="pendingTests" value="${pendingTests + 1}" /></c:otherwise>
            </c:choose>
        </c:forEach>

        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Investigations</p>
                        <h3>${labTests.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-blue">
                        <i class="bi bi-prescription2"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Pending / Processing</p>
                        <h3 class="text-warning">${pendingTests}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-orange">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Completed Reports</p>
                        <h3 class="text-success">${completedTests}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-green">
                        <i class="bi bi-check-circle-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter Search Bar -->
        <div class="content-panel mb-4">
            <div class="row g-2 align-items-center">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" id="labSearchInput" class="form-control border-start-0" placeholder="Filter by patient, test name, doctor..." onkeyup="filterLabTests()">
                    </div>
                </div>
                <div class="col-md-6 text-md-end">
                    <div class="btn-group btn-group-sm">
                        <button type="button" class="btn btn-outline-secondary active" onclick="filterLabStatus('ALL')">All (${labTests.size()})</button>
                        <button type="button" class="btn btn-outline-warning" onclick="filterLabStatus('PENDING')">Pending</button>
                        <button type="button" class="btn btn-outline-success" onclick="filterLabStatus('COMPLETED')">Completed</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Lab Investigations Table -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-flask-fill me-2 text-primary"></i> Diagnostic Test Orders</h5>
                <span class="badge bg-secondary">${labTests.size()} Tests</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Patient Name</th>
                            <th>Test / Investigation</th>
                            <th>Doctor</th>
                            <th>Ordered On</th>
                            <th>Status</th>
                            <th>Result Preview</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty labTests}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-5">
                                        <i class="bi bi-flask display-4 d-block mb-3 text-secondary"></i>
                                        No lab orders found.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="test" items="${labTests}">
                                    <tr class="lab-test-row" data-status="${test.status}" data-search="${test.patientName} ${test.testName} ${test.doctorName}">
                                        <td><strong>#LAB-${test.testId}</strong></td>
                                        <td>
                                            <div class="fw-bold">${test.patientName}</div>
                                            <div class="text-muted small">ID: #${test.patientId}</div>
                                        </td>
                                        <td>
                                            <div class="fw-semibold text-primary">${test.testName}</div>
                                        </td>
                                        <td>Dr. ${test.doctorName}</td>
                                        <td>
                                            <div><fmt:formatDate value="${test.testDate}" pattern="dd MMM yyyy" /></div>
                                        </td>
                                        <td>
                                            <span class="badge ${test.status eq 'COMPLETED' ? 'badge-confirmed' : 'badge-pending'}">
                                                ${test.status}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="text-secondary small text-truncate d-inline-block" style="max-width: 150px;">
                                                ${empty test.result ? 'Awaiting findings' : test.result}
                                            </span>
                                        </td>
                                        <td class="text-end">
                                            <button type="button" class="btn btn-sm btn-primary me-1" 
                                                    data-bs-toggle="modal" data-bs-target="#editLabModal"
                                                    data-id="${test.testId}"
                                                    data-patient="${test.patientName}"
                                                    data-testname="${test.testName}"
                                                    data-result="${test.result}"
                                                    data-range="${test.normalRange}"
                                                    data-remarks="${test.remarks}"
                                                    data-status="${test.status}"
                                                    onclick="populateLabModal(this)">
                                                <i class="bi bi-pencil-square me-1"></i> Enter Results
                                            </button>
                                            <a href="${pageContext.request.contextPath}/lab?action=view&id=${test.testId}" class="btn btn-sm btn-outline-info">
                                                <i class="bi bi-file-earmark-medical me-1"></i> Report
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

    <!-- Modal for Result Entry -->
    <div class="modal fade" id="editLabModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/lab" method="POST">
                    <input type="hidden" name="action" value="updateResult">
                    <input type="hidden" name="testId" id="modalTestId">

                    <div class="modal-header">
                        <h5 class="modal-title fw-bold"><i class="bi bi-flask me-2 text-primary"></i> Enter Lab Results</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label text-muted small">Patient & Test</label>
                            <div class="fw-bold" id="modalTestInfo"></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Test Result / Findings <span class="text-danger">*</span></label>
                            <input type="text" name="result" id="modalResult" class="form-control" placeholder="e.g. Hemoglobin: 13.8 g/dL, Platelets: 250,000" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Normal Biological Range</label>
                            <input type="text" name="normalRange" id="modalRange" class="form-control" placeholder="e.g. 13.0 - 17.0 g/dL">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Remarks & Notes</label>
                            <textarea name="remarks" id="modalRemarks" class="form-control" rows="2" placeholder="Clinical correlation suggested..."></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Test Status</label>
                            <select name="status" id="modalStatus" class="form-select">
                                <option value="IN_PROGRESS">IN_PROGRESS</option>
                                <option value="COMPLETED">COMPLETED</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save Findings</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/footer.jsp" />
</main>

<script>
function populateLabModal(button) {
    document.getElementById("modalTestId").value = button.getAttribute("data-id");
    document.getElementById("modalTestInfo").textContent = button.getAttribute("data-patient") + " — " + button.getAttribute("data-testname");
    document.getElementById("modalResult").value = button.getAttribute("data-result") || "";
    document.getElementById("modalRange").value = button.getAttribute("data-range") || "";
    document.getElementById("modalRemarks").value = button.getAttribute("data-remarks") || "";
    document.getElementById("modalStatus").value = button.getAttribute("data-status") || "COMPLETED";
}

function filterLabTests() {
    let q = document.getElementById("labSearchInput").value.toLowerCase();
    document.querySelectorAll(".lab-test-row").forEach(row => {
        let text = row.getAttribute("data-search").toLowerCase();
        row.style.display = text.includes(q) ? "" : "none";
    });
}

function filterLabStatus(status) {
    document.querySelectorAll(".lab-test-row").forEach(row => {
        let s = row.getAttribute("data-status");
        if (status === 'ALL' || s === status) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}
</script>
</body>
</html>
