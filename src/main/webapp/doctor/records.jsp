<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Clinical Medical Records" />
<c:set var="activePage" value="records" />
<c:set var="pageHeading" value="Electronic Medical Records (EMR)" />
<c:set var="pageSubheading" value="Archived patient diagnoses, clinical assessments, and prescribed regimens" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-journal-medical me-2 text-primary"></i> Patient Medical Histories</h5>
                <span class="badge bg-secondary">${records.size()} Records</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Record #</th>
                            <th>Encounter Date</th>
                            <th>Patient Name</th>
                            <th>Symptoms</th>
                            <th>Diagnosis</th>
                            <th>Treatment Plan</th>
                            <th>Follow-up</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty records}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No clinical records found.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="rec" items="${records}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#REC-${rec.recordId}</td>
                                        <td class="small text-muted"><fmt:formatDate value="${rec.recordDate}" pattern="dd MMM yyyy, HH:mm" /></td>
                                        <td class="fw-bold">${rec.patientName}</td>
                                        <td class="small" style="max-width: 200px;">${rec.symptoms}</td>
                                        <td class="fw-semibold text-dark">${rec.diagnosis}</td>
                                        <td class="small text-muted" style="max-width: 250px;">${rec.treatment}</td>
                                        <td class="small text-muted">${rec.followUpDate != null ? rec.followUpDate : 'None'}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/includes/footer.jsp" />
