<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Bed & Room Availability" />
<c:set var="activePage" value="rooms" />
<c:set var="pageHeading" value="Ward & Bed Availability Tracker" />
<c:set var="pageSubheading" value="Real-time occupancy status across General Wards, Semi-Private, Deluxe, and ICU units" />

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

        <!-- KPI Quick Counters -->
        <c:set var="availCount" value="0" />
        <c:set var="occCount" value="0" />
        <c:set var="maintCount" value="0" />
        <c:forEach var="r" items="${rooms}">
            <c:if test="${r.status eq 'AVAILABLE'}"><c:set var="availCount" value="${availCount + 1}" /></c:if>
            <c:if test="${r.status eq 'OCCUPIED'}"><c:set var="occCount" value="${occCount + 1}" /></c:if>
            <c:if test="${r.status eq 'MAINTENANCE'}"><c:set var="maintCount" value="${maintCount + 1}" /></c:if>
        </c:forEach>

        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Available Ready Beds</p>
                        <h3 class="text-success">${availCount}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-green">
                        <i class="bi bi-door-open-fill"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Occupied Beds</p>
                        <h3 class="text-danger">${occCount}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-red">
                        <i class="bi bi-person-fill-lock"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Under Maintenance</p>
                        <h3 class="text-warning">${maintCount}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-orange">
                        <i class="bi bi-tools"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter and Search Toolbar -->
        <div class="content-panel mb-4">
            <div class="d-flex flex-wrap gap-2 justify-content-between align-items-center">
                <div class="d-flex align-items-center gap-2">
                    <input type="text" id="roomFilterInput" class="form-control form-control-sm" placeholder="Filter by room no, type, floor..." onkeyup="filterRoomCards()">
                </div>
                <div class="btn-group btn-group-sm" role="group">
                    <button type="button" class="btn btn-outline-secondary active" onclick="filterStatus('ALL')">All Beds (${rooms.size()})</button>
                    <button type="button" class="btn btn-outline-success" onclick="filterStatus('AVAILABLE')">Available (${availCount})</button>
                    <button type="button" class="btn btn-outline-danger" onclick="filterStatus('OCCUPIED')">Occupied (${occCount})</button>
                    <button type="button" class="btn btn-outline-warning" onclick="filterStatus('MAINTENANCE')">Maintenance (${maintCount})</button>
                </div>
            </div>
        </div>

        <!-- Rooms Grid -->
        <div class="row g-3" id="roomsContainer">
            <c:choose>
                <c:when test="${empty rooms}">
                    <div class="col-12 text-center py-5 text-muted">
                        <i class="bi bi-door-closed display-4 d-block mb-3 text-secondary"></i>
                        No room records configured in system.
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="rm" items="${rooms}">
                        <div class="col-xl-3 col-lg-4 col-md-6 room-card-item" data-status="${rm.status}" data-search="${rm.roomNumber} ${rm.roomType} Floor ${rm.floorNumber}">
                            <div class="card h-100 border-0 shadow-sm" style="border-radius: 12px; transition: transform 0.2s;">
                                <div class="card-body p-3">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <span class="badge ${rm.status eq 'AVAILABLE' ? 'badge-confirmed' : (rm.status eq 'OCCUPIED' ? 'badge-cancelled' : 'badge-pending')}">
                                            <i class="bi ${rm.status eq 'AVAILABLE' ? 'bi-check-circle' : (rm.status eq 'OCCUPIED' ? 'bi-person-fill' : 'bi-wrench')} me-1"></i>
                                            ${rm.status}
                                        </span>
                                        <span class="text-primary fw-bold">₹${rm.dailyRate}<small class="text-muted fw-normal">/day</small></span>
                                    </div>
                                    <h5 class="fw-bold mb-1 text-dark">Room ${rm.roomNumber}</h5>
                                    <p class="text-muted small mb-2"><i class="bi bi-tag me-1"></i>${rm.roomType}</p>
                                    <div class="d-flex justify-content-between text-secondary small pt-2 border-top">
                                        <span><i class="bi bi-building me-1"></i>Floor ${rm.floorNumber}</span>
                                        <span>ID: #${rm.roomId}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

    <jsp:include page="/includes/footer.jsp" />
</main>

<script>
function filterRoomCards() {
    let input = document.getElementById("roomFilterInput").value.toLowerCase();
    let cards = document.querySelectorAll(".room-card-item");
    cards.forEach(card => {
        let text = card.getAttribute("data-search").toLowerCase();
        if (text.includes(input)) {
            card.style.display = "";
        } else {
            card.style.display = "none";
        }
    });
}

function filterStatus(status) {
    let cards = document.querySelectorAll(".room-card-item");
    cards.forEach(card => {
        let itemStatus = card.getAttribute("data-status");
        if (status === 'ALL' || itemStatus === status) {
            card.style.display = "";
        } else {
            card.style.display = "none";
        }
    });
}
</script>
</body>
</html>
