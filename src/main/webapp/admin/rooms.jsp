<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Rooms & Wards Management" />
<c:set var="activePage" value="rooms" />
<c:set var="pageHeading" value="Hospital Rooms & Bed Inventory" />
<c:set var="pageSubheading" value="Wards, ICU suites, semi-private rooms, and tariff rates" />

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
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <a href="${pageContext.request.contextPath}/admission" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                    <i class="bi bi-box-arrow-in-right me-1"></i> View Inpatient Admissions
                </a>
            </div>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addRoomModal">
                <i class="bi bi-plus-circle me-1"></i> Add Room / Ward Bed
            </button>
        </div>

        <!-- Rooms Table -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-door-open-fill me-2 text-primary"></i> Bed & Room Inventory</h5>
                <span class="badge bg-secondary">${rooms.size()} Total Rooms</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Room ID</th>
                            <th>Room No</th>
                            <th>Room Type</th>
                            <th>Floor</th>
                            <th>Tariff (Per Day)</th>
                            <th>Current Status</th>
                            <th class="text-end">Manage Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty rooms}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No rooms registered.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="r" items="${rooms}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#RM-${r.roomId}</td>
                                        <td class="fw-bold">${r.roomNumber}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${r.roomType eq 'ICU'}"><span class="badge bg-danger">ICU Suite</span></c:when>
                                                <c:when test="${r.roomType eq 'PRIVATE'}"><span class="badge bg-primary">Private Room</span></c:when>
                                                <c:when test="${r.roomType eq 'SEMI_PRIVATE'}"><span class="badge bg-info text-dark">Semi-Private</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary">General Ward</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${r.floor}</td>
                                        <td class="fw-bold text-success">₹<fmt:formatNumber value="${r.chargesPerDay}" pattern="#,##0.00" /></td>
                                        <td><span class="badge-status status-${r.status}">${r.status}</span></td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/admin" method="POST" class="d-inline">
                                                <input type="hidden" name="action" value="updateRoomStatus">
                                                <input type="hidden" name="roomId" value="${r.roomId}">
                                                <c:choose>
                                                    <c:when test="${r.status eq 'AVAILABLE'}">
                                                        <input type="hidden" name="status" value="UNDER_MAINTENANCE">
                                                        <button type="submit" class="btn btn-sm btn-outline-warning" title="Set to Maintenance">
                                                            <i class="bi bi-tools"></i> Maintenance
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${r.status eq 'UNDER_MAINTENANCE'}">
                                                        <input type="hidden" name="status" value="AVAILABLE">
                                                        <button type="submit" class="btn btn-sm btn-outline-success" title="Mark Available">
                                                            <i class="bi bi-check-circle"></i> Set Available
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-light text-muted border">In Patient Use</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>
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

<!-- Add Room Modal -->
<div class="modal fade" id="addRoomModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin" method="POST">
                <input type="hidden" name="action" value="addRoom">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="bi bi-door-open-fill me-2 text-primary"></i> Add Room / Ward Bed</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Room / Bed Identifier</label>
                        <input type="text" name="roomNumber" class="form-control" required placeholder="e.g. RM-305 or ICU-04">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Room Category</label>
                        <select name="roomType" class="form-select" required>
                            <option value="GENERAL">General Ward</option>
                            <option value="SEMI_PRIVATE">Semi-Private Room</option>
                            <option value="PRIVATE">Private Suite</option>
                            <option value="ICU">Intensive Care Unit (ICU)</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Floor / Location</label>
                        <input type="text" name="floor" class="form-control" required placeholder="e.g. 2nd Floor, West Wing">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Tariff Rate (₹ Per Day)</label>
                        <input type="number" name="chargesPerDay" class="form-control" required min="0" step="100" placeholder="e.g. 1500.00">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-1"></i> Add Room</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
