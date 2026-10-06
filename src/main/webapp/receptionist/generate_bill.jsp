<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Generate Patient Invoice" />
<c:set var="activePage" value="billing" />
<c:set var="pageHeading" value="Generate Hospital Invoice" />
<c:set var="pageSubheading" value="Itemize healthcare consultation, pharmacy, pathology, and bed accommodation fees" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Flash Error -->
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-receipt me-2 text-primary"></i> Hospital Invoice Generator</h5>
                    </div>
                    <div class="p-4">
                        <form action="${pageContext.request.contextPath}/receptionist" method="POST">
                            <input type="hidden" name="action" value="createBill">

                            <div class="mb-4">
                                <label class="form-label small fw-bold">Select Billed Patient</label>
                                <select name="patientId" class="form-select" required>
                                    <option value="">-- Choose Patient --</option>
                                    <c:forEach var="p" items="${patients}">
                                        <option value="${p.patientId}">#PAT-${p.patientId} - ${p.patientName} (${p.phone})</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <h6 class="fw-bold text-secondary mb-3"><i class="bi bi-calculator text-muted me-1"></i> Itemized Fee Structure (₹)</h6>
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Doctor Consultation Charges</label>
                                    <input type="number" step="0.01" id="consultationCharges" name="consultationCharges" class="form-control" value="800.00" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Pharmacy & Medicines</label>
                                    <input type="number" step="0.01" id="medicineCharges" name="medicineCharges" class="form-control" value="0.00" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Diagnostic Lab Investigations</label>
                                    <input type="number" step="0.01" id="labCharges" name="labCharges" class="form-control" value="0.00" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Room / Ward Accommodation</label>
                                    <input type="number" step="0.01" id="roomCharges" name="roomCharges" class="form-control" value="0.00" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-bold">Nursing & Other Sundries</label>
                                    <input type="number" step="0.01" id="otherCharges" name="otherCharges" class="form-control" value="50.00" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-bold text-danger">Discount / Concession (-)</label>
                                    <input type="number" step="0.01" id="discount" name="discount" class="form-control" value="0.00" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-bold text-success">GST / Hospital Tax (+)</label>
                                    <input type="number" step="0.01" id="tax" name="tax" class="form-control" value="40.00" required>
                                </div>
                            </div>

                            <!-- Live Grand Total Badge -->
                            <div class="card bg-light border p-3 mb-4 rounded-3 text-center">
                                <span class="small text-muted fw-bold text-uppercase">Calculated Net Total</span>
                                <h2 class="text-success fw-bold mb-0" id="totalAmountDisplay">₹890.00</h2>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/receptionist?action=billing" class="btn btn-secondary px-4">Cancel</a>
                                <button type="submit" class="btn btn-primary px-5 fw-bold shadow-sm">
                                    <i class="bi bi-check-circle me-1"></i> Generate & Issue Invoice
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/includes/footer.jsp" />
