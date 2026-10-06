<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="My Health Profile" />
<c:set var="activePage" value="profile" />
<c:set var="pageHeading" value="Personal Health & Contact Profile" />
<c:set var="pageSubheading" value="Update your contact information, emergency relations, and allergy details" />

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

        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-person-circle me-2 text-primary"></i> Patient Demographics & Profile</h5>
                    </div>
                    <div class="p-4">
                        <form action="${pageContext.request.contextPath}/patient" method="POST">
                            <input type="hidden" name="action" value="updateProfile">

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Full Name</label>
                                    <input type="text" name="patientName" class="form-control" value="${patient.patientName}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Phone Number</label>
                                    <input type="text" name="phone" class="form-control" value="${patient.phone}" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-bold">Date of Birth</label>
                                    <input type="date" name="dob" class="form-control" value="${patient.dob}" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-bold">Gender</label>
                                    <select name="gender" class="form-select" required>
                                        <option value="MALE" ${patient.gender eq 'MALE' ? 'selected' : ''}>Male</option>
                                        <option value="FEMALE" ${patient.gender eq 'FEMALE' ? 'selected' : ''}>Female</option>
                                        <option value="OTHER" ${patient.gender eq 'OTHER' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-bold">Blood Group</label>
                                    <select name="bloodGroup" class="form-select" required>
                                        <option value="O+" ${patient.bloodGroup eq 'O+' ? 'selected' : ''}>O+</option>
                                        <option value="O-" ${patient.bloodGroup eq 'O-' ? 'selected' : ''}>O-</option>
                                        <option value="A+" ${patient.bloodGroup eq 'A+' ? 'selected' : ''}>A+</option>
                                        <option value="A-" ${patient.bloodGroup eq 'A-' ? 'selected' : ''}>A-</option>
                                        <option value="B+" ${patient.bloodGroup eq 'B+' ? 'selected' : ''}>B+</option>
                                        <option value="B-" ${patient.bloodGroup eq 'B-' ? 'selected' : ''}>B-</option>
                                        <option value="AB+" ${patient.bloodGroup eq 'AB+' ? 'selected' : ''}>AB+</option>
                                        <option value="AB-" ${patient.bloodGroup eq 'AB-' ? 'selected' : ''}>AB-</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label small fw-bold">Residential Street Address</label>
                                    <textarea name="address" class="form-control" rows="2" required>${patient.address}</textarea>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Emergency Contact Name & Relation</label>
                                    <input type="text" name="emergencyContactName" class="form-control" value="${patient.emergencyContactName}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Emergency Contact Phone</label>
                                    <input type="text" name="emergencyContactPhone" class="form-control" value="${patient.emergencyContactPhone}" required>
                                </div>
                                <div class="col-12">
                                    <label class="form-label small fw-bold">Known Medical History, Surgeries & Drug Sensitivities</label>
                                    <textarea name="medicalHistorySummary" class="form-control" rows="3">${patient.medicalHistorySummary}</textarea>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <a href="${pageContext.request.contextPath}/patient?action=dashboard" class="btn btn-secondary px-4">Cancel</a>
                                <button type="submit" class="btn btn-primary px-5 fw-bold shadow-sm">
                                    <i class="bi bi-save me-1"></i> Update Health Profile
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
