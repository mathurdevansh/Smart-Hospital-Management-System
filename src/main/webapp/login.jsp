<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Portal Login | SmartCare Hospital Management System</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0c4a6e 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        .login-card {
            background: #ffffff;
            border-radius: var(--radius-lg);
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            width: 100%;
            max-width: 520px;
            overflow: hidden;
        }
        .login-header {
            background: linear-gradient(135deg, #0284c7 0%, #0f172a 100%);
            color: #ffffff;
            padding: 2.25rem 2rem 1.75rem 2rem;
            text-align: center;
        }
        .demo-chip {
            cursor: pointer;
            transition: all 0.2s;
            font-size: 0.78rem;
        }
        .demo-chip:hover {
            transform: scale(1.03);
        }
    </style>
</head>
<body>

    <div class="login-card">
        <!-- Card Header -->
        <div class="login-header">
            <div class="sidebar-logo-icon mx-auto mb-3" style="width:48px; height:48px; font-size:1.5rem;">
                <i class="bi bi-hospital"></i>
            </div>
            <h3 class="fw-bold mb-1">SmartCare Hospital</h3>
            <p class="mb-0 text-light opacity-75 small">Unified Clinical & Healthcare Management Portal</p>
        </div>

        <!-- Card Body -->
        <div class="p-4 p-md-5">

            <!-- Flash Alert Messages -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4 small" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                    <div>${errorMessage}</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${param.msg eq 'logged_out'}">
                <div class="alert alert-success alert-dismissible fade show d-flex align-items-center mb-4 small" role="alert">
                    <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                    <div>You have been safely logged out. Session invalidated.</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${param.error eq 'session_expired'}">
                <div class="alert alert-warning alert-dismissible fade show d-flex align-items-center mb-4 small" role="alert">
                    <i class="bi bi-clock-history me-2 fs-5"></i>
                    <div>Your clinical session expired. Please log in again.</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${param.error eq 'unauthorized'}">
                <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4 small" role="alert">
                    <i class="bi bi-shield-lock-fill me-2 fs-5"></i>
                    <div>Authentication required to access requested module.</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${param.msg eq 'registered'}">
                <div class="alert alert-success alert-dismissible fade show d-flex align-items-center mb-4 small" role="alert">
                    <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                    <div>
                        Account registered successfully! Please enter your password to sign in.
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/login" method="POST" autocomplete="off">
                <!-- Role Select -->
                <div class="mb-3">
                    <label for="roleSelect" class="form-label small fw-bold text-secondary">
                        <i class="bi bi-shield-check text-primary me-1"></i> Authorized Role
                    </label>
                    <select class="form-select py-2" id="roleSelect" name="role">
                        <option value="" ${empty selectedRole and empty param.role ? 'selected' : ''}>-- Auto-Detect Portal Role (Any Account) --</option>
                        <option value="ADMIN" ${selectedRole eq 'ADMIN' or param.role eq 'ADMIN' ? 'selected' : ''}>Hospital Administrator</option>
                        <option value="DOCTOR" ${selectedRole eq 'DOCTOR' or param.role eq 'DOCTOR' ? 'selected' : ''}>Attending Doctor</option>
                        <option value="RECEPTIONIST" ${selectedRole eq 'RECEPTIONIST' or param.role eq 'RECEPTIONIST' ? 'selected' : ''}>Front Desk Receptionist</option>
                        <option value="NURSE" ${selectedRole eq 'NURSE' or param.role eq 'NURSE' ? 'selected' : ''}>Clinical Nurse</option>
                        <option value="PATIENT" ${selectedRole eq 'PATIENT' or param.role eq 'PATIENT' ? 'selected' : ''}>Patient Portal</option>
                    </select>
                    <div class="form-text text-muted" style="font-size: 0.75rem;">Leave on Auto-Detect or choose your portal role.</div>
                </div>

                <!-- Email Input -->
                <div class="mb-3">
                    <label for="emailInput" class="form-label small fw-bold text-secondary">
                        <i class="bi bi-envelope-at text-primary me-1"></i> Email Address
                    </label>
                    <input type="email" class="form-control py-2" id="emailInput" name="email" 
                           placeholder="e.g. yourname@gmail.com or admin@smarthospital.com" 
                           value="${not empty enteredEmail ? enteredEmail : param.email}" required>
                </div>

                <!-- Password Input -->
                <div class="mb-3">
                    <div class="d-flex justify-content-between">
                        <label for="passwordInput" class="form-label small fw-bold text-secondary">
                            <i class="bi bi-key text-primary me-1"></i> Password
                        </label>
                    </div>
                    <input type="password" class="form-control py-2" id="passwordInput" name="password" 
                           placeholder="Enter password" required>
                </div>

                <!-- Remember Me & Submit -->
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                        <label class="form-check-label small text-secondary" for="rememberMe">Remember me</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/" class="small text-decoration-none text-muted">
                        <i class="bi bi-arrow-left me-1"></i> Home
                    </a>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold rounded-3 shadow-sm mb-3">
                    <i class="bi bi-box-arrow-in-right me-1"></i> Log In to Portal
                </button>

                <div class="text-center mb-4">
                    <span class="small text-muted">New user? </span>
                    <a href="${pageContext.request.contextPath}/register" class="small fw-bold text-primary text-decoration-none">
                        <i class="bi bi-person-plus-fill me-1"></i>Register as Doctor, Patient, Receptionist, or Nurse
                    </a>
                </div>
            </form>

            <!-- One-Click Quick Login Demo Chips for Evaluator -->
            <div class="border-top pt-3">
                <span class="text-uppercase fw-bold text-muted small d-block mb-2 text-center" style="font-size:0.72rem; letter-spacing:0.8px;">
                    <i class="bi bi-lightning-charge-fill text-warning me-1"></i> Quick Demo Accounts (Password: Password@123)
                </span>
                <div class="d-flex flex-wrap gap-2 justify-content-center">
                    <button type="button" class="btn btn-sm btn-outline-danger demo-chip" 
                            onclick="fillDemoCredentials('admin@smarthospital.com', 'Password@123', 'ADMIN')">
                        <i class="bi bi-shield-shaded me-1"></i> Admin
                    </button>
                    <button type="button" class="btn btn-sm btn-outline-primary demo-chip" 
                            onclick="fillDemoCredentials('doctor@smarthospital.com', 'Password@123', 'DOCTOR')">
                        <i class="bi bi-heart-pulse me-1"></i> Doctor
                    </button>
                    <button type="button" class="btn btn-sm btn-outline-warning demo-chip text-dark" 
                            onclick="fillDemoCredentials('reception@smarthospital.com', 'Password@123', 'RECEPTIONIST')">
                        <i class="bi bi-person-vcard me-1"></i> Receptionist
                    </button>
                    <button type="button" class="btn btn-sm btn-outline-info demo-chip text-dark" 
                            onclick="fillDemoCredentials('nurse@smarthospital.com', 'Password@123', 'NURSE')">
                        <i class="bi bi-activity me-1"></i> Nurse
                    </button>
                    <button type="button" class="btn btn-sm btn-outline-success demo-chip" 
                            onclick="fillDemoCredentials('patient@smarthospital.com', 'Password@123', 'PATIENT')">
                        <i class="bi bi-person-heart me-1"></i> Patient
                    </button>
                </div>
            </div>

        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
