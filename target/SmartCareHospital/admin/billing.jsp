<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Financial Revenue & Invoices" />
<c:set var="activePage" value="billing" />
<c:set var="pageHeading" value="Hospital Billing & Revenue Management" />
<c:set var="pageSubheading" value="Cashier audits, itemized invoices, taxes, discounts, and payments" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Revenue Summary Card -->
        <div class="row mb-4">
            <div class="col-md-6 col-lg-4">
                <div class="kpi-card border-success">
                    <div class="kpi-info">
                        <p class="text-success">Total Collected Hospital Revenue</p>
                        <h3 class="text-success">₹<fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00" /></h3>
                    </div>
                    <div class="kpi-icon-box kpi-green">
                        <i class="bi bi-wallet2"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Invoices Table -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-receipt me-2 text-primary"></i> Master Billing Ledger</h5>
                <span class="badge bg-secondary">${bills.size()} Invoices</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Invoice #</th>
                            <th>Patient Name</th>
                            <th>Bill Date</th>
                            <th>Consultation</th>
                            <th>Pharmacy</th>
                            <th>Laboratory</th>
                            <th>Room / Bed</th>
                            <th>Tax / Disc</th>
                            <th>Net Total</th>
                            <th>Status</th>
                            <th class="text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty bills}">
                                <tr>
                                    <td colspan="11" class="text-center text-muted py-4">No billing records found.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="b" items="${bills}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#INV-${b.billId}</td>
                                        <td>
                                            <div class="fw-bold">${b.patientName}</div>
                                            <div class="text-muted small">${b.patientPhone}</div>
                                        </td>
                                        <td class="small text-muted"><fmt:formatDate value="${b.billDate}" pattern="dd MMM yyyy, HH:mm" /></td>
                                        <td>₹<fmt:formatNumber value="${b.consultationCharges}" pattern="#,##0.00" /></td>
                                        <td>₹<fmt:formatNumber value="${b.medicineCharges}" pattern="#,##0.00" /></td>
                                        <td>₹<fmt:formatNumber value="${b.labCharges}" pattern="#,##0.00" /></td>
                                        <td>₹<fmt:formatNumber value="${b.roomCharges}" pattern="#,##0.00" /></td>
                                        <td class="small text-muted">+₹${b.tax} / -₹${b.discount}</td>
                                        <td class="fw-bold text-dark fs-6">₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0.00" /></td>
                                        <td><span class="badge-status status-${b.paymentStatus}">${b.paymentStatus}</span></td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/billing?action=invoice&id=${b.billId}" 
                                               class="btn btn-sm btn-outline-primary" target="_blank" title="View Printable Bill">
                                                <i class="bi bi-printer me-1"></i> Invoice
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
</main>

<jsp:include page="/includes/footer.jsp" />
