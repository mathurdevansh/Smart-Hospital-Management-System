<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Clinical Departments" />
<c:set var="activePage" value="departments" />
<c:set var="pageHeading" value="Hospital Departments" />
<c:set var="pageSubheading" value="Clinical units, specialized wards, and operational services" />

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

        <!-- Actions -->
        <div class="d-flex justify-content-end mb-4">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDeptModal">
                <i class="bi bi-plus-circle me-1"></i> Add Department
            </button>
        </div>

        <!-- Departments Grid -->
        <div class="row g-4">
            <c:forEach var="dept" items="${departments}">
                <div class="col-md-6 col-lg-4">
                    <div class="card h-100 border-0 shadow-sm rounded-3">
                        <div class="card-body p-4 d-flex flex-direction-column justify-content-between">
                            <div>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25">ID #${dept.departmentId}</span>
                                    <span class="badge bg-success bg-opacity-10 text-success">Active</span>
                                </div>
                                <h5 class="fw-bold text-dark mt-2">${dept.name}</h5>
                                <p class="text-muted small mb-0">${dept.description}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

    </div>
</main>

<!-- Add Dept Modal -->
<div class="modal fade" id="addDeptModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin" method="POST">
                <input type="hidden" name="action" value="addDepartment">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="bi bi-diagram-3-fill me-2 text-primary"></i> Add Hospital Department</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Department Name</label>
                        <input type="text" name="name" class="form-control" required placeholder="e.g. Oncology, Radiology">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Description / Services</label>
                        <textarea name="description" class="form-control" rows="3" required placeholder="Scope of clinical care and treatment provided"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-1"></i> Save Department</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
