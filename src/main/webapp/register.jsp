<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital User Registration | SmartCare Hospital Management System</title>
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
            padding: 2.5rem 1rem;
        }
        .register-card {
            background: #ffffff;
            border-radius: var(--radius-lg);
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.45);
            width: 100%;
            max-width: 780px;
            overflow: hidden;
        }
        .register-header {
            background: linear-gradient(135deg, #0284c7 0%, #0f172a 100%);
            color: #ffffff;
            padding: 2.25rem 2rem 1.75rem 2rem;
            text-align: center;
        }
        .role-option-card {
            cursor: pointer;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 1rem 0.75rem;
            text-align: center;
            transition: all 0.2s ease-in-out;
            background: #f8fafc;
            height: 100%;
        }
        .role-option-card:hover {
            border-color: #38bdf8;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
        }
        .role-radio:checked + .role-option-card {
            border-color: #0284c7;
            background: #f0f9ff;
            box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.2);
        }
        .role-radio {
            display: none;
        }
        .role-icon {
            font-size: 1.8rem;
            margin-bottom: 0.35rem;
            display: inline-block;
        }
        .role-title {
            font-size: 0.95rem;
            font-weight: 700;
            display: block;
            color: #1e293b;
        }
        .role-subtitle {
            font-size: 0.72rem;
            color: #64748b;
            line-height: 1.2;
            display: block;
            margin-top: 0.2rem;
        }
        .section-badge {
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
    </style>
</head>
<body>

    <div class="register-card">
        <!-- Header -->
        <div class="register-header">
            <div class="sidebar-logo-icon mx-auto mb-2" style="width:48px; height:48px; font-size:1.5rem;">
                <i class="bi bi-hospital"></i>
            </div>
            <h3 class="fw-bold mb-1">Join SmartCare Hospital</h3>
            <p class="mb-0 text-light opacity-75 small">Hospital Information System — Multi-Role User Registration</p>
        </div>

        <!-- Form Body -->
        <div class="p-4 p-md-5">

            <!-- Flash Error -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4 small" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                    <div>${errorMessage}</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST" autocomplete="off" id="registrationForm">

                <!-- 1. Choose User Role -->
                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary mb-2">
                        <i class="bi bi-person-badge-fill text-primary me-1"></i> 1. Select Your Hospital Role
                    </label>

                    <div class="row g-2">
                        <!-- Patient -->
                        <div class="col-6 col-md-3">
                            <label class="w-100 h-100">
                                <input type="radio" name="role" value="PATIENT" class="role-radio" 
                                       ${empty selectedRole or selectedRole eq 'PATIENT' ? 'checked' : ''} onchange="onRoleChange('PATIENT')">
                                <div class="role-option-card">
                                    <span class="role-icon text-success"><i class="bi bi-person-heart"></i></span>
                                    <span class="role-title">Patient</span>
                                    <span class="role-subtitle">Book visits & tests</span>
                                </div>
                            </label>
                        </div>

                        <!-- Doctor -->
                        <div class="col-6 col-md-3">
                            <label class="w-100 h-100">
                                <input type="radio" name="role" value="DOCTOR" class="role-radio" 
                                       ${selectedRole eq 'DOCTOR' ? 'checked' : ''} onchange="onRoleChange('DOCTOR')">
                                <div class="role-option-card">
                                    <span class="role-icon text-primary"><i class="bi bi-heart-pulse-fill"></i></span>
                                    <span class="role-title">Doctor</span>
                                    <span class="role-subtitle">OPD & treatment</span>
                                </div>
                            </label>
                        </div>

                        <!-- Receptionist -->
                        <div class="col-6 col-md-3">
                            <label class="w-100 h-100">
                                <input type="radio" name="role" value="RECEPTIONIST" class="role-radio" 
                                       ${selectedRole eq 'RECEPTIONIST' ? 'checked' : ''} onchange="onRoleChange('RECEPTIONIST')">
                                <div class="role-option-card">
                                    <span class="role-icon text-warning"><i class="bi bi-person-vcard-fill"></i></span>
                                    <span class="role-title">Receptionist</span>
                                    <span class="role-subtitle">Intake & billing</span>
                                </div>
                            </label>
                        </div>

                        <!-- Nurse -->
                        <div class="col-6 col-md-3">
                            <label class="w-100 h-100">
                                <input type="radio" name="role" value="NURSE" class="role-radio" 
                                       ${selectedRole eq 'NURSE' ? 'checked' : ''} onchange="onRoleChange('NURSE')">
                                <div class="role-option-card">
                                    <span class="role-icon text-info"><i class="bi bi-activity"></i></span>
                                    <span class="role-title">Nurse</span>
                                    <span class="role-subtitle">Vitals & wards</span>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="mt-2 text-muted small d-flex align-items-center">
                        <i class="bi bi-shield-lock-fill text-danger me-1"></i>
                        <span><em>Hospital Administrator accounts are centrally managed and not open to public registration.</em></span>
                    </div>
                </div>

                <!-- 2. Account Credentials (Common for all roles) -->
                <div class="mb-4 pt-2 border-top">
                    <label class="form-label small fw-bold text-secondary mb-3">
                        <i class="bi bi-key-fill text-primary me-1"></i> 2. Account & Login Credentials
                    </label>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="fullName" class="form-label small fw-bold text-secondary">Full Legal Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" 
                                   placeholder="e.g. Dr. Ramesh / Priya Sharma" value="${fullName}" required>
                        </div>

                        <div class="col-md-6">
                            <label for="email" class="form-label small fw-bold text-secondary">Email Address (Login Username)</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   placeholder="e.g. yourname@gmail.com" value="${email}" required>
                        </div>

                        <div class="col-md-6">
                            <label for="password" class="form-label small fw-bold text-secondary">Password (Min 6 Characters)</label>
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="Choose secure password" required minlength="6">
                        </div>

                        <div class="col-md-6">
                            <label for="phone" class="form-label small fw-bold text-secondary">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" 
                                   placeholder="+91 98765 43210" value="${phone}" required>
                        </div>
                    </div>
                </div>

                <!-- 3. Dynamic Role-Specific Section -->

                <!-- PATIENT FIELDS -->
                <div id="patientSection" class="role-section mb-4 pt-2 border-top">
                    <label class="form-label small fw-bold text-success mb-3">
                        <i class="bi bi-person-heart me-1"></i> 3. Patient Clinical & Emergency Demographics
                    </label>

                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="dob" class="form-label small fw-bold text-secondary">Date of Birth</label>
                            <input type="date" class="form-control patient-input" id="dob" name="dob" value="2000-01-01" required>
                        </div>

                        <div class="col-md-4">
                            <label for="gender" class="form-label small fw-bold text-secondary">Gender</label>
                            <select class="form-select patient-input" id="gender" name="gender">
                                <option value="MALE">Male</option>
                                <option value="FEMALE">Female</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label for="bloodGroup" class="form-label small fw-bold text-secondary">Blood Group</label>
                            <select class="form-select patient-input" id="bloodGroup" name="bloodGroup">
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label for="address" class="form-label small fw-bold text-secondary">Residential Address</label>
                            <textarea class="form-control patient-input" id="address" name="address" rows="2" 
                                      placeholder="City, State, Residence"></textarea>
                        </div>

                        <div class="col-md-6">
                            <label for="emergencyContactName" class="form-label small fw-bold text-secondary">Emergency Contact Name</label>
                            <input type="text" class="form-control patient-input" id="emergencyContactName" name="emergencyContactName" 
                                   placeholder="e.g. Spouse / Relative">
                        </div>

                        <div class="col-md-6">
                            <label for="emergencyContactPhone" class="form-label small fw-bold text-secondary">Emergency Phone</label>
                            <input type="tel" class="form-control patient-input" id="emergencyContactPhone" name="emergencyContactPhone" 
                                   placeholder="+91 98111 22233">
                        </div>

                        <div class="col-12">
                            <label for="medicalHistorySummary" class="form-label small fw-bold text-secondary">Known Allergies / Pre-existing Conditions (Optional)</label>
                            <textarea class="form-control" id="medicalHistorySummary" name="medicalHistorySummary" rows="1" 
                                      placeholder="e.g. Penicillin allergy, diabetes, none"></textarea>
                        </div>
                    </div>
                </div>

                <!-- DOCTOR FIELDS -->
                <div id="doctorSection" class="role-section mb-4 pt-2 border-top" style="display:none;">
                    <label class="form-label small fw-bold text-primary mb-3">
                        <i class="bi bi-hospital me-1"></i> 3. Attending Physician Clinical Profile
                    </label>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="departmentId" class="form-label small fw-bold text-secondary">Clinical Department</label>
                            <select class="form-select" id="departmentId" name="departmentId">
                                <c:forEach var="dept" items="${departments}">
                                    <option value="${dept.departmentId}">${dept.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label for="specialization" class="form-label small fw-bold text-secondary">Specialization Area</label>
                            <input type="text" class="form-control" id="specialization" name="specialization" 
                                   placeholder="e.g. Interventional Cardiology, Orthopedic Surgeon" value="General Medicine">
                        </div>

                        <div class="col-md-6">
                            <label for="qualification" class="form-label small fw-bold text-secondary">Medical Qualifications</label>
                            <input type="text" class="form-control" id="qualification" name="qualification" 
                                   placeholder="e.g. MBBS, MD, MS, FRCS" value="MBBS, MD">
                        </div>

                        <div class="col-md-3">
                            <label for="experienceYears" class="form-label small fw-bold text-secondary">Experience (Years)</label>
                            <input type="number" class="form-control" id="experienceYears" name="experienceYears" 
                                   min="0" max="60" value="5">
                        </div>

                        <div class="col-md-3">
                            <label for="consultationFee" class="form-label small fw-bold text-secondary">Consultation Fee (₹)</label>
                            <input type="number" class="form-control" id="consultationFee" name="consultationFee" 
                                   min="0" step="50" value="500">
                        </div>

                        <div class="col-md-4">
                            <label for="roomNo" class="form-label small fw-bold text-secondary">OPD Cabin / Room No.</label>
                            <input type="text" class="form-control" id="roomNo" name="roomNo" 
                                   placeholder="e.g. Room 204" value="OPD-102">
                        </div>

                        <div class="col-md-4">
                            <label for="availableDays" class="form-label small fw-bold text-secondary">Available Days</label>
                            <input type="text" class="form-control" id="availableDays" name="availableDays" 
                                   value="Mon-Sat">
                        </div>

                        <div class="col-md-4">
                            <label for="availableTime" class="form-label small fw-bold text-secondary">OPD Hours</label>
                            <input type="text" class="form-control" id="availableTime" name="availableTime" 
                                   value="09:00 AM - 05:00 PM">
                        </div>
                    </div>
                </div>

                <!-- RECEPTIONIST FIELDS -->
                <div id="receptionistSection" class="role-section mb-4 pt-2 border-top" style="display:none;">
                    <label class="form-label small fw-bold text-warning mb-3">
                        <i class="bi bi-person-vcard me-1"></i> 3. Front Desk Receptionist Profile
                    </label>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="recepQualification" class="form-label small fw-bold text-secondary">Qualification / Certification</label>
                            <input type="text" class="form-control" id="recepQualification" name="qualification" 
                                   placeholder="e.g. B.Com / Diploma in Healthcare Admin" value="Bachelor of Commerce">
                        </div>

                        <div class="col-md-6">
                            <label for="recepShift" class="form-label small fw-bold text-secondary">Assigned Shift</label>
                            <select class="form-select" id="recepShift" name="shift">
                                <option value="MORNING">Morning Shift (07:00 AM - 03:00 PM)</option>
                                <option value="EVENING">Evening Shift (03:00 PM - 11:00 PM)</option>
                                <option value="NIGHT">Night Shift (11:00 PM - 07:00 AM)</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- NURSE FIELDS -->
                <div id="nurseSection" class="role-section mb-4 pt-2 border-top" style="display:none;">
                    <label class="form-label small fw-bold text-info mb-3">
                        <i class="bi bi-activity me-1"></i> 3. Clinical Nursing Station Profile
                    </label>

                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="nurseDepartmentId" class="form-label small fw-bold text-secondary">Assigned Ward / Dept</label>
                            <select class="form-select" id="nurseDepartmentId" name="departmentId">
                                <c:forEach var="dept" items="${departments}">
                                    <option value="${dept.departmentId}">${dept.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label for="nurseQualification" class="form-label small fw-bold text-secondary">Nursing Qualification</label>
                            <input type="text" class="form-control" id="nurseQualification" name="qualification" 
                                   placeholder="e.g. B.Sc. Nursing (RN) / GNM" value="B.Sc. Nursing (RN)">
                        </div>

                        <div class="col-md-4">
                            <label for="nurseShift" class="form-label small fw-bold text-secondary">Clinical Ward Shift</label>
                            <select class="form-select" id="nurseShift" name="shift">
                                <option value="MORNING">Morning Shift (07:00 AM - 03:00 PM)</option>
                                <option value="EVENING">Evening Shift (03:00 PM - 11:00 PM)</option>
                                <option value="NIGHT">Night Shift (11:00 PM - 07:00 AM)</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold rounded-3 shadow-sm mb-3 mt-2" id="submitBtn">
                    <i class="bi bi-check-circle-fill me-1"></i> Complete Registration & Activate Account
                </button>

                <div class="text-center">
                    <span class="small text-muted">Already registered with an email? </span>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="small fw-semibold text-primary text-decoration-none">
                        <i class="bi bi-box-arrow-in-right me-1"></i>Sign In Here
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function onRoleChange(role) {
            const sections = {
                'PATIENT': document.getElementById('patientSection'),
                'DOCTOR': document.getElementById('doctorSection'),
                'RECEPTIONIST': document.getElementById('receptionistSection'),
                'NURSE': document.getElementById('nurseSection')
            };

            // Hide all sections
            for (let key in sections) {
                if (sections[key]) {
                    sections[key].style.display = 'none';
                    // Disable inputs in hidden sections so they don't submit conflict values
                    sections[key].querySelectorAll('input, select, textarea').forEach(el => {
                        el.disabled = true;
                    });
                }
            }

            // Show selected section
            const activeSection = sections[role];
            if (activeSection) {
                activeSection.style.display = 'block';
                activeSection.querySelectorAll('input, select, textarea').forEach(el => {
                    el.disabled = false;
                });
            }

            // Update button label
            const btn = document.getElementById('submitBtn');
            if (btn) {
                const labels = {
                    'PATIENT': 'Register as Patient',
                    'DOCTOR': 'Register as Attending Doctor',
                    'RECEPTIONIST': 'Register as Receptionist',
                    'NURSE': 'Register as Clinical Nurse'
                };
                btn.innerHTML = '<i class="bi bi-check-circle-fill me-1"></i> ' + (labels[role] || 'Register Account');
            }
        }

        // Initialize based on current selection
        document.addEventListener('DOMContentLoaded', function() {
            const checkedRadio = document.querySelector('input[name="role"]:checked');
            const role = checkedRadio ? checkedRadio.value : 'PATIENT';
            onRoleChange(role);
        });
    </script>
</body>
</html>
