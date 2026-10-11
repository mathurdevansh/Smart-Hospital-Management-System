# Week 11 Progress Report | SmartCare Hospital Management System

**Period:** `14-09-2026 to 20-09-2026`  
**Milestone Theme:** **Testing (unit, functional, role-based)**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-11.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-11.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team the application was tested in detail and defects were fixed. Devansh (Authentication): prepared test cases for login, wrong password and locked access; tested role-based access by opening restricted URLs directly; tested session expiry and logout behaviour. Deepak (Patient): wrote test cases for patient registration and profile update; tested invalid and boundary inputs on forms; tested doctor dashboard data with multiple doctors. Hansraj (Appointment): wrote test cases for booking, rescheduling and cancelling; tested double-booking prevention with same slot; tested consultation notes and record saving. Aryan (Pharmacy): wrote test cases for inventory and prescription; tested stock deduction with multiple medicines; tested lab request and result entry. Devkinandan (Billing): wrote test cases for billing and payments; tested tax and total calculations with samples; tested admission, room status and discharge. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Prepared test cases for login, wrong password and locked access; tested role-based access by opening restricted URLs directly; tested session expiry and logout behaviour. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Wrote test cases for patient registration and profile update; tested invalid and boundary inputs on forms; tested doctor dashboard data with multiple doctors. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Wrote test cases for booking, rescheduling and cancelling; tested double-booking prevention with same slot; tested consultation notes and record saving. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Wrote test cases for inventory and prescription; tested stock deduction with multiple medicines; tested lab request and result entry. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Wrote test cases for billing and payments; tested tax and total calculations with samples; tested admission, room status and discharge. |

### Box 2: Problems Faced
```text
Devansh: Session lost after server restart during tests. Deepak: Some inputs allowed negative age. Hansraj: A test case failed for same-time reschedule. Aryan: Edge case in stock deduction. Devkinandan: Rounding difference in a test case. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Deployment (Docker, Render, cloud MySQL) and bug fixing. Devansh: wrote a Dockerfile (Maven build stage and Tomcat 10.1 run stage). Deepak: checked patient and doctor pages on the deployed site. Hansraj: tested booking flow on the live Render site. Aryan: checked inventory and prescription pages on the live site. Devkinandan: checked billing, admission and report pages on live site.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Custom HTTP 403 Forbidden View** | Devansh Mathur | `src/main/webapp/errors/403.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/errors/403.jsp) | User-friendly unauthorized access view preventing unauthorized role escalations. |
| **Custom HTTP 404 Not Found View** | Devansh Mathur | `src/main/webapp/errors/404.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/errors/404.jsp) | Graceful handling of unknown paths without exposing container internals. |
| **Custom HTTP 500 Internal Error View** | Devansh Mathur | `src/main/webapp/errors/500.jsp` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/errors/500.jsp) | Friendly system error interface preventing database error leakage to end users. |
| **Comprehensive Test Case Log** | All Members | `docs/PROJECT_REPORT.md#testing-and-quality-assurance` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/docs/PROJECT_REPORT.md#testing-and-quality-assurance) | Complete test case matrix verifying authentication, boundary limits, and transaction safety. |

### Key Milestones Achieved in Week 11
- **Role Security Validated:** Verified that unauthorized role paths immediately trigger HTTP 403 or redirect to login.
- **Double Booking Guard Passed:** Verified slot collision handling blocks duplicate bookings for the same doctor and time slot.
- **Data Boundary Testing:** Verified edge cases: age boundaries, phone number regex validation, and non-negative currency amounts.

---

### Navigation
[⬅️ Week 10](week-10.md) | [📑 All 13 Weeks Overview](README.md) | [Week 12 ➡️](week-12.md)
