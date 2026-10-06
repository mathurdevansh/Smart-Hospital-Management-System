<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Desk Appointment Booking" />
<c:set var="activePage" value="book" />
<c:set var="pageHeading" value="Schedule Patient Consultation" />
<c:set var="pageSubheading" value="Front-desk booking for walk-in and calling outpatients" />

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
                        <h5><i class="bi bi-calendar-plus-fill me-2 text-primary"></i> Front Desk Consultation Booking</h5>
                    </div>
                    <div class="p-4">
                        <form action="${pageContext.request.contextPath}/receptionist" method="POST">
                            <input type="hidden" name="action" value="bookAppointment">

                            <div class="row g-3 mb-3">
                                <div class="col-12">
                                    <label class="form-label small fw-bold">Select Registered Patient</label>
                                    <select name="patientId" class="form-select" required>
                                        <option value="">-- Choose Patient --</option>
                                        <c:forEach var="p" items="${patients}">
                                            <option value="${p.patientId}">#PAT-${p.patientId} - ${p.patientName} (${p.phone})</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Department</label>
                                    <select name="departmentId" class="form-select" required>
                                        <option value="">-- Clinical Unit --</option>
                                        <c:forEach var="dept" items="${departments}">
                                            <option value="${dept.departmentId}">${dept.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Physician</label>
                                    <select name="doctorId" class="form-select" required>
                                        <option value="">-- Attending Doctor --</option>
                                        <c:forEach var="doc" items="${doctors}">
                                            <option value="${doc.doctorId}">
                                                ${doc.doctorName} (${doc.specialization}) - Room: ${doc.roomNo}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Date of Consultation</label>
                                    <input type="date" name="appointmentDate" class="form-control" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">Time Slot</label>
                                    <select name="appointmentTime" class="form-select" required>
                                        <option value="09:00">09:00 AM</option>
                                        <option value="09:30">09:30 AM</option>
                                        <option value="10:00">10:00 AM</option>
                                        <option value="10:30">10:30 AM</option>
                                        <option value="11:00">11:00 AM</option>
                                        <option value="11:30">11:30 AM</option>
                                        <option value="12:00">12:00 PM</option>
                                        <option value="14:00">02:00 PM</option>
                                        <option value="14:30">02:30 PM</option>
                                        <option value="15:00">03:00 PM</option>
                                        <option value="15:30">03:30 PM</option>
                                    </select>
                                </div>

                                <div class="col-12">
                                    <label class="form-label small fw-bold">Reason for Visit / Triage Notes</label>
                                    <textarea name="reason" class="form-control" rows="3" required placeholder="Patient chief complaints or follow-up note"></textarea>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <a href="${pageContext.request.contextPath}/receptionist?action=appointments" class="btn btn-secondary px-4">Cancel</a>
                                <button type="submit" class="btn btn-primary px-5 fw-bold shadow-sm">
                                    <i class="bi bi-calendar-check me-1"></i> Confirm & Schedule
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
