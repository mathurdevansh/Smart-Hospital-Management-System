<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartCare Hospital Management System | Advanced Clinical Healthcare Platform</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 60%, #0369a1 100%);
            color: #ffffff;
            padding: 5rem 0 4rem 0;
            position: relative;
        }
        .portal-card {
            background: #ffffff;
            border-radius: var(--radius-md);
            border: 1px solid var(--border);
            padding: 2rem;
            transition: all 0.25s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
            box-shadow: var(--shadow-card);
        }
        .portal-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-elevated);
            border-color: #38bdf8;
        }
        .feature-icon-circle {
            width: 55px;
            height: 55px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1.25rem;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Top Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark py-3 px-4 shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/">
                <span class="sidebar-logo-icon" style="width:36px; height:36px; font-size:1.1rem;"><i class="bi bi-hospital"></i></span>
                <span class="fw-bold tracking-tight">SmartCare Hospital</span>
            </a>
            <div class="d-flex align-items-center gap-2">
                <span class="text-white-50 d-none d-md-inline small me-3"><i class="bi bi-telephone-fill text-danger me-1"></i> Emergency: 108 / +91 (11) 2345-6789</span>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-light px-3 rounded-pill fw-semibold">
                    <i class="bi bi-person-plus-fill me-1"></i> Register
                </a>
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary px-4 rounded-pill fw-semibold">
                    <i class="bi bi-person-fill-lock me-1"></i> Sign In
                </a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <header class="hero-banner">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-7">
                    <span class="badge bg-info text-dark px-3 py-2 rounded-pill fw-semibold mb-3">
                        <i class="bi bi-stars me-1"></i> Next-Generation Smart Healthcare ERP
                    </span>
                    <h1 class="display-4 fw-extrabold mb-3 lh-sm">
                        SmartCare Hospital Management System
                    </h1>
                    <p class="lead text-light opacity-75 mb-4">
                        A centralized, secure Java full-stack hospital information ecosystem delivering real-time outpatient scheduling, digital electronic health records (EHR), pharmacy batch control, and diagnostic billing.
                    </p>
                    <div class="d-flex flex-wrap gap-3">
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-light btn-lg px-4 rounded-pill fw-bold text-dark">
                            <i class="bi bi-door-open-fill me-1"></i> Secure Role Login
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-light btn-lg px-4 rounded-pill fw-semibold">
                            <i class="bi bi-person-plus-fill me-1"></i> Register New User
                        </a>
                        <a href="#portals" class="btn btn-outline-light btn-lg px-4 rounded-pill fw-semibold">
                            Explore Roles
                        </a>
                    </div>
                </div>
                <div class="col-lg-5 d-none d-lg-block">
                    <div class="card bg-white bg-opacity-10 backdrop-blur border border-white border-opacity-25 rounded-4 p-4 text-white shadow-lg">
                        <h5 class="fw-bold mb-3"><i class="bi bi-shield-check text-info me-2"></i> PBL System Architecture</h5>
                        <ul class="list-unstyled mb-0 d-flex flex-column gap-2 small">
                            <li><i class="bi bi-check-circle-fill text-success me-2"></i> <strong>Jakarta Servlet 6.0 & JSP 3.1:</strong> Pure MVC design pattern</li>
                            <li><i class="bi bi-check-circle-fill text-success me-2"></i> <strong>MySQL 8.0:</strong> 22 normalized relational tables with foreign keys</li>
                            <li><i class="bi bi-check-circle-fill text-success me-2"></i> <strong>BCrypt Security:</strong> Salted password hashes & RBAC filters</li>
                            <li><i class="bi bi-check-circle-fill text-success me-2"></i> <strong>Zero Scriptlets:</strong> Pure JSTL & Expression Language (EL)</li>
                            <li><i class="bi bi-check-circle-fill text-success me-2"></i> <strong>Double Booking Prevention:</strong> Conflict check algorithms</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Role Portals Grid -->
    <section id="portals" class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <span class="text-primary fw-bold text-uppercase tracking-wider small">Comprehensive Hospital Coverage</span>
                <h2 class="fw-bold text-dark mt-1">Multi-Role Specialized Dashboards</h2>
                <p class="text-muted">Every user role operates within a customized interface and strict security boundary.</p>
            </div>

            <div class="row g-4">
                <!-- Admin -->
                <div class="col-md-6 col-lg-4">
                    <div class="portal-card">
                        <div class="feature-icon-circle bg-danger bg-opacity-10 text-danger">
                            <i class="bi bi-shield-shaded"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-2">Hospital Administrator</h4>
                        <p class="text-muted small flex-grow-1">
                            Enterprise KPIs, user account control, department & room management, doctor rosters, pharmacy inventory alerts, and financial revenue reports.
                        </p>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-danger btn-sm rounded-pill fw-semibold mt-3">
                            Access Admin Portal <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Doctor -->
                <div class="col-md-6 col-lg-4">
                    <div class="portal-card">
                        <div class="feature-icon-circle bg-primary bg-opacity-10 text-primary">
                            <i class="bi bi-heart-pulse-fill"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-2">Attending Doctor</h4>
                        <p class="text-muted small flex-grow-1">
                            Daily OPD schedule, digital consultations, diagnosis recording, clinical notes, multi-item e-prescriptions, and lab diagnostic orders.
                        </p>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-primary btn-sm rounded-pill fw-semibold mt-3">
                            Access Doctor Portal <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Patient -->
                <div class="col-md-6 col-lg-4">
                    <div class="portal-card">
                        <div class="feature-icon-circle bg-success bg-opacity-10 text-success">
                            <i class="bi bi-person-heart"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-2">Patient Health Portal</h4>
                        <p class="text-muted small flex-grow-1">
                            Self-service appointment booking, consultation history, printable prescriptions, laboratory test reports, transparent billing, and doctor reviews.
                        </p>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-success btn-sm rounded-pill fw-semibold mt-3">
                            Access Patient Portal <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Receptionist -->
                <div class="col-md-6 col-lg-6">
                    <div class="portal-card">
                        <div class="feature-icon-circle bg-warning bg-opacity-10 text-warning">
                            <i class="bi bi-person-vcard-fill"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-2">Front Desk & Reception</h4>
                        <p class="text-muted small flex-grow-1">
                            Rapid patient registration, central appointment scheduling & rescheduling, patient check-in/out, room availability checking, and cashier invoicing.
                        </p>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-warning btn-sm rounded-pill fw-semibold mt-3">
                            Access Reception Portal <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Nurse -->
                <div class="col-md-6 col-lg-6">
                    <div class="portal-card">
                        <div class="feature-icon-circle bg-info bg-opacity-10 text-info">
                            <i class="bi bi-activity"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-2">Clinical Nursing Station</h4>
                        <p class="text-muted small flex-grow-1">
                            In-patient ward monitoring, real-time physiological vitals recording (Temperature, Blood Pressure, Pulse, SpO2), and bedside encounter notes.
                        </p>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-info btn-sm rounded-pill fw-semibold mt-3">
                            Access Nurse Station <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white-50 py-4 text-center border-top border-secondary">
        <div class="container small">
            <p class="mb-1 text-white fw-bold">SmartCare Hospital Management System &copy; 2026</p>
            <p class="mb-0">Academic PBL Enterprise Software Architecture | Built with Java 21, Jakarta Servlets, JSP & MySQL</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
