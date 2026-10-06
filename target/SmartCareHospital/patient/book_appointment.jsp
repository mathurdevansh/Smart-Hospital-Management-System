<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Book Doctor Appointment" />
<c:set var="activePage" value="book" />
<c:set var="pageHeading" value="Schedule an Outpatient Consultation" />
<c:set var="pageSubheading" value="Select specialty, choose your attending physician, and book an available consultation slot" />

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
                        <h5><i class="bi bi-calendar-plus-fill me-2 text-primary"></i> Consultation Booking Form</h5>
                    </div>
                    <div class="p-4">
                        <form action="${pageContext.request.contextPath}/patient" method="POST">
                            <input type="hidden" name="action" value="bookAppointment">

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">1. Select Medical Department</label>
                                    <select name="departmentId" class="form-select" required>
                                        <option value="">-- Choose Clinical Department --</option>
                                        <c:forEach var="dept" items="${departments}">
                                            <option value="${dept.departmentId}">${dept.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">2. Select Doctor</label>
                                    <select name="doctorId" class="form-select" required>
                                        <option value="">-- Choose Attending Doctor --</option>
                                        <c:forEach var="doc" items="${doctors}">
                                            <option value="${doc.doctorId}">
                                                ${doc.doctorName} (${doc.specialization}) - ₹${doc.consultationFee}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">3. Preferred Appointment Date</label>
                                    <input type="date" name="appointmentDate" class="form-control" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label small fw-bold">4. Appointment Time Slot</label>
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
                                        <option value="16:00">04:00 PM</option>
                                    </select>
                                </div>

                                <div class="col-12">
                                    <label class="form-label small fw-bold">5. Medical Concerns / Reason for Visit</label>
                                    <textarea name="reason" class="form-control" rows="3" required placeholder="Describe your symptoms, discomfort, or medical reason for consultation"></textarea>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <a href="${pageContext.request.contextPath}/patient?action=dashboard" class="btn btn-secondary px-4">Cancel</a>
                                <button type="submit" class="btn btn-primary px-5 fw-bold shadow-sm">
                                    <i class="bi bi-calendar-check me-1"></i> Confirm Booking
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
