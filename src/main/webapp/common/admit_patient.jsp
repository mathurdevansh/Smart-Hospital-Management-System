<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="In-Patient Ward Admission" />
<c:set var="activePage" value="admissions" />
<c:set var="pageHeading" value="Inpatient Ward Admission Entry" />
<c:set var="pageSubheading" value="Admit registered patient to hospital ward, assign attending physician, and reserve bed" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Flash Messages -->
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
                        <h5><i class="bi bi-box-arrow-in-right me-2 text-primary"></i> Patient Hospitalization Intake</h5>
                        <a href="${pageContext.request.contextPath}/admission" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-arrow-left me-1"></i> View Admissions List
                        </a>
                    </div>

                    <form action="${pageContext.request.contextPath}/admission" method="POST" class="p-3">
                        <input type="hidden" name="action" value="admit">

                        <div class="row g-3">
                            <!-- Patient Selection -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Select Patient <span class="text-danger">*</span></label>
                                <select name="patientId" class="form-select" required>
                                    <option value="">-- Choose Patient --</option>
                                    <c:forEach var="p" items="${patients}">
                                        <option value="${p.patientId}">
                                            ${p.fullName} (ID: #${p.patientId}, Blood: ${p.bloodGroup})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Doctor Selection -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Attending Doctor <span class="text-danger">*</span></label>
                                <select name="doctorId" class="form-select" required>
                                    <option value="">-- Choose Doctor --</option>
                                    <c:forEach var="d" items="${doctors}">
                                        <option value="${d.doctorId}">
                                            Dr. ${d.doctorName} (${d.specialization})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Ward Room Bed Selection -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Assign Bed / Ward Room <span class="text-danger">*</span></label>
                                <select name="roomId" class="form-select" required>
                                    <option value="">-- Choose Available Bed --</option>
                                    <c:choose>
                                        <c:when test="${empty availableRooms}">
                                            <option disabled>No rooms currently available!</option>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="rm" items="${availableRooms}">
                                                <option value="${rm.roomId}">
                                                    Room ${rm.roomNumber} - ${rm.roomType} (Floor ${rm.floorNumber} | ₹${rm.dailyRate}/day)
                                                </option>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                                <div class="form-text small">Only rooms with status 'AVAILABLE' are shown.</div>
                            </div>

                            <!-- Expected Discharge Date -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Expected Discharge Date</label>
                                <input type="date" name="expectedDischarge" class="form-control">
                                <div class="form-text small">Estimated recovery milestone.</div>
                            </div>

                            <!-- Admission Reason / Clinical Diagnosis -->
                            <div class="col-12">
                                <label class="form-label fw-semibold">Primary Admission Reason / Diagnosis <span class="text-danger">*</span></label>
                                <textarea name="reason" class="form-control" rows="3" placeholder="e.g. Acute myocardial infarction, observation post angioplasty, IV antibiotics protocol..." required></textarea>
                            </div>

                            <div class="col-12 pt-3">
                                <button type="submit" class="btn btn-primary px-4">
                                    <i class="bi bi-check-circle me-1"></i> Confirm Admission & Allocate Bed
                                </button>
                                <a href="${pageContext.request.contextPath}/admission" class="btn btn-outline-secondary ms-2">
                                    Cancel
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>

    <jsp:include page="/includes/footer.jsp" />
</main>
</body>
</html>
