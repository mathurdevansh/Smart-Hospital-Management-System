# Week 6 Progress Report | SmartCare Hospital Management System

**Period:** `10-08-2026 to 16-08-2026`  
**Milestone Theme:** **Module coding - services and servlets**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-06.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-06.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team the service and servlet layers of the module were built. Devansh (Authentication): wrote PasswordUtil using the jBCrypt library for hashing and verification; built AuthService login flow with credential and role checking; implemented LoginServlet doGet and doPost with redirect by role. Deepak (Patient): implemented PatientServlet actions for view and update profile; implemented DoctorServlet dashboard action with today's data; added the patient search action by name and phone. Hansraj (Appointment): created AppointmentService with input validation; added the double-booking check inside the service; implemented AppointmentServlet for booking requests. Aryan (Pharmacy): implemented MedicineServlet for inventory add and update; implemented PrescriptionServlet to save multiple medicine items; implemented LabServlet for test request and result update. Devkinandan (Billing): built BillingService to calculate totals and taxes; built AdmissionService for admit, transfer and discharge logic; implemented BillingServlet for bill generation and payment. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Wrote PasswordUtil using the jBCrypt library for hashing and verification; built AuthService login flow with credential and role checking; implemented LoginServlet doGet and doPost with redirect by role. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Implemented PatientServlet actions for view and update profile; implemented DoctorServlet dashboard action with today's data; added the patient search action by name and phone. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Created AppointmentService with input validation; added the double-booking check inside the service; implemented AppointmentServlet for booking requests. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Implemented MedicineServlet for inventory add and update; implemented PrescriptionServlet to save multiple medicine items; implemented LabServlet for test request and result update. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Built BillingService to calculate totals and taxes; built AdmissionService for admit, transfer and discharge logic; implemented BillingServlet for bill generation and payment. |

### Box 2: Problems Faced
```text
Devansh: Role redirect looped back to login page. Deepak: Null pointer when patient had no record. Hansraj: Double-booking check allowed edge cases. Aryan: Saving many items needed a loop with transaction. Devkinandan: Room status not updated on discharge. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Module coding - JSP views and UI. Devansh: created login.jsp with responsive form and error messages. Deepak: created the patient dashboard.jsp with quick links. Hansraj: created the patient book_appointment.jsp with doctor and slot selection. Aryan: created the inventory.jsp with stock table and add form. Devkinandan: created the invoice.jsp with printable layout.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **BCrypt Password Utility** | Devansh Mathur | `src/main/java/com/smarthospital/util/PasswordUtil.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/util/PasswordUtil.java) | Salted hash generation and comparison using jBCrypt with demo plaintext fallback. |
| **Authentication Service** | Devansh Mathur | `src/main/java/com/smarthospital/service/AuthService.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/service/AuthService.java) | Coordinates credential verification, user activation state, role mapping, and audit logging. |
| **Login & Logout Servlets** | Devansh Mathur | `src/main/java/com/smarthospital/controller/LoginServlet.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/LoginServlet.java) | Manages session establishment, role dispatching, and secure session invalidation. |
| **Patient & Doctor Servlets** | Deepak Kumar | `src/main/java/com/smarthospital/controller/PatientServlet.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/PatientServlet.java) | Profile editing, patient lookup, and physician dashboard metrics. |
| **Appointment Business Service** | Hansraj Pandey | `src/main/java/com/smarthospital/service/AppointmentService.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/service/AppointmentService.java) | Ensures doctor availability and rejects concurrent booking collisions. |
| **Pharmacy & Laboratory Servlets** | Aryan Daware | `src/main/java/com/smarthospital/controller/MedicineServlet.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/MedicineServlet.java) | Inventory CRUD, multi-item prescription recording, and laboratory test workflows. |
| **Billing & Admission Services** | Devkinandan Kumawat | `src/main/java/com/smarthospital/service/BillingService.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/service/BillingService.java) | Tax and fee aggregation, bed allocation, and patient discharge workflows. |

### Key Milestones Achieved in Week 6
- **BCrypt Password Security:** Implemented cryptographic hashing using `PasswordUtil.java`.
- **Role-Based Redirection:** Automatic routing to `/admin/dashboard`, `/doctor/dashboard`, `/patient/dashboard`, `/nurse/dashboard`, or `/receptionist/dashboard`.
- **Atomic Multi-Row Prescriptions:** Prescriptions and line items saved within a transactional database block.

---

### Navigation
[⬅️ Week 5](week-05.md) | [📑 All 13 Weeks Overview](README.md) | [Week 7 ➡️](week-07.md)
