<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Prescriptions" />
<c:set var="activePage" value="prescriptions" />
<c:set var="pageHeading" value="My Digital E-Prescriptions" />
<c:set var="pageSubheading" value="Official prescription orders with dosages, frequencies, and administration guidelines" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-capsule me-2 text-success"></i> Active & Past Prescriptions</h5>
                <span class="badge bg-secondary">${prescriptions.size()} Prescriptions</span>
            </div>
            <div class="p-3">
                <c:choose>
                    <c:when test="${empty prescriptions}">
                        <div class="text-center text-muted py-5">
                            <i class="bi bi-capsule display-4 text-muted mb-3 d-block"></i>
                            <p class="mb-0">No prescriptions found on your health record.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="p" items="${prescriptions}">
                            <div class="card border rounded-3 p-4 mb-3 bg-white shadow-sm">
                                <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                                    <div>
                                        <h5 class="fw-bold text-dark mb-0">Prescription #RX-${p.prescriptionId}</h5>
                                        <span class="small text-muted">Issued on <fmt:formatDate value="${p.prescriptionDate}" pattern="dd MMM yyyy, HH:mm" /></span>
                                    </div>
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="badge bg-primary bg-opacity-10 text-primary border px-3 py-2">
                                            Dr. ${p.doctorName} (${p.doctorSpecialization})
                                        </span>
                                        <a href="${pageContext.request.contextPath}/prescription?action=view&id=${p.prescriptionId}" 
                                           class="btn btn-outline-success btn-sm rounded-pill px-3" target="_blank">
                                            <i class="bi bi-printer me-1"></i> Print Rx Slip
                                        </a>
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <table class="table table-sm table-bordered align-middle mb-2">
                                        <thead class="table-light small">
                                            <tr>
                                                <th>Medicine Name</th>
                                                <th>Dosage</th>
                                                <th>Frequency</th>
                                                <th>Duration</th>
                                                <th>Instructions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="it" items="${p.items}">
                                                <tr class="small">
                                                    <td class="fw-bold text-primary">${it.medicineName}</td>
                                                    <td>${it.dosage}</td>
                                                    <td><span class="badge bg-light text-dark border">${it.frequency}</span></td>
                                                    <td>${it.duration}</td>
                                                    <td class="text-muted">${it.instructions}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <c:if test="${not empty p.notes}">
                                    <div class="small text-muted mt-2">
                                        <strong>Physician Advice:</strong> ${p.notes}
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/includes/footer.jsp" />
