# Week 5 Progress Report | SmartCare Hospital Management System

**Period:** `03-08-2026 to 09-08-2026`  
**Milestone Theme:** **Module coding - models and DAO layer**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-05.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-05.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team coding of the module began with models and DAO classes. Devansh (Authentication): wrote the Role and User model classes with getters and setters; created DBConnection utility reading db.properties; implemented UserDAO methods to fetch user by username and email. Deepak (Patient): wrote Patient model class with all fields; wrote Doctor and Receptionist model classes; implemented PatientDAO insert and select methods. Hansraj (Appointment): wrote the Appointment model with date and time fields; wrote the MedicalRecord model class; implemented AppointmentDAO insert and fetch by patient. Aryan (Pharmacy): wrote Medicine and MedicineInventory model classes; wrote Prescription and PrescriptionItem models; wrote LabTest and PatientVital models. Devkinandan (Billing): wrote Bill and Payment model classes; wrote Admission and Room model classes; wrote Feedback and Notification models. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Wrote the Role and User model classes with getters and setters; created DBConnection utility reading db.properties; implemented UserDAO methods to fetch user by username and email. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Wrote Patient model class with all fields; wrote Doctor and Receptionist model classes; implemented PatientDAO insert and select methods. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Wrote the Appointment model with date and time fields; wrote the MedicalRecord model class; implemented AppointmentDAO insert and fetch by patient. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Wrote Medicine and MedicineInventory model classes; wrote Prescription and PrescriptionItem models; wrote LabTest and PatientVital models. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Wrote Bill and Payment model classes; wrote Admission and Room model classes; wrote Feedback and Notification models. |

### Box 2: Problems Faced
```text
Devansh: Driver not found error for MySQL connector. Deepak: Date conversion between java.util and java.sql. Hansraj: SQL Time type mapping was confusing. Aryan: Mapping decimal fields correctly. Devkinandan: Decimal rounding in totals. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Module coding - services and servlets. Devansh: wrote PasswordUtil using the jBCrypt library for hashing and verification. Deepak: implemented PatientServlet actions for view and update profile. Hansraj: created AppointmentService with input validation. Aryan: implemented MedicineServlet for inventory add and update. Devkinandan: built BillingService to calculate totals and taxes.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Database Connection Manager** | Devansh Mathur | `src/main/java/com/smarthospital/util/DBConnection.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/util/DBConnection.java) | Singleton database connection utility loading configuration from db.properties. |
| **Database Properties File** | Devansh Mathur | `src/main/resources/db.properties` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/resources/db.properties) | Connection parameters including driver, host, database, credentials, and connection limits. |
| **User Domain Entity** | Devansh Mathur | `src/main/java/com/smarthospital/model/User.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/model/User.java) | Core user credentials entity with role ID, email, password hash, and active status. |
| **Patient Domain Entity** | Deepak Kumar | `src/main/java/com/smarthospital/model/Patient.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/model/Patient.java) | Domain model encapsulating patient demographics, blood group, phone, and address. |
| **Appointment Domain Entity** | Hansraj Pandey | `src/main/java/com/smarthospital/model/Appointment.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/model/Appointment.java) | Appointment model with date, time slot, patient ID, doctor ID, and status. |
| **Medicine & Inventory Models** | Aryan Daware | `src/main/java/com/smarthospital/model/Medicine.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/model/Medicine.java) | Pharmaceutical and inventory entities with batch number, stock count, and unit price. |
| **Billing & Room Domain Models** | Devkinandan Kumawat | `src/main/java/com/smarthospital/model/Bill.java` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/model/Bill.java) | Entities for invoices, payment receipts, room allocations, and patient admissions. |
| **Core DAO Layer Classes** | All Members | `src/main/java/com/smarthospital/dao/` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/dao/) | Implementation of UserDAO, PatientDAO, DoctorDAO, AppointmentDAO, MedicineDAO, BillingDAO, etc. |

### Key Milestones Achieved in Week 5
- **Singleton Connection Pool:** `DBConnection.java` created with clean connection acquisition and closing methods.
- **JavaBean Models:** 21 JavaBean entity classes built with encapsulation, constructors, and getters/setters.
- **Parameterized SQL:** All DAOs implemented strictly with `PreparedStatement` to eliminate SQL injection.

---

### Navigation
[⬅️ Week 4](week-04.md) | [📑 All 13 Weeks Overview](README.md) | [Week 6 ➡️](week-06.md)
