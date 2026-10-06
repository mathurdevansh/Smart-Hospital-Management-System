<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="System Security Audit Logs" />
<c:set var="activePage" value="audit" />
<c:set var="pageHeading" value="Hospital Security Audit Trail" />
<c:set var="pageSubheading" value="Immutable forensic timeline of clinical entries, billing transactions, and logins" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-shield-lock-fill me-2 text-primary"></i> System Event Ledger</h5>
                <span class="badge bg-secondary">${auditLogs.size()} Events Captured</span>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Log ID</th>
                            <th>Timestamp</th>
                            <th>User Principal</th>
                            <th>Action Type</th>
                            <th>Event Details & Parameters</th>
                            <th>Originating IP</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty auditLogs}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">No audit logs recorded.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="log" items="${auditLogs}">
                                    <tr>
                                        <td class="fw-semibold text-muted">#LOG-${log.logId}</td>
                                        <td class="small text-muted"><fmt:formatDate value="${log.timestamp}" pattern="dd MMM yyyy, HH:mm:ss" /></td>
                                        <td>
                                            <div class="fw-bold">${log.userName}</div>
                                            <div class="text-muted small">UID: ${log.userId}</div>
                                        </td>
                                        <td><span class="badge bg-dark">${log.action}</span></td>
                                        <td class="small">${log.details}</td>
                                        <td class="small text-muted font-monospace"><i class="bi bi-globe me-1"></i>${log.ipAddress}</td>
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
