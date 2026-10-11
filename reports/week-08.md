# Week 8 Progress Report | SmartCare Hospital Management System

**Period:** `24-08-2026 to 30-08-2026`  
**Milestone Theme:** **Module coding - validation, exceptions, security**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-08.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-08.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team validation, exception handling and security were added. Devansh (Authentication): wrote ValidationUtil for email, phone and empty field checks; created ApplicationException and DatabaseException classes; implemented AuthenticationFilter to block pages for logged-out users. Deepak (Patient): added server-side validation for phone, age and blood group; added JavaScript validation on registration form fields; handled exceptions in DAO methods with clear user messages. Hansraj (Appointment): added past-date and empty reason validations; handled booking exceptions with friendly messages; added JavaScript to block past dates in the date picker. Aryan (Pharmacy): added validation for quantity, dose and vitals ranges; handled exceptions for stock below zero cases; added JavaScript validation to vitals form. Devkinandan (Billing): added validation for amount, payment mode and dates; handled exceptions for occupied room and duplicate payment; prevented overpayment greater than the bill total. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Wrote ValidationUtil for email, phone and empty field checks; created ApplicationException and DatabaseException classes; implemented AuthenticationFilter to block pages for logged-out users. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Added server-side validation for phone, age and blood group; added JavaScript validation on registration form fields; handled exceptions in DAO methods with clear user messages. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Added past-date and empty reason validations; handled booking exceptions with friendly messages; added JavaScript to block past dates in the date picker. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Added validation for quantity, dose and vitals ranges; handled exceptions for stock below zero cases; added JavaScript validation to vitals form. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Added validation for amount, payment mode and dates; handled exceptions for occupied room and duplicate payment; prevented overpayment greater than the bill total. |

### Box 2: Problems Faced
```text
Devansh: Filter blocked static CSS and JS files. Deepak: Search became slow without proper query. Hansraj: Cancel was visible to wrong role. Aryan: Stock could go negative. Devkinandan: Overpayment case was missed. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Module coding - module completion and self-review. Devansh: completed AdminServlet actions for user and department management. Deepak: completed the medical records view for the patient. Hansraj: completed consultation saving into medical records. Aryan: reduced stock automatically when a prescription is issued. Devkinandan: completed the admin reports.jsp with revenue and admission figures.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Global Authentication Filter** | Devansh Mathur | `src/main/java/com/smarthospital/filter/AuthenticationFilter.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/filter/AuthenticationFilter.java) | Session verification filter safeguarding protected endpoints with static asset bypass. |
| **Role-Based Authorization Filter** | Devansh Mathur | `src/main/java/com/smarthospital/filter/AuthorizationFilter.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/filter/AuthorizationFilter.java) | Restricts URL paths like /admin/* or /doctor/* to authenticated users holding authorized roles. |
| **Input Validation Utility** | Devansh Mathur | `src/main/java/com/smarthospital/util/ValidationUtil.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/util/ValidationUtil.java) | Regex validation for email, 10-digit Indian phone numbers, positive currency, and dates. |
| **Custom Application Exceptions** | Devansh Mathur | `src/main/java/com/smarthospital/exception/ApplicationException.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/exception/ApplicationException.java) | Custom exception hierarchy encapsulating business faults without exposing raw SQL errors. |
| **Client-Side Validation Script** | Deepak / Hansraj / Aryan | `src/main/webapp/js/main.js` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/js/main.js) | Form verification script ensuring date constraints, positive stock numbers, and prompt client feedback. |

### Key Milestones Achieved in Week 8
- **Route Interception:** Unauthorized page accesses cleanly redirect to login with user alert.
- **Asset Exemption:** Static resources (.css, .js, assets) bypass the security filter to prevent infinite redirection.
- **Data Integrity Safeguards:** Negative medicine counts, past-dated bookings, and overpayments strictly blocked.

---

### Navigation
[⬅️ Week 7](week-07.md) | [📑 All 13 Weeks Overview](README.md) | [Week 9 ➡️](week-09.md)
