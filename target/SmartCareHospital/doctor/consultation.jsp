<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Clinical Consultation" />
<c:set var="activePage" value="appointments" />
<c:set var="pageHeading" value="Doctor Clinical Encounter" />
<c:set var="pageSubheading" value="Conduct consultation, record diagnosis, prescribe medications, and order diagnostics" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Patient Header Card -->
        <div class="card border-0 shadow-sm rounded-4 mb-4 bg-primary text-white p-4">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <span class="badge bg-light text-primary px-3 py-1 rounded-pill fw-bold mb-2">
                        <i class="bi bi-person-fill me-1"></i> Patient #${patient.patientId} &bull; Appointment #${appointment.appointmentId}
                    </span>
                    <h3 class="fw-bold mb-1">${patient.patientName}</h3>
                    <p class="mb-2 opacity-75 small">
                        ${patient.gender} &bull; Blood Group: <strong>${patient.bloodGroup}</strong> &bull; DOB: ${patient.dob} &bull; Phone: ${patient.phone}
                    </p>
                    <div class="small bg-white bg-opacity-10 p-2 rounded-2">
                        <strong>Chief Complaint:</strong> ${appointment.reason}
                    </div>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <div class="small opacity-75">Medical History & Allergies:</div>
                    <div class="fw-semibold small">${empty patient.medicalHistorySummary ? 'No known drug allergies' : patient.medicalHistorySummary}</div>
                </div>
            </div>
        </div>

        <!-- Consultation Form -->
        <form action="${pageContext.request.contextPath}/doctor" method="POST">
            <input type="hidden" name="action" value="saveConsultation">
            <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
            <input type="hidden" name="patientId" value="${patient.patientId}">

            <div class="row g-4 mb-4">
                <!-- Clinical Diagnosis Section -->
                <div class="col-lg-6">
                    <div class="content-panel h-100">
                        <div class="panel-header">
                            <h5><i class="bi bi-clipboard2-pulse-fill me-2 text-primary"></i> Clinical Assessment & Diagnosis</h5>
                        </div>
                        <div class="p-4">
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Observed Symptoms & Vital Signs</label>
                                <textarea name="symptoms" class="form-control" rows="3" required placeholder="e.g. Low-grade fever, chest discomfort, productive cough for 3 days"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Primary Diagnosis</label>
                                <input type="text" name="diagnosis" class="form-control" required placeholder="e.g. Acute Bronchitis / Stage 1 Hypertension">
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Recommended Treatment & Clinical Notes</label>
                                <textarea name="treatment" class="form-control" rows="3" placeholder="Treatment protocols, lifestyle modifications, and patient counselling"></textarea>
                            </div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Recommended Follow-up Date</label>
                                    <input type="date" name="followUpDate" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Doctor Internal Remarks</label>
                                    <input type="text" name="notes" class="form-control" placeholder="Optional internal notes">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Laboratory Investigation Order -->
                <div class="col-lg-6">
                    <div class="content-panel h-100">
                        <div class="panel-header">
                            <h5><i class="bi bi-flask-fill me-2 text-danger"></i> Diagnostic Pathology / Lab Test Order</h5>
                        </div>
                        <div class="p-4">
                            <p class="text-muted small mb-3">Order diagnostic lab tests for this patient. The lab technician will record results upon completion.</p>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Test Name</label>
                                <input type="text" name="labTestName" class="form-control" placeholder="e.g. Complete Blood Count (CBC), Lipid Profile, Chest X-Ray">
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Expected Clinical Normal Range</label>
                                <input type="text" name="labTestNormalRange" class="form-control" placeholder="e.g. Fasting: 70-99 mg/dL">
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Clinical Instructions / Remarks</label>
                                <input type="text" name="labTestRemarks" class="form-control" placeholder="e.g. Fasting sample required, urgent stats">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- E-Prescription Items Section -->
            <div class="content-panel mb-4">
                <div class="panel-header">
                    <h5><i class="bi bi-capsule me-2 text-success"></i> Prescription & Medication Plan</h5>
                    <button type="button" class="btn btn-sm btn-outline-success rounded-pill" onclick="addPrescriptionRow()">
                        <i class="bi bi-plus-lg me-1"></i> Add Medication
                    </button>
                </div>
                <div class="table-responsive p-3">
                    <table class="table table-bordered align-middle" id="prescriptionTable">
                        <thead class="table-light">
                            <tr class="small text-muted">
                                <th style="width: 28%;">Medicine Name</th>
                                <th style="width: 15%;">Dosage</th>
                                <th style="width: 18%;">Frequency</th>
                                <th style="width: 14%;">Duration</th>
                                <th style="width: 20%;">Instructions</th>
                                <th style="width: 5%;"></th>
                            </tr>
                        </thead>
                        <tbody id="prescriptionItemsBody">
                            <tr>
                                <td>
                                    <select name="medicineId" class="form-select form-select-sm">
                                        <option value="">-- Select Pharmaceutical --</option>
                                        <c:forEach var="med" items="${medicines}">
                                            <option value="${med.medicineId}">${med.medicineName} (${med.category})</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td><input type="text" name="dosage" class="form-control form-control-sm" placeholder="e.g. 500mg"></td>
                                <td>
                                    <select name="frequency" class="form-select form-select-sm">
                                        <option value="Once Daily (OD)">Once Daily (OD)</option>
                                        <option value="Twice Daily (BD)">Twice Daily (BD)</option>
                                        <option value="Thrice Daily (TDS)">Thrice Daily (TDS)</option>
                                        <option value="Four Times Daily (QID)">Four Times Daily (QID)</option>
                                        <option value="As Needed (SOS)">As Needed (SOS)</option>
                                    </select>
                                </td>
                                <td><input type="text" name="duration" class="form-control form-control-sm" placeholder="e.g. 5 Days"></td>
                                <td><input type="text" name="instruction" class="form-control form-control-sm" placeholder="e.g. After meals with water"></td>
                                <td class="text-center">
                                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="removePrescriptionRow(this)">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Submit Button Bar -->
            <div class="d-flex justify-content-between align-items-center">
                <a href="${pageContext.request.contextPath}/doctor?action=appointments" class="btn btn-secondary px-4">
                    <i class="bi bi-arrow-left me-1"></i> Cancel & Back
                </a>
                <button type="submit" class="btn btn-success btn-lg px-5 shadow-sm fw-bold">
                    <i class="bi bi-check-circle-fill me-1"></i> Conclude Consultation & Generate Bill
                </button>
            </div>
        </form>

    </div>
</main>

<jsp:include page="/includes/footer.jsp" />
