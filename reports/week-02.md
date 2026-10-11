# Week 2 Progress Report | SmartCare Hospital Management System

**Period:** `13-07-2026 to 19-07-2026`  
**Milestone Theme:** **SRS (Software Requirement Specification)**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-02.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-02.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team the focus was on the Software Requirement Specification. Devansh (Authentication): identified five user roles: Admin, Doctor, Patient, Nurse and Receptionist; wrote functional requirements for login, logout, session handling and role-based access; wrote security requirements: password hashing, session timeout, audit trail. Deepak (Patient): listed patient requirements: registration, profile, history and records; listed doctor requirements: profile, department, specialisation and availability; wrote data requirements for patient and doctor details. Hansraj (Appointment): listed functional requirements for booking, rescheduling and cancelling; wrote requirements for doctor consultation and diagnosis notes; defined appointment statuses: Scheduled, Completed and Cancelled. Aryan (Pharmacy): listed requirements for medicine stock and expiry tracking; listed requirements for doctor prescriptions with medicine items; listed requirements for lab test request and result entry. Devkinandan (Billing): listed requirements for bill generation and payments; listed requirements for room allocation and admission; listed requirements for admin reports and revenue summary. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Identified five user roles: Admin, Doctor, Patient, Nurse and Receptionist; wrote functional requirements for login, logout, session handling and role-based access; wrote security requirements: password hashing, session timeout, audit trail. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Listed patient requirements: registration, profile, history and records; listed doctor requirements: profile, department, specialisation and availability; wrote data requirements for patient and doctor details. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Listed functional requirements for booking, rescheduling and cancelling; wrote requirements for doctor consultation and diagnosis notes; defined appointment statuses: Scheduled, Completed and Cancelled. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Listed requirements for medicine stock and expiry tracking; listed requirements for doctor prescriptions with medicine items; listed requirements for lab test request and result entry. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Listed requirements for bill generation and payments; listed requirements for room allocation and admission; listed requirements for admin reports and revenue summary. |

### Box 2: Problems Faced
```text
Devansh: Unclear which roles needed separate dashboards. Deepak: Overlap between patient and receptionist features. Hansraj: Defining all appointment statuses clearly. Aryan: Many pharmacy rules to capture. Devkinandan: Unclear billing rules at the start. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: UML design (use-case, class, sequence). Devansh: drew the use-case diagram for the Admin actor (manage users, departments, audit logs). Deepak: drew the use-case diagram for Patient and Doctor actors. Hansraj: drew the use-case diagram for booking and consultation. Aryan: drew the use-case diagram for Nurse and Lab actors. Devkinandan: drew the use-case diagram for billing and admission.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Software Requirements Specification (SRS)** | All Members | `docs/SRS.md` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/docs/SRS.md) | Comprehensive SRS document specifying functional and non-functional requirements for all five roles. |
| **Role & Permission Access Matrix** | Devansh Mathur | `docs/SYSTEM_ARCHITECTURE.md#role-based-access-control-matrix` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/docs/SYSTEM_ARCHITECTURE.md#role-based-access-control-matrix) | Defines the exact role privileges and security policies across system modules. |

### Key Milestones Achieved in Week 2
- **5 User Roles Formalized:** Admin, Doctor, Patient, Nurse, Receptionist.
- **Security Standards Set:** BCrypt salted password hashing, 30-minute session expiration, unalterable administrative audit logging.
- **Entity Life Cycles Mapped:**
  - Appointment statuses: `SCHEDULED` ➔ `COMPLETED` / `CANCELLED`.
  - Room occupancy states: `AVAILABLE` ➔ `OCCUPIED` ➔ `MAINTENANCE`.
  - Invoicing states: `PENDING` ➔ `PAID`.

---

### Navigation
[⬅️ Week 1](week-01.md) | [📑 All 13 Weeks Overview](README.md) | [Week 3 ➡️](week-03.md)
