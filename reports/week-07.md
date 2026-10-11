# Week 7 Progress Report | SmartCare Hospital Management System

**Period:** `17-08-2026 to 23-08-2026`  
**Milestone Theme:** **Module coding - JSP views and UI**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-07.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-07.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team the JSP pages and user interface were developed. Devansh (Authentication): created login.jsp with responsive form and error messages; created admin dashboard.jsp with summary cards; built admin users.jsp with table for add, edit and delete users. Deepak (Patient): created the patient dashboard.jsp with quick links; created the patient profile.jsp with editable form; created the doctor dashboard.jsp with appointment summary. Hansraj (Appointment): created the patient book_appointment.jsp with doctor and slot selection; created the patient appointments.jsp with status badges; created the receptionist book_appointment.jsp. Aryan (Pharmacy): created the inventory.jsp with stock table and add form; created prescriptions.jsp for the doctor and prescription_view.jsp; created lab_management.jsp and lab_test_details.jsp. Devkinandan (Billing): created the invoice.jsp with printable layout; created receptionist billing.jsp and generate_bill.jsp; created common admit_patient.jsp and admission_list.jsp. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Created login.jsp with responsive form and error messages; created admin dashboard.jsp with summary cards; built admin users.jsp with table for add, edit and delete users. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Created the patient dashboard.jsp with quick links; created the patient profile.jsp with editable form; created the doctor dashboard.jsp with appointment summary. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Created the patient book_appointment.jsp with doctor and slot selection; created the patient appointments.jsp with status badges; created the receptionist book_appointment.jsp. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Created the inventory.jsp with stock table and add form; created prescriptions.jsp for the doctor and prescription_view.jsp; created lab_management.jsp and lab_test_details.jsp. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Created the invoice.jsp with printable layout; created receptionist billing.jsp and generate_bill.jsp; created common admit_patient.jsp and admission_list.jsp. |

### Box 2: Problems Faced
```text
Devansh: Include files broke relative paths in admin pages. Deepak: Form values lost after validation failure. Hansraj: Date picker accepted past dates. Aryan: Dynamic rows in prescription form. Devkinandan: Invoice print layout broke on paper size. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Module coding - validation, exceptions, security. Devansh: wrote ValidationUtil for email, phone and empty field checks. Deepak: added server-side validation for phone, age and blood group. Hansraj: added past-date and empty reason validations. Aryan: added validation for quantity, dose and vitals ranges. Devkinandan: added validation for amount, payment mode and dates.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Master UI Stylesheet** | Devansh Mathur / All | `src/main/webapp/css/style.css` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/css/style.css) | Design tokens, responsive cards, modern data tables, badges, and print layouts. |
| **Modular JSP Layouts** | Devansh Mathur | `src/main/webapp/includes/sidebar.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/includes/sidebar.jsp) | Reusable header, navigation, sidebar, and footer JSP partials. |
| **Authentication Interface** | Devansh Mathur | `src/main/webapp/login.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/login.jsp) | Clean login interface with feedback alerts and demo account quick-login cards. |
| **Admin Dashboard & User Directory** | Devansh Mathur | `src/main/webapp/admin/dashboard.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/admin/dashboard.jsp) | Administrative console displaying hospital metrics and user access controls. |
| **Patient & Appointment Views** | Deepak & Hansraj | `src/main/webapp/patient/book_appointment.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/patient/book_appointment.jsp) | Patient booking page with dynamic doctor dropdown and time selection. |
| **Pharmacy & Laboratory Views** | Aryan Daware | `src/main/webapp/common/inventory.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/common/inventory.jsp) | Stock tracking tables, doctor prescription forms, and test report viewers. |
| **Billing & Invoice Printable Views** | Devkinandan Kumawat | `src/main/webapp/common/invoice.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/common/invoice.jsp) | Print-optimized invoice showing detailed fee breakdown and payment receipts. |

### Key Milestones Achieved in Week 7
- **Consistent Design Language:** Standardized color tokens, responsive sidebar, and table designs in `style.css`.
- **Role-Aware Sidebar:** Dynamic sidebar rendering links tailored to the logged-in user's role.
- **Dedicated Print Styles:** `@media print` rules implemented for invoices and medical discharge summaries.

---

### Navigation
[⬅️ Week 6](week-06.md) | [📑 All 13 Weeks Overview](README.md) | [Week 8 ➡️](week-08.md)
