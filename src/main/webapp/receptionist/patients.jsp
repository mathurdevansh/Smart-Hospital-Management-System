<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Patient Registry" />
<c:set var="activePage" value="patients" />
<c:set var="pageHeading" value="Patient Registration Directory" />
<c:set var="pageSubheading" value="Lookup, verify, and register outpatient and emergency patients" />

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

        <!-- Search Bar -->
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
            <form action="${pageContext.request.contextPath}/receptionist" method="GET" class="d-flex gap-2">
                <input type="hidden" name="action" value="patients">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" name="keyword" class="form-control border-start-0" placeholder="Search patient name, ID, phone..." value="${keyword}">
                    <button type="submit" class="btn btn-outline-primary">Search</button>
                    <c:if test="${not empty keyword}">
                        <a href="${pageContext.request.contextPath}/receptionist?action=patients" class="btn btn-outline-secondary">Reset</a>
                    </c:if>
                </div>
            </form>

            <a href="${pageContext.request.contextPath}/receptionist?action=registerPatient" class="btn btn-primary rounded-pill px-4 shadow-sm">
                <i class="bi bi-person-plus-fill me-1"></i> New Patient Registration
            </a>
        </div>

        <!-- Patients Table -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-person-lines-fill me-2 text-primary"></i> Registered Patient Records</h5>
                <span class="badge bg-secondary">${patients.size()} Records</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Patient ID</th>
                            <th>Full Name</th>
                            <th>DOB / Gender</th>
                            <th>Blood Group</th>
                            <th>Phone & Email</th>
                            <th>Emergency Contact</th>
                            <th>Residential Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty patients}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No patient records found.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="p" items="${patients}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#PAT-${p.patientId}</td>
                                        <td class="fw-bold">${p.patientName}</td>
                                        <td>
                                            <div>${p.gender}</div>
                                            <div class="text-muted small">${p.dob}</div>
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
                                        <td class="small text-muted" style="max-width: 250px;">${p.address}</td>
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
