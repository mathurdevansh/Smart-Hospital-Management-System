# Week 10 Progress Report | SmartCare Hospital Management System

**Period:** `07-09-2026 to 13-09-2026`  
**Milestone Theme:** **Integration of all five modules**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-10.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-10.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team all five modules were integrated into one application. Devansh (Authentication): merged all modules into one WAR project and resolved package conflicts; connected the login redirect to every role dashboard; checked filter rules against every servlet URL pattern. Deepak (Patient): integrated patient registration with the login of the patient user; linked doctor listing with the appointment booking page; checked navigation between patient and doctor pages after merge. Hansraj (Appointment): integrated doctor list from Module 2 into booking; connected consultation with prescription and lab pages; fixed time format mismatch between JSP and DAO. Aryan (Pharmacy): linked prescriptions with consultation from Module 3; linked lab tests to the doctor's lab_reports page; linked patient prescriptions page with prescription data. Devkinandan (Billing): linked bills to appointments and prescriptions from other modules; linked admission with patient and room lists; connected the reports page to data from all modules. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Merged all modules into one WAR project and resolved package conflicts; connected the login redirect to every role dashboard; checked filter rules against every servlet URL pattern. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Integrated patient registration with the login of the patient user; linked doctor listing with the appointment booking page; checked navigation between patient and doctor pages after merge. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Integrated doctor list from Module 2 into booking; connected consultation with prescription and lab pages; fixed time format mismatch between JSP and DAO. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Linked prescriptions with consultation from Module 3; linked lab tests to the doctor's lab_reports page; linked patient prescriptions page with prescription data. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Linked bills to appointments and prescriptions from other modules; linked admission with patient and room lists; connected the reports page to data from all modules. |

### Box 2: Problems Faced
```text
Devansh: Sidebar links showed wrong items for some roles. Deepak: Connections were not closed in a few methods. Hansraj: Time format mismatch between JSP and DAO. Aryan: Foreign key errors after merge. Devkinandan: Totals mismatched after merging charges. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Testing (unit, functional, role-based). Devansh: prepared test cases for login, wrong password and locked access. Deepak: wrote test cases for patient registration and profile update. Hansraj: wrote test cases for booking, rescheduling and cancelling. Aryan: wrote test cases for inventory and prescription. Devkinandan: wrote test cases for billing and payments.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Master Deployment Descriptor** | Devansh Mathur / All | `src/main/webapp/WEB-INF/web.xml` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/WEB-INF/web.xml) | Unified web descriptor mapping 14 Servlets, 2 Security Filters, error endpoints, and parameters. |
| **Multi-Role Self Registration** | Devansh & Deepak | `src/main/java/com/smarthospital/controller/RegisterServlet.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/RegisterServlet.java) | Centralized registration controller handling patient, doctor, nurse, and staff onboarding. |
| **Unified Diagnostic Hub** | Hansraj & Aryan | `src/main/webapp/doctor/lab_reports.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/doctor/lab_reports.jsp) | Coordinates doctor orders, laboratory test entries, and patient notifications. |
| **Composite Billing Generation** | Devkinandan Kumawat | `src/main/webapp/receptionist/generate_bill.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/receptionist/generate_bill.jsp) | Aggregates doctor consultation fees, pharmacy orders, and room stay charges into single invoice. |

### Key Milestones Achieved in Week 10
- **Unified Application Build:** Successfully packaged entire application into single enterprise WAR (`SmartCareHospital.war`).
- **Complete End-to-End Hospital Flow:** Registration ➔ Appointment Booking ➔ Doctor Consultation ➔ Medication & Diagnostics ➔ Billing & Discharge.
- **Resource Management:** Ensured all DAO classes implement `try-with-resources` to close connections and prevent pool exhaustion.

---

### Navigation
[⬅️ Week 9](week-09.md) | [📑 All 13 Weeks Overview](README.md) | [Week 11 ➡️](week-11.md)
