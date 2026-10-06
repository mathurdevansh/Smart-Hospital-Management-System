<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Doctor Staff Directory" />
<c:set var="activePage" value="doctors" />
<c:set var="pageHeading" value="Medical Staff & Doctors" />
<c:set var="pageSubheading" value="Clinical rosters, specializations, consulting rooms, and fees" />

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

        <!-- Search and Action Bar -->
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
            <form action="${pageContext.request.contextPath}/admin" method="GET" class="d-flex gap-2 flex-wrap">
                <input type="hidden" name="action" value="doctors">
                <input type="text" name="keyword" class="form-control" style="max-width: 250px;" placeholder="Search name or specialty..." value="${param.keyword}">
                <select name="deptId" class="form-select" style="max-width: 200px;">
                    <option value="">All Departments</option>
                    <c:forEach var="d" items="${departments}">
                        <option value="${d.departmentId}" ${param.deptId eq d.departmentId ? 'selected' : ''}>${d.name}</option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn btn-outline-primary">Filter</button>
                <a href="${pageContext.request.contextPath}/admin?action=doctors" class="btn btn-outline-secondary">Reset</a>
            </form>

            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDoctorModal">
                <i class="bi bi-person-plus-fill me-1"></i> Add New Doctor
            </button>
        </div>

        <!-- Doctors Table Panel -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-person-badge-fill me-2 text-primary"></i> Doctors Roster</h5>
                <span class="badge bg-secondary">${doctorList.size()} Physicians</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Doctor ID</th>
                            <th>Physician Name</th>
                            <th>Department</th>
                            <th>Specialization</th>
                            <th>Qualification</th>
                            <th>Experience</th>
                            <th>Consultation Fee</th>
                            <th>Room No</th>
                            <th>Schedule</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty doctorList}">
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-4">No doctors registered matching search.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="doc" items="${doctorList}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#${doc.doctorId}</td>
                                        <td>
                                            <div class="fw-bold">${doc.doctorName}</div>
                                            <div class="text-muted small"><i class="bi bi-envelope me-1"></i>${doc.email}</div>
                                        </td>
                                        <td><span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25">${doc.departmentName}</span></td>
                                        <td>${doc.specialization}</td>
                                        <td class="small text-muted">${doc.qualification}</td>
                                        <td>${doc.experienceYears} Yrs</td>
                                        <td class="fw-bold text-success">₹<fmt:formatNumber value="${doc.consultationFee}" pattern="#,##0.00" /></td>
                                        <td><span class="badge bg-light text-dark border">${doc.roomNo}</span></td>
                                        <td class="small text-muted">
                                            <div>${doc.availableDays}</div>
                                            <div>${doc.availableTime}</div>
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

<!-- Add Doctor Modal -->
<div class="modal fade" id="addDoctorModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin" method="POST">
                <input type="hidden" name="action" value="addDoctor">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="bi bi-person-plus-fill me-2 text-primary"></i> Register New Doctor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6 class="fw-bold text-secondary mb-3"><i class="bi bi-key-fill text-muted me-1"></i> Account Credentials</h6>
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Doctor Full Name</label>
                            <input type="text" name="doctorName" class="form-control" required placeholder="e.g. Dr. Rajesh Sharma">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Email Address (Login)</label>
                            <input type="email" name="email" class="form-control" required placeholder="e.g. dr.rajesh@smarthospital.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Login Password</label>
                            <input type="password" name="password" class="form-control" required placeholder="Min 6 characters">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Phone Number</label>
                            <input type="text" name="phone" class="form-control" required placeholder="+91 98765 00000">
                        </div>
                    </div>

                    <h6 class="fw-bold text-secondary mb-3"><i class="bi bi-hospital text-muted me-1"></i> Clinical & OPD Details</h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Department</label>
                            <select name="departmentId" class="form-select" required>
                                <c:forEach var="d" items="${departments}">
                                    <option value="${d.departmentId}">${d.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Specialization</label>
                            <input type="text" name="specialization" class="form-control" required placeholder="e.g. Cardiologist">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Qualifications</label>
                            <input type="text" name="qualification" class="form-control" required placeholder="e.g. MBBS, MD, DM">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Years of Experience</label>
                            <input type="number" name="experienceYears" class="form-control" required min="0" value="5">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Consultation Fee (₹)</label>
                            <input type="number" name="consultationFee" class="form-control" required min="0" step="50" value="800">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">OPD Room No</label>
                            <input type="text" name="roomNo" class="form-control" required placeholder="e.g. OPD-101">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Available Days</label>
                            <input type="text" name="availableDays" class="form-control" required value="Mon-Sat">
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold">Available Hours</label>
                            <input type="text" name="availableTime" class="form-control" required value="09:00 AM - 02:00 PM">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-1"></i> Register Doctor</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
