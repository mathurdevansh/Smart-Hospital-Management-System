<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Patient Master Registry" />
<c:set var="activePage" value="patients" />
<c:set var="pageHeading" value="Patient Directory" />
<c:set var="pageSubheading" value="Master demographic records, emergency contacts, and clinical backgrounds" />

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

        <!-- Search & Actions -->
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
            <form action="${pageContext.request.contextPath}/admin" method="GET" class="d-flex gap-2">
                <input type="hidden" name="action" value="patients">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" name="keyword" class="form-control border-start-0" placeholder="Search patient name, ID, phone..." value="${keyword}">
                    <button type="submit" class="btn btn-outline-primary">Search</button>
                    <c:if test="${not empty keyword}">
                        <a href="${pageContext.request.contextPath}/admin?action=patients" class="btn btn-outline-secondary">Reset</a>
                    </c:if>
                </div>
            </form>

            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addPatientModal">
                <i class="bi bi-person-plus-fill me-1"></i> Register New Patient
            </button>
        </div>

        <!-- Patients Table -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-person-heart me-2 text-success"></i> Registered Patients</h5>
                <span class="badge bg-secondary">${patientList.size()} Records</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Patient ID</th>
                            <th>Full Name</th>
                            <th>DOB & Gender</th>
                            <th>Blood Group</th>
                            <th>Phone & Email</th>
                            <th>Emergency Contact</th>
                            <th>Medical Summary</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty patientList}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No patient records found.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="p" items="${patientList}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#PAT-${p.patientId}</td>
                                        <td class="fw-bold">${p.patientName}</td>
                                        <td>
                                            <div>${p.gender}</div>
                                            <div class="text-muted small"><fmt:formatDate value="${p.dob}" pattern="dd MMM yyyy" /></div>
                                        </td>
                                        <td><span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25">${p.bloodGroup}</span></td>
                                        <td class="small">
                                            <div><i class="bi bi-telephone me-1 text-muted"></i>${p.phone}</div>
                                            <div class="text-muted"><i class="bi bi-envelope me-1 text-muted"></i>${p.email}</div>
                                        </td>
                                        <td class="small">
                                            <div class="fw-semibold">${p.emergencyContactName}</div>
                                            <div class="text-muted">${p.emergencyContactPhone}</div>
                                        </td>
                                        <td class="small text-muted" style="max-width: 250px;">
                                            <div class="text-truncate" title="${p.medicalHistorySummary}">
                                                ${empty p.medicalHistorySummary ? 'No known conditions' : p.medicalHistorySummary}
                                            </div>
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
</main>

<!-- Add Patient Modal -->
<div class="modal fade" id="addPatientModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin" method="POST">
                <input type="hidden" name="action" value="addPatient">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="bi bi-person-plus-fill me-2 text-success"></i> Patient Registration</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Full Legal Name</label>
                            <input type="text" name="patientName" class="form-control" required placeholder="e.g. Ramesh Chandra">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Email Address</label>
                            <input type="email" name="email" class="form-control" required placeholder="e.g. ramesh@gmail.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Password</label>
                            <input type="password" name="password" class="form-control" required placeholder="Min 6 characters">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Phone Number</label>
                            <input type="text" name="phone" class="form-control" required placeholder="+91 98765 43210">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Date of Birth</label>
                            <input type="date" name="dob" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Gender</label>
                            <select name="gender" class="form-select" required>
                                <option value="MALE">Male</option>
                                <option value="FEMALE">Female</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Blood Group</label>
                            <select name="bloodGroup" class="form-select" required>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold">Residential Address</label>
                            <textarea name="address" class="form-control" rows="2" required placeholder="Full street address, city, pin code"></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Emergency Contact Person</label>
                            <input type="text" name="emergencyContactName" class="form-control" required placeholder="e.g. Suman (Spouse)">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Emergency Contact Phone</label>
                            <input type="text" name="emergencyContactPhone" class="form-control" required placeholder="+91 98111 22233">
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold">Medical History Summary & Allergies</label>
                            <textarea name="medicalHistorySummary" class="form-control" rows="2" placeholder="Past surgeries, chronic conditions, drug sensitivities (e.g. Penicillin)"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success"><i class="bi bi-check-lg me-1"></i> Register Patient</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
