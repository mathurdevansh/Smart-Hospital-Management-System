<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Register New Patient" />
<c:set var="activePage" value="register" />
<c:set var="pageHeading" value="New Patient Intake & Registration" />
<c:set var="pageSubheading" value="Capture demographic credentials, emergency contacts, and initialize patient portal access" />

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
            <div class="col-lg-9">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-person-plus-fill me-2 text-primary"></i> Patient Intake Form</h5>
                    </div>
                    <div class="p-4">
                        <form action="${pageContext.request.contextPath}/receptionist" method="POST">
                            <input type="hidden" name="action" value="registerPatient">

                            <h6 class="fw-bold text-secondary mb-3"><i class="bi bi-person-fill text-muted me-1"></i> Patient Demographics</h6>
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Full Legal Name</label>
                                    <input type="text" name="patientName" class="form-control" required placeholder="e.g. Anand Kulkarni">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Email Address (Portal Username)</label>
                                    <input type="email" name="email" class="form-control" required placeholder="e.g. anand@gmail.com">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Default Portal Password</label>
                                    <input type="password" name="password" class="form-control" required placeholder="Min 6 characters (e.g. Password@123)">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Phone Number</label>
                                    <input type="text" name="phone" class="form-control" required placeholder="+91 98765 00000">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-bold">Date of Birth</label>
                                    <input type="date" name="dob" class="form-control" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-bold">Gender</label>
                                    <select name="gender" class="form-select" required>
                                        <option value="MALE">Male</option>
                                        <option value="FEMALE">Female</option>
                                        <option value="OTHER">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-bold">Blood Group</label>
                                    <select name="bloodGroup" class="form-select" required>
                                        <option value="O+">O+</option>
                                        <option value="O-">O-</option>
                                        <option value="A+">A+</option>
                                        <option value="A-">A-</option>
                                        <option value="B+">B+</option>
                                        <option value="B-">B-</option>
                                        <option value="AB+">AB+</option>
                                        <option value="AB-">AB-</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label small fw-bold">Street Address</label>
                                    <textarea name="address" class="form-control" rows="2" required placeholder="Full street address, city, state"></textarea>
                                </div>
                            </div>

                            <h6 class="fw-bold text-secondary mb-3"><i class="bi bi-shield-heart text-muted me-1"></i> Emergency Contact & Clinical History</h6>
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Emergency Contact Person</label>
                                    <input type="text" name="emergencyContactName" class="form-control" required placeholder="e.g. Radhika (Spouse)">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Emergency Phone</label>
                                    <input type="text" name="emergencyContactPhone" class="form-control" required placeholder="+91 98111 00000">
                                </div>
                                <div class="col-12">
                                    <label class="form-label small fw-bold">Medical History & Allergies (If Any)</label>
                                    <textarea name="medicalHistorySummary" class="form-control" rows="2" placeholder="Chronic conditions, diabetes, penicillin allergy, past major surgeries"></textarea>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/receptionist?action=patients" class="btn btn-secondary px-4">Cancel</a>
                                <button type="submit" class="btn btn-primary px-5 fw-bold shadow-sm">
                                    <i class="bi bi-check-circle-fill me-1"></i> Complete Patient Registration
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
