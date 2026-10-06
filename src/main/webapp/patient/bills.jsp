<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Invoices & Billing" />
<c:set var="activePage" value="bills" />
<c:set var="pageHeading" value="Hospital Invoices & Payments" />
<c:set var="pageSubheading" value="Review your outpatient consultations, pharmacy charges, and printable statements" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-receipt me-2 text-primary"></i> Billing Statements</h5>
                <span class="badge bg-secondary">${bills.size()} Statements</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Invoice #</th>
                            <th>Billing Date</th>
                            <th>Consultation</th>
                            <th>Pharmacy</th>
                            <th>Pathology Lab</th>
                            <th>Room / Bed</th>
                            <th>Total Amount</th>
                            <th>Payment Status</th>
                            <th class="text-end">Print Statement</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty bills}">
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-5">
                                        <i class="bi bi-receipt display-4 text-muted mb-3 d-block"></i>
                                        <p class="mb-0">No invoices generated on your account.</p>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="b" items="${bills}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#INV-${b.billId}</td>
                                        <td class="small text-muted"><fmt:formatDate value="${b.billDate}" pattern="dd MMM yyyy, HH:mm" /></td>
                                        <td>₹<fmt:formatNumber value="${b.consultationCharges}" pattern="#,##0.00" /></td>
                                        <td>₹<fmt:formatNumber value="${b.medicineCharges}" pattern="#,##0.00" /></td>
                                        <td>₹<fmt:formatNumber value="${b.labCharges}" pattern="#,##0.00" /></td>
                                        <td>₹<fmt:formatNumber value="${b.roomCharges}" pattern="#,##0.00" /></td>
                                        <td class="fw-bold text-dark fs-6">₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0.00" /></td>
                                        <td><span class="badge-status status-${b.paymentStatus}">${b.paymentStatus}</span></td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/patient?action=billInvoice&billId=${b.billId}" 
                                               class="btn btn-sm btn-outline-primary rounded-pill px-3" target="_blank">
                                                <i class="bi bi-printer me-1"></i> Print Invoice
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
