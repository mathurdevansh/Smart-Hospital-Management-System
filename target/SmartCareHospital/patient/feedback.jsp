<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Doctor & Hospital Feedback" />
<c:set var="activePage" value="feedback" />
<c:set var="pageHeading" value="Patient Feedback & Satisfaction" />
<c:set var="pageSubheading" value="Your experience helps us continually raise the quality of our medical care" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Flash Messages -->
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Thank you! Your feedback was submitted successfully.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="content-panel">
                    <div class="panel-header">
                        <h5><i class="bi bi-star-fill text-warning me-2"></i> Share Your Clinical Experience</h5>
                    </div>
                    <div class="p-4">
                        <form action="${pageContext.request.contextPath}/patient" method="POST">
                            <input type="hidden" name="action" value="submitFeedback">

                            <div class="mb-3">
                                <label class="form-label small fw-bold">Select Attending Physician (Optional)</label>
                                <select name="doctorId" class="form-select">
                                    <option value="">-- General Hospital Facility --</option>
                                    <c:forEach var="doc" items="${doctors}">
                                        <option value="${doc.doctorId}">${doc.doctorName} (${doc.specialization})</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label small fw-bold">Overall Rating</label>
                                <select name="rating" class="form-select" required>
                                    <option value="5">⭐⭐⭐⭐⭐ Excellent (5/5)</option>
                                    <option value="4">⭐⭐⭐⭐ Very Good (4/5)</option>
                                    <option value="3">⭐⭐⭐ Good / Average (3/5)</option>
                                    <option value="2">⭐⭐ Fair / Needs Improvement (2/5)</option>
                                    <option value="1">⭐ Poor Experience (1/5)</option>
                                </select>
                            </div>

                            <div class="mb-4">
                                <label class="form-label small fw-bold">Comments, Staff Courtesy & Clinical Observations</label>
                                <textarea name="comments" class="form-control" rows="4" required placeholder="Please describe how your physician, nursing staff, or outpatient facility performed during your visit..."></textarea>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/patient?action=dashboard" class="btn btn-secondary px-4">Cancel</a>
                                <button type="submit" class="btn btn-primary px-5 fw-bold shadow-sm">
                                    <i class="bi bi-send-fill me-1"></i> Submit Review
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
