<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>404 - Page Not Found | SmartCare Hospital</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="bg-light d-flex align-items-center justify-content-center min-vh-100">
    <div class="card border-0 shadow-lg text-center p-5 rounded-4" style="max-width: 520px;">
        <div class="display-1 text-primary mb-3"><i class="bi bi-hospital"></i></div>
        <h1 class="display-4 fw-bold text-dark">404</h1>
        <h4 class="mb-3 text-secondary">Clinical Resource Not Found</h4>
        <p class="text-muted mb-4">The medical record, portal view, or URL you requested could not be located in our system.</p>
        <div>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary px-4 py-2 rounded-pill">
                <i class="bi bi-arrow-left me-1"></i> Return to Portal
            </a>
        </div>
    </div>
</body>
</html>
