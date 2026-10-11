# Week 9 Progress Report | SmartCare Hospital Management System

**Period:** `31-08-2026 to 06-09-2026`  
**Milestone Theme:** **Module coding - module completion and self-review**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-09.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-09.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team the module was completed, reviewed and pushed to GitHub. Devansh (Authentication): completed AdminServlet actions for user and department management; added duplicate username and email validation in user creation; added activate and deactivate user option for admin. Deepak (Patient): completed the medical records view for the patient; added the doctor's records.jsp to view and add notes; added patient auto-ID generation. Hansraj (Appointment): completed consultation saving into medical records; added the status change to Completed after consultation; added filters on appointment lists by date and status. Aryan (Pharmacy): reduced stock automatically when a prescription is issued; added lab result status flow (Requested to Completed); added vital history list for each patient. Devkinandan (Billing): completed the admin reports.jsp with revenue and admission figures; added payment status filters to the bills list; added the notification entries on bill generation. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Completed AdminServlet actions for user and department management; added duplicate username and email validation in user creation; added activate and deactivate user option for admin. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Completed the medical records view for the patient; added the doctor's records.jsp to view and add notes; added patient auto-ID generation. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Completed consultation saving into medical records; added the status change to Completed after consultation; added filters on appointment lists by date and status. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Reduced stock automatically when a prescription is issued; added lab result status flow (Requested to Completed); added vital history list for each patient. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Completed the admin reports.jsp with revenue and admission figures; added payment status filters to the bills list; added the notification entries on bill generation. |

### Box 2: Problems Faced
```text
Devansh: Merge conflicts in shared files. Deepak: Time was short for comments and cleanup. Hansraj: Status did not update after consultation. Aryan: Lab status flow had gaps. Devkinandan: Report query was slow with many joins. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Integration of all five modules. Devansh: merged all modules into one WAR project and resolved package conflicts. Deepak: integrated patient registration with the login of the patient user. Hansraj: integrated doctor list from Module 2 into booking. Aryan: linked prescriptions with consultation from Module 3. Devkinandan: linked bills to appointments and prescriptions from other modules.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Admin Controller** | Devansh Mathur | `src/main/java/com/smarthospital/controller/AdminServlet.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/AdminServlet.java) | Department management, staff allocation, user activation toggling, and audit log inspection. |
| **Patient Medical History View** | Deepak Kumar | `src/main/webapp/doctor/records.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/doctor/records.jsp) | Medical record timeline displaying past diagnoses, physician notes, and laboratory findings. |
| **Clinical Consultation Interface** | Hansraj Pandey | `src/main/webapp/doctor/consultation.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/doctor/consultation.jsp) | Direct consultation interface transitioning appointments to COMPLETED state. |
| **Nursing Vitals Interface** | Aryan Daware | `src/main/webapp/nurse/record_vitals.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/nurse/record_vitals.jsp) | Vital signs capture (temperature, pulse, blood pressure, blood oxygen, respiration). |
| **Hospital Analytics & Revenue Report** | Devkinandan Kumawat | `src/main/webapp/admin/reports.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/admin/reports.jsp) | Comprehensive hospital financial and bed occupancy reporting interface. |

### Key Milestones Achieved in Week 9
- **Automated Inventory Reduction:** Prescriptions trigger automatic deduction from `medicine_inventory`.
- **Integrated Medical Records:** Consultations record diagnoses straight into `medical_records`.
- **Audit Logging:** System administrative modifications are recorded directly to `audit_logs`.

---

### Navigation
[⬅️ Week 8](week-08.md) | [📑 All 13 Weeks Overview](README.md) | [Week 10 ➡️](week-10.md)
