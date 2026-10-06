<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="app-sidebar">
    <!-- Brand Header -->
    <div class="sidebar-header">
        <div class="sidebar-logo-icon">
            <i class="bi bi-hospital"></i>
        </div>
        <div class="sidebar-brand">
            <h5>SmartCare</h5>
            <span>Hospital ERP</span>
        </div>
    </div>

    <!-- Navigation Menu -->
    <ul class="sidebar-menu">
        <c:set var="role" value="${sessionScope.currentUser.roleName}" />
        <c:set var="cp" value="${pageContext.request.contextPath}" />

        <!-- ================= ADMIN NAVIGATION ================= -->
        <c:if test="${role eq 'ADMIN'}">
            <li class="menu-category">Executive</li>
            <li class="sidebar-item">
                <a href="${cp}/admin?action=dashboard" class="sidebar-link ${activePage eq 'dashboard' ? 'active' : ''}">
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="menu-category">Administration</li>
            <li class="sidebar-item">
                <a href="${cp}/admin?action=users" class="sidebar-link ${activePage eq 'users' ? 'active' : ''}">
                    <i class="bi bi-people-fill"></i>
                    <span>User Accounts</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/admin?action=doctors" class="sidebar-link ${activePage eq 'doctors' ? 'active' : ''}">
                    <i class="bi bi-person-badge-fill"></i>
                    <span>Doctors</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/admin?action=patients" class="sidebar-link ${activePage eq 'patients' ? 'active' : ''}">
                    <i class="bi bi-person-heart"></i>
                    <span>Patients</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/admin?action=departments" class="sidebar-link ${activePage eq 'departments' ? 'active' : ''}">
                    <i class="bi bi-diagram-3-fill"></i>
                    <span>Departments</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/admin?action=rooms" class="sidebar-link ${activePage eq 'rooms' ? 'active' : ''}">
                    <i class="bi bi-door-open-fill"></i>
                    <span>Rooms & Wards</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/admission" class="sidebar-link ${activePage eq 'admissions' ? 'active' : ''}">
                    <i class="bi bi-box-arrow-in-right"></i>
                    <span>Inpatient Admissions</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/inventory" class="sidebar-link ${activePage eq 'inventory' ? 'active' : ''}">
                    <i class="bi bi-capsule"></i>
                    <span>Pharmacy Inventory</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/lab" class="sidebar-link ${activePage eq 'lab' ? 'active' : ''}">
                    <i class="bi bi-prescription2"></i>
                    <span>Laboratory</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/admin?action=billing" class="sidebar-link ${activePage eq 'billing' ? 'active' : ''}">
                    <i class="bi bi-cash-stack"></i>
                    <span>Revenue & Billing</span>
                </a>
            </li>
            <li class="menu-category">Analytics & Security</li>
            <li class="sidebar-item">
                <a href="${cp}/admin?action=reports" class="sidebar-link ${activePage eq 'reports' ? 'active' : ''}">
                    <i class="bi bi-file-earmark-bar-graph-fill"></i>
                    <span>System Reports</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/admin?action=audit" class="sidebar-link ${activePage eq 'audit' ? 'active' : ''}">
                    <i class="bi bi-shield-lock-fill"></i>
                    <span>Audit Logs</span>
                </a>
            </li>
        </c:if>

        <!-- ================= DOCTOR NAVIGATION ================= -->
        <c:if test="${role eq 'DOCTOR'}">
            <li class="menu-category">Clinical Desk</li>
            <li class="sidebar-item">
                <a href="${cp}/doctor?action=dashboard" class="sidebar-link ${activePage eq 'dashboard' ? 'active' : ''}">
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span>Doctor Dashboard</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/doctor?action=appointments" class="sidebar-link ${activePage eq 'appointments' ? 'active' : ''}">
                    <i class="bi bi-calendar2-check-fill"></i>
                    <span>Appointments</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/doctor?action=records" class="sidebar-link ${activePage eq 'records' ? 'active' : ''}">
                    <i class="bi bi-journal-medical"></i>
                    <span>Medical Records</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/doctor?action=prescriptions" class="sidebar-link ${activePage eq 'prescriptions' ? 'active' : ''}">
                    <i class="bi bi-file-earmark-medical-fill"></i>
                    <span>Prescriptions</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/doctor?action=lab" class="sidebar-link ${activePage eq 'lab' ? 'active' : ''}">
                    <i class="bi bi-flask-fill"></i>
                    <span>Lab Test Orders</span>
                </a>
            </li>
        </c:if>

        <!-- ================= PATIENT NAVIGATION ================= -->
        <c:if test="${role eq 'PATIENT'}">
            <li class="menu-category">Health Portal</li>
            <li class="sidebar-item">
                <a href="${cp}/patient?action=dashboard" class="sidebar-link ${activePage eq 'dashboard' ? 'active' : ''}">
                    <i class="bi bi-speedometer2"></i>
                    <span>My Dashboard</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/patient?action=bookAppointment" class="sidebar-link ${activePage eq 'book' ? 'active' : ''}">
                    <i class="bi bi-plus-circle-fill"></i>
                    <span>Book Appointment</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/patient?action=myAppointments" class="sidebar-link ${activePage eq 'appointments' ? 'active' : ''}">
                    <i class="bi bi-calendar-event"></i>
                    <span>My Appointments</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/patient?action=records" class="sidebar-link ${activePage eq 'records' ? 'active' : ''}">
                    <i class="bi bi-heart-pulse-fill"></i>
                    <span>Clinical Records</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/patient?action=prescriptions" class="sidebar-link ${activePage eq 'prescriptions' ? 'active' : ''}">
                    <i class="bi bi-capsule"></i>
                    <span>Prescriptions</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/patient?action=labReports" class="sidebar-link ${activePage eq 'lab' ? 'active' : ''}">
                    <i class="bi bi-file-earmark-check-fill"></i>
                    <span>Lab Reports</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/patient?action=bills" class="sidebar-link ${activePage eq 'bills' ? 'active' : ''}">
                    <i class="bi bi-receipt"></i>
                    <span>Invoices & Billing</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/patient?action=feedback" class="sidebar-link ${activePage eq 'feedback' ? 'active' : ''}">
                    <i class="bi bi-star-fill"></i>
                    <span>Give Feedback</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/patient?action=profile" class="sidebar-link ${activePage eq 'profile' ? 'active' : ''}">
                    <i class="bi bi-person-circle"></i>
                    <span>My Profile</span>
                </a>
            </li>
        </c:if>

        <!-- ================= RECEPTIONIST NAVIGATION ================= -->
        <c:if test="${role eq 'RECEPTIONIST'}">
            <li class="menu-category">Front Desk</li>
            <li class="sidebar-item">
                <a href="${cp}/receptionist?action=dashboard" class="sidebar-link ${activePage eq 'dashboard' ? 'active' : ''}">
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span>Desk Dashboard</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/receptionist?action=patients" class="sidebar-link ${activePage eq 'patients' ? 'active' : ''}">
                    <i class="bi bi-person-lines-fill"></i>
                    <span>Patient Registry</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/receptionist?action=registerPatient" class="sidebar-link ${activePage eq 'register' ? 'active' : ''}">
                    <i class="bi bi-person-plus-fill"></i>
                    <span>New Registration</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/receptionist?action=appointments" class="sidebar-link ${activePage eq 'appointments' ? 'active' : ''}">
                    <i class="bi bi-calendar3"></i>
                    <span>Manage Appointments</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/receptionist?action=bookAppointment" class="sidebar-link ${activePage eq 'book' ? 'active' : ''}">
                    <i class="bi bi-calendar-plus-fill"></i>
                    <span>Book Slot</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/receptionist?action=billing" class="sidebar-link ${activePage eq 'billing' ? 'active' : ''}">
                    <i class="bi bi-receipt-cutoff"></i>
                    <span>Cashier & Billing</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/receptionist?action=rooms" class="sidebar-link ${activePage eq 'rooms' ? 'active' : ''}">
                    <i class="bi bi-hospital-fill"></i>
                    <span>Bed Availability</span>
                </a>
            </li>
        </c:if>

        <!-- ================= NURSE NAVIGATION ================= -->
        <c:if test="${role eq 'NURSE'}">
            <li class="menu-category">Ward Care</li>
            <li class="sidebar-item">
                <a href="${cp}/nurse?action=dashboard" class="sidebar-link ${activePage eq 'dashboard' ? 'active' : ''}">
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span>Nurse Station</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${cp}/nurse?action=patients" class="sidebar-link ${activePage eq 'patients' ? 'active' : ''}">
                    <i class="bi bi-hospital"></i>
                    <span>In-Patient Wards</span>
                </a>
            </li>
        </c:if>
    </ul>

    <!-- Sidebar User Footer -->
    <div class="sidebar-user">
        <div class="user-avatar">
            ${sessionScope.currentUser.fullName.substring(0, 1)}
        </div>
        <div class="flex-grow-1 overflow-hidden">
            <div class="text-truncate text-white fw-bold small">${sessionScope.currentUser.fullName}</div>
            <span class="role-badge role-${sessionScope.currentUser.roleName}">${sessionScope.currentUser.roleName}</span>
        </div>
        <a href="${cp}/logout" class="text-secondary hover-text-danger" title="Logout">
            <i class="bi bi-box-arrow-right fs-5"></i>
        </a>
    </div>
</aside>
