# Week 3 Progress Report | SmartCare Hospital Management System

**Period:** `20-07-2026 to 26-07-2026`  
**Milestone Theme:** **UML design (use-case, class, sequence)**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-03.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-03.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team the focus was on UML design diagrams. Devansh (Authentication): drew the use-case diagram for the Admin actor (manage users, departments, audit logs); drew the login and logout sequence diagram with filters and session; designed class diagram for User, Role and AuditLog. Deepak (Patient): drew the use-case diagram for Patient and Doctor actors; designed the class diagram for Patient with attributes and methods; designed the class diagram for Doctor and Receptionist. Hansraj (Appointment): drew the use-case diagram for booking and consultation; designed the class diagram for Appointment; designed the class diagram for MedicalRecord. Aryan (Pharmacy): drew the use-case diagram for Nurse and Lab actors; designed the class diagram for Medicine and MedicineInventory; designed the class diagram for Prescription and PrescriptionItem. Devkinandan (Billing): drew the use-case diagram for billing and admission; designed the class diagram for Bill and Payment; designed the class diagram for Admission and Room. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Drew the use-case diagram for the Admin actor (manage users, departments, audit logs); drew the login and logout sequence diagram with filters and session; designed class diagram for User, Role and AuditLog. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Drew the use-case diagram for Patient and Doctor actors; designed the class diagram for Patient with attributes and methods; designed the class diagram for Doctor and Receptionist. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Drew the use-case diagram for booking and consultation; designed the class diagram for Appointment; designed the class diagram for MedicalRecord. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Drew the use-case diagram for Nurse and Lab actors; designed the class diagram for Medicine and MedicineInventory; designed the class diagram for Prescription and PrescriptionItem. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Drew the use-case diagram for billing and admission; designed the class diagram for Bill and Payment; designed the class diagram for Admission and Room. |

### Box 2: Problems Faced
```text
Devansh: Mixing class diagram relations for User and Role. Deepak: Deciding attributes for Patient class. Hansraj: Showing the double-booking rule in sequence diagram. Aryan: Parent-child relation for prescription items. Devkinandan: Relation between admission and room. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Database (ER) design, UI mock-ups, project setup. Devansh: designed ER tables roles, users and audit_logs with keys and constraints. Deepak: designed the patients table with personal and contact fields. Hansraj: designed the appointments table with doctor, patient and slot columns. Aryan: designed the medicines and medicine_inventory tables. Devkinandan: designed the billing and payments tables.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **UML Class & Sequence Models** | All Members | `docs/SYSTEM_ARCHITECTURE.md` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/docs/SYSTEM_ARCHITECTURE.md) | Class diagrams and interaction sequences for all 5 subsystems. |
| **Java Domain Models Blueprint** | Devansh Mathur / All | `src/main/java/com/smarthospital/model/` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/model/) | Java domain classes matching the UML design specifications. |

### Key Milestones Achieved in Week 3
- **Authentication Sequence Diagram:** Client Request ➔ `AuthenticationFilter` ➔ `LoginServlet` ➔ `AuthService` ➔ `UserDAO` ➔ Session Validation ➔ Role-Specific Dispatcher.
- **Double-Booking Prevention Flow:** Verified slot concurrency sequence between `AppointmentServlet` and `AppointmentService`.
- **Entity Relationship Boundaries:** Clarified distinctions between `User` (credentials/role) and domain profiles (`Doctor`, `Patient`, `Nurse`, `Receptionist`).

---

### Navigation
[⬅️ Week 2](week-02.md) | [📑 All 13 Weeks Overview](README.md) | [Week 4 ➡️](week-04.md)
