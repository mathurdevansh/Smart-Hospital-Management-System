<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Desk Cashiering & Billing" />
<c:set var="activePage" value="billing" />
<c:set var="pageHeading" value="Front-Desk Cashiering & Invoicing" />
<c:set var="pageSubheading" value="Collect payments, issue stamped receipts, and manage outstanding medical bills" />

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

        <div class="d-flex justify-content-end mb-4">
            <a href="${pageContext.request.contextPath}/receptionist?action=generateBill" class="btn btn-primary rounded-pill px-4 shadow-sm">
                <i class="bi bi-receipt me-1"></i> Generate New Invoice
            </a>
        </div>

        <!-- Invoices Ledger -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-receipt-cutoff me-2 text-primary"></i> Patient Invoices & Receipts</h5>
                <span class="badge bg-secondary">${bills.size()} Bills</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Invoice #</th>
                            <th>Patient Name</th>
                            <th>Date</th>
                            <th>Grand Total</th>
                            <th>Status</th>
                            <th>Settled On</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty bills}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No billing records found.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="b" items="${bills}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#INV-${b.billId}</td>
                                        <td>
                                            <div class="fw-bold">${b.patientName}</div>
                                            <div class="small text-muted">${b.patientPhone}</div>
                                        </td>
                                        <td class="small text-muted"><fmt:formatDate value="${b.billDate}" pattern="dd MMM yyyy" /></td>
                                        <td class="fw-bold text-dark fs-6">₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0.00" /></td>
                                        <td><span class="badge-status status-${b.paymentStatus}">${b.paymentStatus}</span></td>
                                        <td class="small text-muted">
                                            ${b.paymentDate != null ? b.paymentDate : 'Pending Collection'}
                                        </td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/billing?action=invoice&id=${b.billId}" 
                                               class="btn btn-sm btn-outline-secondary me-1" target="_blank" title="Print Invoice">
                                                <i class="bi bi-printer"></i>
                                            </a>

                                            <c:if test="${b.paymentStatus ne 'PAID'}">
                                                <button type="button" class="btn btn-sm btn-success rounded-pill px-3"
                                                        data-bs-toggle="modal" data-bs-target="#payModal${b.billId}">
                                                    <i class="bi bi-currency-rupee me-1"></i> Receive Payment
                                                </button>

                                                <!-- Payment Modal -->
                                                <div class="modal fade text-start" id="payModal${b.billId}" tabindex="-1" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <form action="${pageContext.request.contextPath}/receptionist" method="POST">
                                                                <input type="hidden" name="action" value="recordPayment">
                                                                <input type="hidden" name="billId" value="${b.billId}">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title fw-bold">Receive Payment - Invoice #INV-${b.billId}</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="alert alert-light border mb-3">
                                                                        <div>Patient: <strong>${b.patientName}</strong></div>
                                                                        <div class="fs-5 fw-bold text-success mt-1">Amount Due: ₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0.00" /></div>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label class="form-label small fw-bold">Payment Method</label>
                                                                        <select name="paymentMode" class="form-select" required>
                                                                            <option value="CASH">Cash</option>
                                                                            <option value="UPI">UPI (Google Pay / PhonePe / Paytm)</option>
                                                                            <option value="CREDIT_CARD">Credit Card</option>
                                                                            <option value="DEBIT_CARD">Debit Card</option>
                                                                            <option value="NET_BANKING">Net Banking</option>
                                                                            <option value="INSURANCE">TPA / Health Insurance</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label class="form-label small fw-bold">Amount Paid (₹)</label>
                                                                        <input type="number" name="amountPaid" class="form-control" value="${b.totalAmount}" step="0.01" required>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label class="form-label small fw-bold">Transaction Reference / Receipt #</label>
                                                                        <input type="text" name="transactionReference" class="form-control" placeholder="e.g. UPI-99881122 or Cash Receipt #">
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                    <button type="submit" class="btn btn-success"><i class="bi bi-check-lg me-1"></i> Record Settlement</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
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

<jsp:include page="/includes/footer.jsp" />
