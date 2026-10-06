package com.smarthospital.service;

import com.smarthospital.dao.AuditDAO;
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

import java.util.logging.Logger;

public class AuthService {

    private static final Logger LOGGER = Logger.getLogger(AuthService.class.getName());

    private final UserDAO userDAO = new UserDAO();
    private final DoctorDAO doctorDAO = new DoctorDAO();
    private final PatientDAO patientDAO = new PatientDAO();
    private final ReceptionistDAO receptionistDAO = new ReceptionistDAO();
    private final VitalDAO vitalDAO = new VitalDAO();
    private final AuditDAO auditDAO = new AuditDAO();

    public User login(String email, String plainPassword, String roleName, String ipAddress) {
        if (!ValidationUtil.isValidEmail(email)) {
            throw new ApplicationException("Please provide a valid email address.");
        }
        if (!ValidationUtil.isValidPassword(plainPassword)) {
            throw new ApplicationException("Password must be at least 6 characters.");
        }
        if (!ValidationUtil.isNotEmpty(roleName)) {
            throw new ApplicationException("Please select your assigned role.");
        }

        // Try lookup with given role first; fallback to direct role code if needed
        User user = userDAO.getUserByEmailAndRole(email, roleName);
        if (user == null && roleName.equalsIgnoreCase("Hospital Administrator")) {
            user = userDAO.getUserByEmailAndRole(email, "ADMIN");
        }

        if (user == null) {
            auditDAO.log(null, "LOGIN_FAILED", "Failed login attempt for " + email + " with role " + roleName, ipAddress);
            throw new ApplicationException("Invalid email, password, or role combination.");
        }

        if (!"ACTIVE".equalsIgnoreCase(user.getStatus())) {
            auditDAO.log(user.getUserId(), "LOGIN_BLOCKED", "Deactivated account login attempt", ipAddress);
            throw new ApplicationException("Your account is " + user.getStatus().toLowerCase() + ". Please contact hospital administration.");
        }

        // Fallback: match BCrypt hash OR plain text (for demo accounts)
        boolean matches = PasswordUtil.checkPassword(plainPassword, user.getPasswordHash());
        if (!matches && plainPassword != null && plainPassword.equals(user.getPasswordHash())) {
            matches = true;
        }

        if (!matches) {
            auditDAO.log(user.getUserId(), "LOGIN_FAILED", "Incorrect password entered for " + email, ipAddress);
            throw new ApplicationException("Invalid email or password.");
        }

        auditDAO.log(user.getUserId(), "LOGIN_SUCCESS", "Successfully logged in as " + user.getRoleName(), ipAddress);
        return user;
    }

    public void logout(User user, String ipAddress) {
        if (user != null) {
            auditDAO.log(user.getUserId(), "LOGOUT", "User logged out safely", ipAddress);
        }
    }

    public Object getRoleSpecificProfile(User user) {
        if (user == null || user.getRoleName() == null) {
            return null;
        }
        switch (user.getRoleName().toUpperCase()) {
            case "DOCTOR":
                return doctorDAO.getDoctorByUserId(user.getUserId());
            case "PATIENT":
                return patientDAO.getPatientByUserId(user.getUserId());
            case "RECEPTIONIST":
                return receptionistDAO.getReceptionistByUserId(user.getUserId());
            case "NURSE":
                return vitalDAO.getNurseByUserId(user.getUserId());
            default:
                return user;
        }
    }
}