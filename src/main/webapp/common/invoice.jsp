<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Official Hospital Bill Statement #INV-${bill.billId} | SmartCare Hospital</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background-color: #f1f5f9;
            font-family: 'Inter', sans-serif;
            color: #1e293b;
            padding: 2rem 0;
        }
        .invoice-card {
            max-width: 820px;
            margin: auto;
            background: #ffffff;
            border-radius: var(--radius-md);
            border: 1px solid var(--border);
            padding: 3.5rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            position: relative;
        }
        .watermark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-30deg);
            font-size: 5rem;
            font-weight: 900;
            color: rgba(16, 185, 129, 0.06);
            letter-spacing: 10px;
            text-transform: uppercase;
            pointer-events: none;
            user-select: none;
        }
    </style>
</head>
<body>

    <!-- Printable Container -->
    <div class="invoice-card">
        <!-- Watermark for Paid Bills -->
        <c:if test="${bill.paymentStatus eq 'PAID'}">
            <div class="watermark">PAID</div>
        </c:if>

        <!-- Hospital Brand Header -->
        <div class="d-flex justify-content-between align-items-start border-bottom pb-4 mb-4">
            <div>
                <div class="d-flex align-items-center gap-2 mb-2">
                    <span class="sidebar-logo-icon" style="width:38px; height:38px; font-size:1.25rem;"><i class="bi bi-hospital"></i></span>
                    <h3 class="fw-bold text-dark mb-0">SmartCare Hospital</h3>
                </div>
                <div class="text-muted small">
                    <div>Plot 14, Health City Corridor, Main Ring Road</div>
                    <div>New Delhi - 110001 &bull; Phone: +91 (11) 2345-6789</div>
                    <div>GSTIN: 07AAACS1234F1Z8 &bull; Lic: DL/HOSP/2026/9981</div>
                </div>
            </div>

            <div class="text-end">
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3 py-2 fw-bold text-uppercase fs-6">
                    Tax Invoice / Bill
                </span>
                <div class="fw-bold fs-5 text-dark mt-2">#INV-${bill.billId}</div>
                <div class="small text-muted">Date: <fmt:formatDate value="${bill.billDate}" pattern="dd MMM yyyy, HH:mm" /></div>
            </div>
        </div>

        <!-- Bill To / Patient Details -->
        <div class="row g-4 mb-4 pb-3 border-bottom">
            <div class="col-6">
                <div class="text-uppercase small fw-bold text-muted mb-1" style="font-size: 0.72rem; letter-spacing: 0.8px;">Bill To (Patient)</div>
                <h5 class="fw-bold text-dark mb-1">${bill.patientName}</h5>
                <div class="small text-muted">Patient ID: #PAT-${bill.patientId}</div>
                <div class="small text-muted">Phone: ${bill.patientPhone}</div>
                <div class="small text-muted">Email: ${bill.patientEmail}</div>
            </div>
            <div class="col-6 text-end">
                <div class="text-uppercase small fw-bold text-muted mb-1" style="font-size: 0.72rem; letter-spacing: 0.8px;">Settlement Details</div>
                <div class="mb-1">
                    <span class="badge-status status-${bill.paymentStatus} px-3 py-1 fs-6">${bill.paymentStatus}</span>
                </div>
                <c:if test="${bill.paymentDate != null}">
                    <div class="small text-muted">Paid On: <fmt:formatDate value="${bill.paymentDate}" pattern="dd MMM yyyy, HH:mm" /></div>
                </c:if>
            </div>
        </div>

        <!-- Itemized Charge Breakdown -->
        <table class="table table-bordered mb-4">
            <thead class="table-light small">
                <tr>
                    <th style="width: 10%;">#</th>
                    <th>Medical Service / Charge Description</th>
                    <th class="text-end" style="width: 25%;">Amount (INR)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Doctor Consultation Fees</td>
                    <td class="text-end fw-semibold">₹<fmt:formatNumber value="${bill.consultationCharges}" pattern="#,##0.00" /></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Pharmacy Dispensed Medications</td>
                    <td class="text-end fw-semibold">₹<fmt:formatNumber value="${bill.medicineCharges}" pattern="#,##0.00" /></td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>Pathology & Diagnostic Lab Investigations</td>
                    <td class="text-end fw-semibold">₹<fmt:formatNumber value="${bill.labCharges}" pattern="#,##0.00" /></td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>Hospital Inpatient Bed / Ward Room Charges</td>
                    <td class="text-end fw-semibold">₹<fmt:formatNumber value="${bill.roomCharges}" pattern="#,##0.00" /></td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>Hospital Nursing, Linen & Administrative Sundries</td>
                    <td class="text-end fw-semibold">₹<fmt:formatNumber value="${bill.otherCharges}" pattern="#,##0.00" /></td>
                </tr>
            </tbody>
        </table>

        <!-- Summary Totals -->
        <div class="row justify-content-end mb-4">
            <div class="col-md-6">
                <table class="table table-sm table-borderless">
                    <tr>
                        <td class="text-muted small">Special Healthcare Concession / Discount:</td>
                        <td class="text-end fw-semibold text-danger">- ₹<fmt:formatNumber value="${bill.discount}" pattern="#,##0.00" /></td>
                    </tr>
                    <tr>
                        <td class="text-muted small">Applicable GST / Hospital Health Tax:</td>
                        <td class="text-end fw-semibold">+ ₹<fmt:formatNumber value="${bill.tax}" pattern="#,##0.00" /></td>
                    </tr>
                    <tr class="border-top border-dark">
                        <td class="fw-bold fs-5 text-dark">Grand Net Payable:</td>
                        <td class="text-end fw-bold fs-5 text-success">₹<fmt:formatNumber value="${bill.totalAmount}" pattern="#,##0.00" /></td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- Authorized Signature & Notes -->
        <div class="row pt-4 border-top mt-4 text-muted small align-items-end">
            <div class="col-8">
                <div>* This computer-generated hospital statement is digitally verified and logged in the audit ledger.</div>
                <div>Thank you for choosing SmartCare Hospital for your clinical wellness.</div>
            </div>
            <div class="col-4 text-center">
                <div class="border-bottom pb-4 mb-1"></div>
                <div class="fw-bold text-dark">Authorized Cashier</div>
                <div style="font-size:0.75rem;">Accounts & Patient Billing</div>
            </div>
        </div>

        <!-- Action Buttons (Hidden when printing) -->
        <div class="d-flex justify-content-center gap-3 mt-5 no-print">
            <button type="button" class="btn btn-primary px-4 py-2 rounded-pill fw-bold shadow-sm" onclick="window.print()">
                <i class="bi bi-printer-fill me-1"></i> Print Hospital Invoice
            </button>
            <button type="button" class="btn btn-secondary px-4 py-2 rounded-pill" onclick="window.close()">
                <i class="bi bi-x-circle me-1"></i> Close
            </button>
        </div>
    </div>

</body>
</html>
