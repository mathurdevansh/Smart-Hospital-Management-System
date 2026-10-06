<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Official Medical Prescription #RX-${prescription.prescriptionId} | SmartCare Hospital</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Playfair+Display:ital,wght@1,600;1,700&display=swap" rel="stylesheet">
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
        .rx-card {
            max-width: 820px;
            margin: auto;
            background: #ffffff;
            border-radius: var(--radius-md);
            border: 1px solid var(--border);
            padding: 3.5rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            position: relative;
        }
        .rx-symbol {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 700;
            font-style: italic;
            color: #2563eb;
            line-height: 1;
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
            .rx-card {
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

    <!-- Printable Rx Card -->
    <div class="rx-card">

        <!-- Top Hospital & Doctor Letterhead -->
        <div class="d-flex justify-content-between align-items-start border-bottom pb-4 mb-4">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="sidebar-logo-icon" style="width:36px; height:36px; font-size:1.2rem;"><i class="bi bi-hospital"></i></span>
                    <h3 class="fw-bold text-dark mb-0">SmartCare Hospital</h3>
                </div>
                <div class="text-secondary small">
                    Multi-Specialty Healthcare & Research Institute<br>
                    Plot 42, Health City Avenue, Sector 5<br>
                    Tel: +91 (011) 4567-8900 | emergency@smartcare.org
                </div>
            </div>
            <div class="text-end">
                <h5 class="fw-bold text-primary mb-1">Dr. ${prescription.doctorName}</h5>
                <div class="text-muted small fw-medium">${prescription.doctorSpecialization}</div>
                <div class="text-secondary small">Reg. No: MED-IN-${prescription.doctorId}098</div>
                <span class="badge bg-primary-subtle text-primary mt-2">Rx ID: #RX-${prescription.prescriptionId}</span>
            </div>
        </div>

        <!-- Patient Demographics Bar -->
        <div class="p-3 bg-light rounded mb-4 border">
            <div class="row g-2">
                <div class="col-sm-6 col-md-3">
                    <span class="text-muted small d-block">Patient Name:</span>
                    <strong class="text-dark">${prescription.patientName}</strong>
                </div>
                <div class="col-sm-6 col-md-3">
                    <span class="text-muted small d-block">Patient ID:</span>
                    <span class="fw-bold">#PT-${prescription.patientId}</span>
                </div>
                <div class="col-sm-6 col-md-3">
                    <span class="text-muted small d-block">Date of Consultation:</span>
                    <span class="fw-semibold"><fmt:formatDate value="${prescription.prescriptionDate}" pattern="dd MMM yyyy" /></span>
                </div>
                <div class="col-sm-6 col-md-3">
                    <span class="text-muted small d-block">Time:</span>
                    <span class="fw-semibold"><fmt:formatDate value="${prescription.prescriptionDate}" pattern="hh:mm a" /></span>
                </div>
            </div>
        </div>

        <!-- Prescription Body -->
        <div class="d-flex align-items-center mb-3">
            <span class="rx-symbol me-3">℞</span>
            <span class="text-secondary fw-semibold small text-uppercase letter-spacing-1">Prescribed Medical Treatment</span>
        </div>

        <!-- Medicines Table -->
        <div class="table-responsive mb-4">
            <table class="table table-bordered">
                <thead class="table-light">
                    <tr>
                        <th style="width: 5%;">#</th>
                        <th style="width: 35%;">Medicine & Strength</th>
                        <th style="width: 20%;">Dosage</th>
                        <th style="width: 20%;">Frequency</th>
                        <th style="width: 20%;">Duration</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty prescription.items}">
                            <tr>
                                <td colspan="5" class="text-center text-muted py-3">No specific medications itemized. See clinical advice below.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="item" items="${prescription.items}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>
                                        <div class="fw-bold text-dark">${item.medicineName}</div>
                                        <c:if test="${not empty item.instructions}">
                                            <div class="text-muted small fst-italic"><i class="bi bi-info-circle me-1"></i>${item.instructions}</div>
                                        </c:if>
                                    </td>
                                    <td class="fw-semibold">${item.dosage}</td>
                                    <td>${item.frequency}</td>
                                    <td>${item.duration}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Clinical Notes & Doctor Advice -->
        <c:if test="${not empty prescription.notes}">
            <div class="mb-5 p-3 rounded border border-info-subtle bg-info-subtle">
                <h6 class="fw-bold text-primary mb-1"><i class="bi bi-chat-square-text me-1"></i> Dietary & Clinical Instructions:</h6>
                <p class="mb-0 text-dark small">${prescription.notes}</p>
            </div>
        </c:if>

        <!-- Doctor Signature and Footer -->
        <div class="row pt-4 mt-5 border-top align-items-end">
            <div class="col-6">
                <div class="small text-muted">
                    <p class="mb-1"><i class="bi bi-shield-check text-success me-1"></i> Electronically Signed & Verified</p>
                    <p class="mb-0">Valid for 30 days from consultation date.</p>
                </div>
            </div>
            <div class="col-6 text-end">
                <div class="d-inline-block text-center">
                    <div class="signature-line ms-auto"></div>
                    <div class="fw-bold text-dark">Dr. ${prescription.doctorName}</div>
                    <div class="text-muted small">${prescription.doctorSpecialization}</div>
                </div>
            </div>
        </div>

        <!-- Action Buttons (Print / Back) -->
        <div class="mt-5 text-center no-print">
            <button type="button" class="btn btn-primary px-4 me-2" onclick="window.print()">
                <i class="bi bi-printer me-1"></i> Print Prescription
            </button>
            <button type="button" class="btn btn-outline-secondary px-4" onclick="window.history.back()">
                <i class="bi bi-arrow-left me-1"></i> Return Back
            </button>
        </div>

    </div>

</body>
</html>
