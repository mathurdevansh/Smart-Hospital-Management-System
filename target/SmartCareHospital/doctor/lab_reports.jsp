<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Diagnostic Lab Orders" />
<c:set var="activePage" value="lab" />
<c:set var="pageHeading" value="Laboratory Investigations & Diagnostic Results" />
<c:set var="pageSubheading" value="Monitor pathology tests ordered for your patients and examine findings" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-flask me-2 text-primary"></i> Pathology & Lab Test Orders</h5>
                <span class="badge bg-secondary">${labReports.size()} Orders</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Test ID</th>
                            <th>Order Date</th>
                            <th>Patient Name</th>
                            <th>Test Name</th>
                            <th>Expected Normal Range</th>
                            <th>Diagnostic Finding</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty labReports}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No lab tests ordered.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="lt" items="${labReports}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#LAB-${lt.testId}</td>
                                        <td class="small text-muted"><fmt:formatDate value="${lt.testDate}" pattern="dd MMM yyyy" /></td>
                                        <td class="fw-bold">${lt.patientName}</td>
                                        <td>${lt.testName}</td>
                                        <td class="small text-muted">${lt.normalRange}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty lt.result}">
                                                    <span class="badge bg-light text-muted border">Pending Specimen Analysis</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="fw-semibold text-dark">${lt.result}</div>
                                                    <div class="small text-muted">${lt.remarks}</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><span class="badge-status status-${lt.status}">${lt.status}</span></td>
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
