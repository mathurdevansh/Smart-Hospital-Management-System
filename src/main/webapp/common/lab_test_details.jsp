<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diagnostic Laboratory Report #LAB-${labTest.testId} | SmartCare Hospital</title>
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
            padding: 2.5rem 0;
        }
        .lab-card {
            max-width: 820px;
            margin: auto;
            background: #ffffff;
            border-radius: var(--radius-md);
            border: 1px solid var(--border);
            padding: 3.5rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            position: relative;
        }
        .signature-line {
            width: 220px;
            border-bottom: 2px solid #334155;
            margin-bottom: 8px;
        }
        @media print {
            body {
                background: #ffffff;
                padding: 0;
            }
            .lab-card {
                border: none;
                box-shadow: none;
                padding: 1rem;
            }
            .no-print {
                display: none !important;
            }
        }
    </style>
</head>
<body>

    <div class="lab-card">
        <!-- Brand Letterhead -->
        <div class="d-flex justify-content-between align-items-start border-bottom pb-4 mb-4">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="sidebar-logo-icon" style="width:36px; height:36px; font-size:1.2rem;"><i class="bi bi-hospital"></i></span>
                    <h3 class="fw-bold text-dark mb-0">SmartCare Diagnostics</h3>
                </div>
                <div class="text-secondary small">
                    Department of Pathology & Clinical Biochemistry<br>
                    NABL Accredited Reference Laboratory<br>
                    Tel: +91 (011) 4567-8900 | lab@smartcare.org
                </div>
            </div>
            <div class="text-end">
                <span class="badge ${labTest.status eq 'COMPLETED' ? 'badge-confirmed' : 'badge-pending'} fs-6 mb-2">
                    ${labTest.status}
                </span>
                <div class="text-secondary small">Lab Order ID: <strong>#LAB-${labTest.testId}</strong></div>
                <div class="text-secondary small">Sample Date: <fmt:formatDate value="${labTest.testDate}" pattern="dd MMM yyyy" /></div>
            </div>
        </div>

        <!-- Patient & Doctor Information Box -->
        <div class="p-3 bg-light rounded mb-4 border">
            <div class="row g-2">
                <div class="col-sm-6 col-md-3">
                    <span class="text-muted small d-block">Patient Name:</span>
                    <strong class="text-dark">${labTest.patientName}</strong>
                </div>
                <div class="col-sm-6 col-md-3">
                    <span class="text-muted small d-block">Patient ID:</span>
                    <span class="fw-bold">#PT-${labTest.patientId}</span>
                </div>
                <div class="col-sm-6 col-md-3">
                    <span class="text-muted small d-block">Referred By:</span>
                    <span class="fw-semibold">Dr. ${labTest.doctorName}</span>
                </div>
                <div class="col-sm-6 col-md-3">
                    <span class="text-muted small d-block">Report Generated:</span>
                    <span class="fw-semibold">
                        <c:choose>
                            <c:when test="${not empty labTest.completedAt}">
                                <fmt:formatDate value="${labTest.completedAt}" pattern="dd MMM yyyy, hh:mm a" />
                            </c:when>
                            <c:otherwise>Pending Analysis</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>

        <!-- Investigation Report Section -->
        <h5 class="fw-bold text-primary mb-3">
            <i class="bi bi-flask me-2"></i> Investigation: ${labTest.testName}
        </h5>

        <div class="table-responsive mb-4">
            <table class="table table-bordered">
                <thead class="table-light">
                    <tr>
                        <th style="width: 40%;">Parameter / Investigation</th>
                        <th style="width: 30%;">Result Found</th>
                        <th style="width: 30%;">Biological Reference Interval</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-bold text-dark">${labTest.testName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${empty labTest.result}">
                                    <span class="text-warning fw-semibold"><i class="bi bi-hourglass-split me-1"></i> Under Processing</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="fw-bold text-primary fs-6">${labTest.result}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-secondary">
                            ${empty labTest.normalRange ? 'As specified per pathology standard' : labTest.normalRange}
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Interpretation / Remarks -->
        <div class="p-3 rounded border bg-light mb-4">
            <h6 class="fw-bold text-dark mb-1"><i class="bi bi-info-circle me-1 text-primary"></i> Pathologist Remarks & Clinical Interpretation:</h6>
            <p class="mb-0 text-secondary small">
                ${empty labTest.remarks ? 'Test results have been clinically evaluated. Correlate with clinical condition.' : labTest.remarks}
            </p>
        </div>

        <!-- Signature Line -->
        <div class="row pt-4 mt-5 border-top align-items-end">
            <div class="col-6">
                <div class="small text-muted">
                    <p class="mb-1"><i class="bi bi-check-circle-fill text-success me-1"></i> Quality Checked by Medical Biochemistry</p>
                    <p class="mb-0">Electronically generated authentic clinical report.</p>
                </div>
            </div>
            <div class="col-6 text-end">
                <div class="d-inline-block text-center">
                    <div class="signature-line ms-auto"></div>
                    <div class="fw-bold text-dark">Chief Pathologist</div>
                    <div class="text-muted small">MD Pathology, SmartCare Diagnostic Labs</div>
                </div>
            </div>
        </div>

        <!-- Action Buttons (Print / Back) -->
        <div class="mt-5 text-center no-print">
            <button type="button" class="btn btn-primary px-4 me-2" onclick="window.print()">
                <i class="bi bi-printer me-1"></i> Print Report
            </button>
            <button type="button" class="btn btn-outline-secondary px-4" onclick="window.history.back()">
                <i class="bi bi-arrow-left me-1"></i> Back
            </button>
        </div>
    </div>

</body>
</html>
