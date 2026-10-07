package com.smarthospital.controller;

import com.smarthospital.dao.DepartmentDAO;
import com.smarthospital.dao.DoctorDAO;
import com.smarthospital.dao.PatientDAO;
import com.smarthospital.dao.ReceptionistDAO;
import com.smarthospital.dao.UserDAO;
import com.smarthospital.dao.VitalDAO;
import com.smarthospital.exception.ApplicationException;
import com.smarthospital.model.Doctor;
import com.smarthospital.model.Nurse;
import com.smarthospital.model.Patient;
import com.smarthospital.model.Receptionist;
import com.smarthospital.model.User;
import com.smarthospital.util.PasswordUtil;
import com.smarthospital.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;

/**
 * Controller handling public self-registration for Doctors, Patients, Receptionists, and Nurses.
 * Note: Hospital Administrator (ADMIN) accounts are restricted and cannot be created via public registration.
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();
    private final PatientDAO patientDAO = new PatientDAO();
    private final DoctorDAO doctorDAO = new DoctorDAO();
    private final ReceptionistDAO receptionistDAO = new ReceptionistDAO();
    private final VitalDAO vitalDAO = new VitalDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("departments", departmentDAO.getAllDepartments());
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String selectedRole = req.getParameter("role");
        if (selectedRole == null || selectedRole.trim().isEmpty()) {
            selectedRole = "PATIENT";
        }
        selectedRole = selectedRole.trim().toUpperCase();

        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        try {
            // Restriction check: Admin cannot be publicly created
            if ("ADMIN".equals(selectedRole)) {
                throw new ApplicationException("Hospital Administrator accounts are restricted to system administration and cannot be registered publicly.");
            }

            // Common validations
            if (!ValidationUtil.isNotEmpty(fullName)) {
                throw new ApplicationException("Please provide your full legal name.");
            }
            if (!ValidationUtil.isValidEmail(email)) {
                throw new ApplicationException("Please enter a valid email address.");
            }
            if (!ValidationUtil.isValidPassword(password)) {
                throw new ApplicationException("Password must be at least 6 characters in length.");
            }
            if (!ValidationUtil.isValidPhone(phone)) {
                throw new ApplicationException("Please provide a valid phone number (e.g. +91 98765 43210).");
            }

            // Unique email check
            if (userDAO.getUserByEmail(email) != null) {
                throw new ApplicationException("An account with email '" + email + "' already exists. Please log in directly.");
            }

            User user = new User();
            user.setFullName(ValidationUtil.sanitize(fullName));
            user.setEmail(email.trim().toLowerCase());
            user.setPasswordHash(PasswordUtil.hashPassword(password));
            user.setPhone(ValidationUtil.sanitize(phone));
            user.setStatus("ACTIVE");

            boolean success = false;

            switch (selectedRole) {
                case "DOCTOR": {
                    user.setRoleId(2); // Role 2 = DOCTOR

                    String deptIdStr = req.getParameter("departmentId");
                    String specialization = req.getParameter("specialization");
                    String qualification = req.getParameter("qualification");
                    String experienceYearsStr = req.getParameter("experienceYears");
                    String consultationFeeStr = req.getParameter("consultationFee");
                    String roomNo = req.getParameter("roomNo");
                    String availableDays = req.getParameter("availableDays");
                    String availableTime = req.getParameter("availableTime");

                    int deptId = ValidationUtil.isInteger(deptIdStr) ? Integer.parseInt(deptIdStr) : 1;
                    int experience = ValidationUtil.isInteger(experienceYearsStr) ? Integer.parseInt(experienceYearsStr) : 1;
                    BigDecimal fee = (consultationFeeStr != null && !consultationFeeStr.trim().isEmpty()) 
                            ? new BigDecimal(consultationFeeStr.trim()) : new BigDecimal("500.00");

                    Doctor doctor = new Doctor();
                    doctor.setDepartmentId(deptId);
                    doctor.setSpecialization(ValidationUtil.isNotEmpty(specialization) ? ValidationUtil.sanitize(specialization) : "General Medicine");
                    doctor.setQualification(ValidationUtil.isNotEmpty(qualification) ? ValidationUtil.sanitize(qualification) : "MBBS, MD");
                    doctor.setExperienceYears(experience);
                    doctor.setConsultationFee(fee);
                    doctor.setRoomNo(ValidationUtil.isNotEmpty(roomNo) ? ValidationUtil.sanitize(roomNo) : "OPD-101");
                    doctor.setAvailableDays(ValidationUtil.isNotEmpty(availableDays) ? ValidationUtil.sanitize(availableDays) : "Mon-Sat");
                    doctor.setAvailableTime(ValidationUtil.isNotEmpty(availableTime) ? ValidationUtil.sanitize(availableTime) : "09:00 AM - 05:00 PM");

                    success = doctorDAO.createDoctorWithUser(doctor, user);
                    break;
                }

                case "RECEPTIONIST": {
                    user.setRoleId(3); // Role 3 = RECEPTIONIST

                    String qualification = req.getParameter("qualification");
                    String shift = req.getParameter("shift");

                    Receptionist receptionist = new Receptionist();
                    receptionist.setQualification(ValidationUtil.isNotEmpty(qualification) ? ValidationUtil.sanitize(qualification) : "B.Com / Graduate");
                    receptionist.setShift(ValidationUtil.isNotEmpty(shift) ? ValidationUtil.sanitize(shift) : "MORNING");

                    success = receptionistDAO.createReceptionistWithUser(receptionist, user);
                    break;
                }

                case "NURSE": {
                    user.setRoleId(4); // Role 4 = NURSE

                    String deptIdStr = req.getParameter("departmentId");
                    String qualification = req.getParameter("qualification");
                    String shift = req.getParameter("shift");

                    Integer deptId = (deptIdStr != null && !deptIdStr.trim().isEmpty() && ValidationUtil.isInteger(deptIdStr))
                            ? Integer.parseInt(deptIdStr) : null;

                    Nurse nurse = new Nurse();
                    nurse.setDepartmentId(deptId);
                    nurse.setQualification(ValidationUtil.isNotEmpty(qualification) ? ValidationUtil.sanitize(qualification) : "B.Sc. Nursing (RN)");
                    nurse.setShift(ValidationUtil.isNotEmpty(shift) ? ValidationUtil.sanitize(shift) : "MORNING");

                    success = vitalDAO.createNurseWithUser(nurse, user);
                    break;
                }

                case "PATIENT":
                default: {
                    user.setRoleId(5); // Role 5 = PATIENT

                    String dobStr = req.getParameter("dob");
                    String gender = req.getParameter("gender");
                    String bloodGroup = req.getParameter("bloodGroup");
                    String address = req.getParameter("address");
                    String emergencyContactName = req.getParameter("emergencyContactName");
                    String emergencyContactPhone = req.getParameter("emergencyContactPhone");
                    String medicalHistorySummary = req.getParameter("medicalHistorySummary");

                    if (!ValidationUtil.isNotEmpty(dobStr)) {
                        dobStr = "2000-01-01"; // Default fallback if not provided
                    }

                    Patient patient = new Patient();
                    patient.setDob(Date.valueOf(dobStr));
                    patient.setGender(ValidationUtil.sanitize(gender != null ? gender : "MALE"));
                    patient.setBloodGroup(ValidationUtil.sanitize(bloodGroup != null ? bloodGroup : "O+"));
                    patient.setAddress(ValidationUtil.sanitize(address != null && !address.trim().isEmpty() ? address : "Registered Online"));
                    patient.setEmergencyContactName(ValidationUtil.sanitize(emergencyContactName != null && !emergencyContactName.trim().isEmpty() ? emergencyContactName : fullName));
                    patient.setEmergencyContactPhone(ValidationUtil.sanitize(emergencyContactPhone != null && !emergencyContactPhone.trim().isEmpty() ? emergencyContactPhone : phone));
                    patient.setMedicalHistorySummary(ValidationUtil.sanitize(medicalHistorySummary));

                    success = patientDAO.createPatientWithUser(patient, user);
                    break;
                }
            }

            if (!success) {
                throw new ApplicationException("Registration could not be completed. Please review entered details.");
            }

            String encodedEmail = URLEncoder.encode(email, StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/login.jsp?msg=registered&role=" + selectedRole + "&email=" + encodedEmail);

        } catch (ApplicationException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("selectedRole", selectedRole);
            req.setAttribute("fullName", fullName);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.setAttribute("departments", departmentDAO.getAllDepartments());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("errorMessage", "An unexpected system error occurred: " + e.getMessage());
            req.setAttribute("selectedRole", selectedRole);
            req.setAttribute("departments", departmentDAO.getAllDepartments());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
