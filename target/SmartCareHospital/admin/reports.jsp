<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Hospital Analytics & Reports" />
<c:set var="activePage" value="reports" />
<c:set var="pageHeading" value="Executive Reports & Hospital Intelligence" />
<c:set var="pageSubheading" value="Generate auditable operational, pharmacy, clinical, and financial reports" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Report Tabs -->
        <ul class="nav nav-pills mb-4 border-bottom pb-3">
            <li class="nav-item">
                <a class="nav-link ${selectedType eq 'revenue' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin?action=reports&type=revenue">
                    <i class="bi bi-cash-stack me-1"></i> Revenue Report
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${selectedType eq 'appointments' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin?action=reports&type=appointments">
                    <i class="bi bi-calendar-check me-1"></i> Appointments Report
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${selectedType eq 'inventory' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin?action=reports&type=inventory">
                    <i class="bi bi-capsule me-1"></i> Pharmacy Inventory Report
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${selectedType eq 'lab' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin?action=reports&type=lab">
                    <i class="bi bi-flask me-1"></i> Laboratory Tests Report
                </a>
            </li>
        </ul>

        <!-- Report Container Panel -->
        <div class="content-panel">
            <div class="panel-header">
                <h5>
                    <i class="bi bi-file-earmark-spreadsheet me-2 text-primary"></i>
                    <c:choose>
                        <c:when test="${selectedType eq 'revenue'}">Settled Patient Revenue Statement</c:when>
                        <c:when test="${selectedType eq 'appointments'}">Clinical Appointment Booking Log</c:when>
                        <c:when test="${selectedType eq 'inventory'}">Pharmacy Batch & Expiry Analysis</c:when>
                        <c:when test="${selectedType eq 'lab'}">Diagnostic Pathology & Lab Investigation Summary</c:when>
                    </c:choose>
                </h5>
                <button type="button" class="btn btn-outline-secondary btn-sm rounded-pill btn-print">
                    <i class="bi bi-printer me-1"></i> Print / Export Report
                </button>
            </div>

            <!-- Revenue Report View -->
            <c:if test="${selectedType eq 'revenue'}">
                <div class="table-responsive">
                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>Invoice #</th>
                                <th>Patient Name</th>
                                <th>Settlement Date</th>
                                <th>Consultation</th>
                                <th>Medicines</th>
                                <th>Lab Tests</th>
                                <th>Room Charges</th>
                                <th>Total Revenue</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${reportData}">
                                <tr>
                                    <td class="fw-semibold text-muted">#INV-${item.billId}</td>
                                    <td class="fw-bold">${item.patientName}</td>
                                    <td><fmt:formatDate value="${item.paymentDate}" pattern="dd MMM yyyy, HH:mm" /></td>
                                    <td>₹<fmt:formatNumber value="${item.consultationCharges}" pattern="#,##0.00" /></td>
                                    <td>₹<fmt:formatNumber value="${item.medicineCharges}" pattern="#,##0.00" /></td>
                                    <td>₹<fmt:formatNumber value="${item.labCharges}" pattern="#,##0.00" /></td>
                                    <td>₹<fmt:formatNumber value="${item.roomCharges}" pattern="#,##0.00" /></td>
                                    <td class="fw-bold text-success fs-6">₹<fmt:formatNumber value="${item.totalAmount}" pattern="#,##0.00" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- Appointments Report View -->
            <c:if test="${selectedType eq 'appointments'}">
                <div class="table-responsive">
                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Patient</th>
                                <th>Doctor</th>
                                <th>Department</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${reportData}">
                                <tr>
                                    <td>#${item.appointmentId}</td>
                                    <td class="fw-bold">${item.patientName}</td>
                                    <td>${item.doctorName}</td>
                                    <td>${item.departmentName}</td>
                                    <td>${item.appointmentDate}</td>
                                    <td>${item.appointmentTime}</td>
                                    <td><span class="badge-status status-${item.status}">${item.status}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- Inventory Report View -->
            <c:if test="${selectedType eq 'inventory'}">
                <div class="table-responsive">
                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>Batch #</th>
                                <th>Medicine</th>
                                <th>Category</th>
                                <th>Stock Qty</th>
                                <th>Reorder Level</th>
                                <th>Expiry Date</th>
                                <th>Alert Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${reportData}">
                                <tr>
                                    <td class="fw-semibold text-muted">${item.batchNumber}</td>
                                    <td class="fw-bold">${item.medicineName}</td>
                                    <td>${item.category}</td>
                                    <td class="fw-bold">${item.quantity}</td>
                                    <td>${item.reorderLevel}</td>
                                    <td><fmt:formatDate value="${item.expiryDate}" pattern="dd MMM yyyy" /></td>
                                    <td>
                                        <c:if test="${item.lowStock}">
                                            <span class="badge bg-warning text-dark me-1"><i class="bi bi-exclamation-triangle-fill"></i> Low Stock</span>
                                        </c:if>
                                        <c:if test="${item.nearExpiry}">
                                            <span class="badge bg-danger"><i class="bi bi-hourglass-bottom"></i> Near Expiry</span>
                                        </c:if>
                                        <c:if test="${not item.lowStock and not item.nearExpiry}">
                                            <span class="badge bg-success bg-opacity-10 text-success">Adequate Stock</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- Lab Report View -->
            <c:if test="${selectedType eq 'lab'}">
                <div class="table-responsive">
                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>Test ID</th>
                                <th>Patient</th>
                                <th>Doctor</th>
                                <th>Test Name</th>
                                <th>Normal Range</th>
                                <th>Diagnostic Result</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${reportData}">
                                <tr>
                                    <td>#${item.testId}</td>
                                    <td class="fw-bold">${item.patientName}</td>
                                    <td>${item.doctorName}</td>
                                    <td>${item.testName}</td>
                                    <td class="small text-muted">${item.normalRange}</td>
                                    <td class="small fw-semibold text-dark">${empty item.result ? 'Awaiting Analysis' : item.result}</td>
                                    <td><span class="badge-status status-${item.status}">${item.status}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>

    </div>
</main>

<jsp:include page="/includes/footer.jsp" />
