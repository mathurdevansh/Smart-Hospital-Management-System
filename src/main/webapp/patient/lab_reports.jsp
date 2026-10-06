<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Diagnostic Lab Reports" />
<c:set var="activePage" value="lab" />
<c:set var="pageHeading" value="Pathology & Laboratory Reports" />
<c:set var="pageSubheading" value="Access official diagnostic investigations, bio-reference ranges, and lab findings" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-flask me-2 text-primary"></i> Diagnostic Pathology Tests</h5>
                <span class="badge bg-secondary">${labReports.size()} Tests</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Test ID</th>
                            <th>Date Ordered</th>
                            <th>Investigating Doctor</th>
                            <th>Test / Panel Name</th>
                            <th>Reference Normal Range</th>
                            <th>Pathologist Finding</th>
                            <th>Report Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty labReports}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-5">
                                        <i class="bi bi-flask display-4 text-muted mb-3 d-block"></i>
                                        <p class="mb-0">No diagnostic laboratory tests on record.</p>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="lt" items="${labReports}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#LAB-${lt.testId}</td>
                                        <td class="small text-muted"><fmt:formatDate value="${lt.testDate}" pattern="dd MMM yyyy" /></td>
                                        <td class="fw-bold">Dr. ${lt.doctorName}</td>
                                        <td class="fw-bold text-dark">${lt.testName}</td>
                                        <td class="small text-muted">${lt.normalRange}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty lt.result}">
                                                    <span class="badge bg-warning bg-opacity-10 text-dark border">Analysis in progress</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="fw-semibold text-dark">${lt.result}</div>
                                                    <c:if test="${not empty lt.remarks}">
                                                        <div class="small text-muted">${lt.remarks}</div>
                                                    </c:if>
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
