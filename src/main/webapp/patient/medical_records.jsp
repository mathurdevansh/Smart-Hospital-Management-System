<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Clinical Records" />
<c:set var="activePage" value="records" />
<c:set var="pageHeading" value="My Electronic Health Records (EHR)" />
<c:set var="pageSubheading" value="Official clinical diagnoses, symptoms recorded, and physician treatment plans" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-heart-pulse me-2 text-primary"></i> Clinical Encounter Histories</h5>
                <span class="badge bg-secondary">${records.size()} Records</span>
            </div>
            <div class="p-3">
                <c:choose>
                    <c:when test="${empty records}">
                        <div class="text-center text-muted py-5">
                            <i class="bi bi-file-medical display-4 text-muted mb-3 d-block"></i>
                            <p class="mb-0">No medical diagnosis records on file yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="r" items="${records}">
                                <div class="col-12">
                                    <div class="card border rounded-3 p-4 bg-white shadow-sm">
                                        <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                                            <div>
                                                <h5 class="fw-bold text-dark mb-1">${r.diagnosis}</h5>
                                                <span class="small text-muted"><i class="bi bi-calendar3 me-1"></i> Recorded on <fmt:formatDate value="${r.recordDate}" pattern="dd MMM yyyy, HH:mm" /></span>
                                            </div>
                                            <div class="text-end">
                                                <span class="badge bg-primary bg-opacity-10 text-primary border px-3 py-2">Attending: Dr. ${r.doctorName}</span>
                                            </div>
                                        </div>

                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <div class="small fw-bold text-secondary mb-1">Reported Symptoms</div>
                                                <div class="p-2 rounded bg-light small text-dark">${r.symptoms}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="small fw-bold text-secondary mb-1">Prescribed Treatment & Regimen</div>
                                                <div class="p-2 rounded bg-light small text-dark">${r.treatment}</div>
                                            </div>
                                            <c:if test="${not empty r.notes}">
                                                <div class="col-12">
                                                    <div class="small fw-bold text-secondary mb-1">Clinical Remarks</div>
                                                    <div class="small text-muted">${r.notes}</div>
                                                </div>
                                            </c:if>
                                            <c:if test="${r.followUpDate != null}">
                                                <div class="col-12">
                                                    <span class="badge bg-info text-dark">
                                                        <i class="bi bi-calendar-check me-1"></i> Next Follow-up Recommended: ${r.followUpDate}
                                                    </span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/includes/footer.jsp" />
