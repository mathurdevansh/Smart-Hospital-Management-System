<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Front Desk Receptionist Dashboard" />
<c:set var="activePage" value="dashboard" />
<c:set var="pageHeading" value="Front Desk & Reception Desk" />
<c:set var="pageSubheading" value="Patient admissions, rapid registrations, appointments, cashiering, and room allocations" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="content-body">

        <!-- Flash Messages -->
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Action completed: ${param.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- KPI Metrics Grid -->
        <div class="row g-3 mb-4">
            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Registered Patients</p>
                        <h3>${patients.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-blue">
                        <i class="bi bi-people-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Total Appointments</p>
                        <h3>${appointments.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-teal">
                        <i class="bi bi-calendar-event"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Available Ward Beds</p>
                        <h3>${availableRooms.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-green">
                        <i class="bi bi-door-open-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6">
                <div class="kpi-card">
                    <div class="kpi-info">
                        <p>Physicians On Call</p>
                        <h3>${doctors.size()}</h3>
                    </div>
                    <div class="kpi-icon-box kpi-purple">
                        <i class="bi bi-person-badge-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Rapid Desk Action Bar -->
        <div class="d-flex flex-wrap gap-2 mb-4">
            <a href="${pageContext.request.contextPath}/receptionist?action=registerPatient" class="btn btn-primary rounded-pill px-4 shadow-sm fw-semibold">
                <i class="bi bi-person-plus-fill me-1"></i> Register New Patient
            </a>
            <a href="${pageContext.request.contextPath}/receptionist?action=bookAppointment" class="btn btn-outline-primary rounded-pill px-4 fw-semibold">
                <i class="bi bi-calendar-plus-fill me-1"></i> Book Appointment
            </a>
            <a href="${pageContext.request.contextPath}/receptionist?action=generateBill" class="btn btn-outline-success rounded-pill px-4 fw-semibold">
                <i class="bi bi-receipt me-1"></i> Generate Bill
            </a>
            <a href="${pageContext.request.contextPath}/admission?action=new" class="btn btn-outline-info rounded-pill px-4 fw-semibold text-dark">
                <i class="bi bi-box-arrow-in-right me-1"></i> Admit to Ward Bed
            </a>
        </div>

        <!-- Active Patient Queue -->
        <div class="content-panel">
            <div class="panel-header">
                <h5><i class="bi bi-calendar3 me-2 text-primary"></i> Daily Consultations & Check-In Desk</h5>
                <a href="${pageContext.request.contextPath}/receptionist?action=appointments" class="small text-decoration-none">Manage All</a>
            </div>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Patient Name</th>
                            <th>Attending Doctor</th>
                            <th>Date & Time</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th class="text-end">Desk Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty appointments}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No appointment bookings logged.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="a" items="${appointments}" begin="0" end="6">
                                    <tr>
                                        <td class="fw-semibold text-muted">#${a.appointmentId}</td>
                                        <td class="fw-bold">${a.patientName}</td>
                                        <td>${a.doctorName}</td>
                                        <td>
                                            <div class="fw-semibold">${a.appointmentDate}</div>
                                            <div class="text-muted small">${a.appointmentTime}</div>
                                        </td>
                                        <td class="small" style="max-width: 200px;">${a.reason}</td>
                                        <td><span class="badge-status status-${a.status}">${a.status}</span></td>
                                        <td class="text-end">
                                            <c:if test="${a.status eq 'PENDING'}">
                                                <a href="${pageContext.request.contextPath}/receptionist?action=checkIn&appointmentId=${a.appointmentId}" 
                                                   class="btn btn-sm btn-outline-success">
                                                    <i class="bi bi-check2-circle"></i> Check-In
                                                </a>
                                            </c:if>
                                            <c:if test="${a.status eq 'CONFIRMED'}">
                                                <span class="badge bg-light text-primary border">Checked In</span>
                                            </c:if>
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
