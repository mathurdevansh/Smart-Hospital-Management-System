<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="User Account Management" />
<c:set var="activePage" value="users" />
<c:set var="pageHeading" value="User Accounts & Roles" />
<c:set var="pageSubheading" value="Security directory of hospital employees and patient logins" />

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
            <form action="${pageContext.request.contextPath}/admin" method="GET" class="d-flex gap-2">
                <input type="hidden" name="action" value="users">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" name="keyword" class="form-control border-start-0" placeholder="Search name, email, phone..." value="${keyword}">
                    <button type="submit" class="btn btn-outline-primary">Search</button>
                    <c:if test="${not empty keyword}">
                        <a href="${pageContext.request.contextPath}/admin?action=users" class="btn btn-outline-secondary">Reset</a>
                    </c:if>
                </div>
            </form>

            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                <i class="bi bi-person-plus-fill me-1"></i> Add System User
            </button>
        </div>

        <!-- Users Table Panel -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-people-fill me-2 text-primary"></i> Registered Users Directory</h5>
                <span class="badge bg-secondary">${userList.size()} Accounts</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Email Address</th>
                            <th>Phone</th>
                            <th>Assigned Role</th>
                            <th>Account Status</th>
                            <th>Created On</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty userList}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">No user accounts found matching query.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="u" items="${userList}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#${u.userId}</td>
                                        <td class="fw-bold">${u.fullName}</td>
                                        <td>${u.email}</td>
                                        <td>${u.phone}</td>
                                        <td><span class="role-badge role-${u.roleName}">${u.roleName}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.status eq 'ACTIVE'}">
                                                    <span class="badge bg-success bg-opacity-10 text-success fw-semibold">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger bg-opacity-10 text-danger fw-semibold">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="small text-muted"><fmt:formatDate value="${u.createdAt}" pattern="dd MMM yyyy" /></td>
                                        <td class="text-end">
                                            <c:if test="${u.userId ne sessionScope.currentUser.userId}">
                                                <c:choose>
                                                    <c:when test="${u.status eq 'ACTIVE'}">
                                                        <a href="${pageContext.request.contextPath}/admin?action=deactivateUser&userId=${u.userId}" 
                                                           class="btn btn-sm btn-outline-danger" title="Deactivate Account"
                                                           onclick="return confirm('Are you sure you want to deactivate ${u.fullName}?');">
                                                            <i class="bi bi-person-x"></i> Deactivate
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/admin?action=activateUser&userId=${u.userId}" 
                                                           class="btn btn-sm btn-outline-success" title="Activate Account">
                                                            <i class="bi bi-person-check"></i> Activate
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
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
</main>

<!-- Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin" method="POST">
                <input type="hidden" name="action" value="addUser">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="bi bi-person-plus-fill me-2 text-primary"></i> Create System User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Full Name</label>
                        <input type="text" name="fullName" class="form-control" required placeholder="e.g. John Doe">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Email Address</label>
                        <input type="email" name="email" class="form-control" required placeholder="e.g. staff@smarthospital.com">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Password</label>
                        <input type="password" name="password" class="form-control" required placeholder="Min 6 characters">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Phone Number</label>
                        <input type="text" name="phone" class="form-control" required placeholder="e.g. +91 98765 43210">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Assign Role</label>
                        <select name="roleId" class="form-select" required>
                            <c:forEach var="r" items="${roles}">
                                <option value="${r.roleId}">${r.roleName} - ${r.description}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-1"></i> Create User</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
