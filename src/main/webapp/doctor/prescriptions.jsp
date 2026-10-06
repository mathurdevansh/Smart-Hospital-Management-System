<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Prescriptions Log" />
<c:set var="activePage" value="prescriptions" />
<c:set var="pageHeading" value="Doctor E-Prescriptions" />
<c:set var="pageSubheading" value="Prescription history, medication instructions, and pharmacy dispensing slips" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-file-earmark-medical me-2 text-primary"></i> Prescriptions Issued</h5>
                <span class="badge bg-secondary">${prescriptions.size()} Prescriptions</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Rx ID</th>
                            <th>Date Issued</th>
                            <th>Patient Name</th>
                            <th>Clinical Notes</th>
                            <th>Item Count</th>
                            <th class="text-end">Prescription Slip</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty prescriptions}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">No prescriptions issued yet.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="p" items="${prescriptions}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#RX-${p.prescriptionId}</td>
                                        <td class="small text-muted"><fmt:formatDate value="${p.prescriptionDate}" pattern="dd MMM yyyy, HH:mm" /></td>
                                        <td class="fw-bold">${p.patientName}</td>
                                        <td class="small text-muted">${empty p.notes ? 'Standard medication course' : p.notes}</td>
                                        <td><span class="badge bg-light text-dark border">${p.items.size()} medicines</span></td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/prescription?action=view&id=${p.prescriptionId}" 
                                               class="btn btn-sm btn-outline-primary" target="_blank">
                                                <i class="bi bi-printer me-1"></i> View / Print Rx
                                            </a>
                                        </td>
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
