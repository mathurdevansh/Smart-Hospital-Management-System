# Week 4 Progress Report | SmartCare Hospital Management System

**Period:** `27-07-2026 to 02-08-2026`  
**Milestone Theme:** **Database (ER) design, UI mock-ups, project setup**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-04.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-04.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team the focus was on database design, mock-ups and project setup. Devansh (Authentication): designed ER tables roles, users and audit_logs with keys and constraints; designed the departments table and linked doctors to departments; created Maven project structure with pom.xml and Jakarta Servlet dependencies. Deepak (Patient): designed the patients table with personal and contact fields; designed the doctors table with department link and qualification; designed the medical_records table and its relation to patients. Hansraj (Appointment): designed the appointments table with doctor, patient and slot columns; designed the medical_records table linked to appointments; worked out indexes for date and doctor lookups. Aryan (Pharmacy): designed the medicines and medicine_inventory tables; designed prescriptions and prescription_items tables; designed lab_tests and patient_vitals tables. Devkinandan (Billing): designed the billing and payments tables; designed the rooms and admissions tables; designed the feedback and notifications tables. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Designed ER tables roles, users and audit_logs with keys and constraints; designed the departments table and linked doctors to departments; created Maven project structure with pom.xml and Jakarta Servlet dependencies. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Designed the patients table with personal and contact fields; designed the doctors table with department link and qualification; designed the medical_records table and its relation to patients. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Designed the appointments table with doctor, patient and slot columns; designed the medical_records table linked to appointments; worked out indexes for date and doctor lookups. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Designed the medicines and medicine_inventory tables; designed prescriptions and prescription_items tables; designed lab_tests and patient_vitals tables. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Designed the billing and payments tables; designed the rooms and admissions tables; designed the feedback and notifications tables. |

### Box 2: Problems Faced
```text
Devansh: Foreign key order created errors in SQL script. Deepak: Normalising patient and record tables. Hansraj: Choosing correct indexes for lookups. Aryan: Foreign key order in schema. Devkinandan: Choosing data types for amounts. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Module coding - models and DAO layer. Devansh: wrote the Role and User model classes with getters and setters. Deepak: wrote Patient model class with all fields. Hansraj: wrote the Appointment model with date and time fields. Aryan: wrote Medicine and MedicineInventory model classes. Devkinandan: wrote Bill and Payment model classes.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Relational Database Schema (22 Tables)** | All Members | `database/schema.sql` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/database/schema.sql) | Complete MySQL schema defining 22 relational tables with keys, constraints, and indexes. |
| **Maven Project Configuration (pom.xml)** | Devansh Mathur | `pom.xml` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/pom.xml) | Configured Jakarta Servlet 6.0, JSTL 3.0, MySQL Connector/J 8.0+, and jBCrypt dependencies. |
| **Servlet 6.0 Deployment Descriptor** | Devansh Mathur | `src/main/webapp/WEB-INF/web.xml` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/WEB-INF/web.xml) | Servlet 6.0 web.xml configuring security rules, session timeouts, and default welcome endpoints. |

### Key Milestones Achieved in Week 4
- **All 22 Tables Designed:** `roles`, `departments`, `users`, `doctors`, `patients`, `nurses`, `receptionists`, `rooms`, `admissions`, `appointments`, `medical_records`, `medicines`, `medicine_inventory`, `prescriptions`, `prescription_items`, `lab_tests`, `billing`, `payments`, `patient_vitals`, `feedback`, `audit_logs`, `notifications`.
- **Project Structure Initialized:** Maven Java Enterprise WAR project established with standard folder structure.
- **FK Dependency Order Resolved:** Added drop cascades and structured creation order with `SET FOREIGN_KEY_CHECKS = 0;`.

---

### Navigation
[⬅️ Week 3](week-03.md) | [📑 All 13 Weeks Overview](README.md) | [Week 5 ➡️](week-05.md)
