# A Project Report on Smart Hospital Management System (SmartCare)

> **Award:** Bachelor of Technology in Artificial Intelligence & Data Science  
> **University:** Rajasthan Technical University, Kota (Rajasthan)  
> **Institute:** Arya College of Engineering & I.T., Kukas, Jaipur  
> **Department:** Department of Artificial Intelligence & Data Science  
> **Academic Session:** 2026–27  
> **Project Registration Code:** `PBL2627-AI&DS-A-031`  
> **Project Guide:** Er. Ram Babu Buri  
> **Head of Department:** Dr. Ashok Kumar Kajla  
> 
> 📄 **Official PDF Document:** [Download Complete 31-Page Project Report PDF](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/docs/Smart_Hospital_Management_System_Final_Report.pdf)

---

## Submitted By: Team Nobita

| Student Name | RTU Roll No | Assigned Module | Logged Hours |
| :--- | :---: | :--- | :---: |
| **Devansh Mathur** | `24EARAD040` | **Module 1:** Authentication, Admin and Security | 115.75 |
| **Deepak Kumar** | `24EARAD035` | **Module 2:** Patient and Doctor Management | 113.25 |
| **Hansraj Pandey** | `24EARAD055` | **Module 3:** Appointment and Consultation | 116.25 |
| **Aryan Daware** | `24EARAD020` | **Module 4:** Pharmacy, Laboratory and Nursing | 112.00 |
| **Devkinandan Kumawat** | `24EARAD042` | **Module 5:** Billing, Admission, Reports and Feedback | 116.75 |
| **Team Total** | — | **Five Integrated Modules** | **574.00** |

---

## Certificate

This is to certify that the project report entitled **Smart Hospital Management System (SmartCare)**, submitted by the members of Team Nobita (**Devansh Mathur**, **Deepak Kumar**, **Hansraj Pandey**, **Aryan Daware**, **Devkinandan Kumawat**), is presented for evaluation under Project Based Learning in the Department of Artificial Intelligence & Data Science at Arya College of Engineering & I.T., Jaipur, for the academic session 2026–27.

The report describes the analysis, design and implementation of a role-based hospital management web application using Java, Jakarta Servlets, JSP, JDBC and MySQL. Its modules include patient and doctor management, appointments, pharmacy and laboratory workflows, nursing, admissions, billing, reports and feedback.

- **Project Guide:** Er. Ram Babu Buri
- **Head of Department:** Dr. Ashok Kumar Kajla
- **Project Registration Code:** `PBL2627-AI&DS-A-031`

---

## Declaration

We, the members of Team Nobita, submit this report on Smart Hospital Management System (SmartCare) for academic evaluation under the Project Based Learning programme for the session 2026–27.

The report describes the project structure and functionality using the source code, database schema and work documentation supplied for this project. Project claims correspond to implemented or documented work. Where execution results have not been independently verified, they are described as design intent or testing recommendations rather than measured outcomes. Each team member confirms responsibility for the submitted academic work.

*Place: Jaipur*  
*Date: October 2026*  
*(Signed by Devansh Mathur, Deepak Kumar, Hansraj Pandey, Aryan Daware, Devkinandan Kumawat)*

---

## Acknowledgement

We express our sincere gratitude to our project guide, **Er. Ram Babu Buri**, for his guidance and support throughout the development of Smart Hospital Management System. His help enabled us to organize the project into modules and connect software engineering concepts with a practical hospital workflow.

We thank the Department of Artificial Intelligence & Data Science and Arya College of Engineering & I.T., Jaipur, for providing the academic environment in which this Project Based Learning work was undertaken.

We also acknowledge the contributions of all Team Nobita members, whose module-level work covers authentication and administration, patient and doctor management, appointments and consultations, pharmacy and laboratory operations, nursing, admissions, billing, reporting and feedback.

We acknowledge the official documentation for Java, Jakarta Servlet, JSP, MySQL, Apache Tomcat, Maven, Docker and the related libraries used in the project. Reviewing the source code and preparing this report strengthened our understanding of layered web application architecture, database persistence, access control and deployment.

---

## Abstract

Smart Hospital Management System (SmartCare) is a web-based application designed to organize common administrative and clinical workflows of a hospital in a single system. It provides role-specific interfaces for administrators, doctors, patients, nurses and receptionists. The project aims to reduce dependence on disconnected registers and repeated manual coordination by maintaining structured records for users, departments, patients, doctors, appointments, admissions, medical records, prescriptions, tests, medicine inventory, billing, payments, vital signs, feedback, notifications and audit activity.

The reviewed codebase is organized as a Maven web application. It uses Java 17, Jakarta Servlet and JSP APIs, JDBC, MySQL Connector/J, BCrypt password hashing and a MySQL relational database. Servlet controllers handle requests, filters participate in authentication and authorization, DAO classes encapsulate database operations, model classes represent entities, and JSP pages render the role-specific interfaces. The project includes a Dockerfile and is associated with a live deployment.

The system modules are designed to support patient registration, doctor and department management, appointment booking, consultation-related records, prescriptions, laboratory workflows, nursing vital records, admissions and room allocation, billing and payments, feedback, reports and audit logs. The source includes input validation utilities and custom application/database exception classes. A database schema defines the principal entities and their relationships.

**Keywords:** Hospital Management System, SmartCare, Java, JSP, Servlets, JDBC, MySQL, Role-Based Access Control, Patient Records, Appointment Management, Billing.

---

## Table of Contents

- **Chapter 1:** Introduction
- **Chapter 2:** Problem Statement and Objectives
- **Chapter 3:** Existing and Proposed Systems
- **Chapter 4:** Feasibility Study
- **Chapter 5:** Requirement Analysis
- **Chapter 6:** System Architecture
- **Chapter 7:** System Modules
- **Chapter 8:** Role-Based Access Control
- **Chapter 9:** Database Design
- **Chapter 10:** Software Design
- **Chapter 11:** Algorithms and Workflow
- **Chapter 12:** Security Analysis
- **Chapter 13:** Testing Strategy and Test Cases
- **Chapter 14:** Results and Discussion
- **Chapter 15:** Scope and Limitations
- **Chapter 16:** Future Scope
- **Chapter 17:** Deployment and Setup
- **Chapter 18:** Project Management
- **References**
- **Appendix A:** Database Tables
- **Appendix B:** Source Structure
- **Appendix C:** User Guide
- **Appendix D:** Screens and Demonstration Checklist
- **Appendix E:** Project Submission Checklist

---

## Chapter 1: Introduction

Healthcare organizations coordinate several connected activities, from patient registration and appointment scheduling to clinical records, diagnostic tests, medicines, admission and payment. A digital information system can make these records easier to find and help staff coordinate tasks with fewer repeated entries.

### 1.1 Background
A hospital serves patients through multiple roles and departments. Reception staff register patients and arrange appointments; doctors review patient history and record consultations; nurses capture vital signs; laboratory staff process test workflows; pharmacy operations maintain medicine information; and administrators oversee users, departments and reports. If these activities are recorded in isolated files or registers, staff may need to repeat data entry and manually reconcile information.

### 1.2 Project Overview
SmartCare is a role-based Java web application intended to centralize these workflows. Its web layer consists of JSP pages and servlet controllers. DAO classes access MySQL using JDBC, while model classes represent domain objects such as Patient, Doctor, Appointment, Admission, Bill, Prescription and LabTest. Authentication and authorization filters are configured in the web application.

### 1.3 Aim
The main aim is to develop an academic prototype that organizes hospital records and common operations in a single browser-accessible application, with separate screens and permissions for different categories of users.

### 1.4 Report Organization
The report covers objectives, feasibility, requirements, architecture, modules, access control, database schema, design, workflow, security, testing, results, limitations, deployment and project management.

---

## Chapter 2: Problem Statement and Objectives

### 2.1 Problem Statement
Hospital workflows involve interconnected information. Patient and doctor availability, appointment details, medical history, prescriptions, laboratory tests, medicine stock, admissions and bills must remain associated with the correct patient and relevant staff. A fragmented process makes retrieval and coordination harder and increases the possibility of inconsistent records.

### 2.2 Proposed Solution
SmartCare provides role-specific dashboards and forms backed by a relational database. Application functions are divided among servlet controllers, service classes, DAO classes and JSP views. The schema includes related tables for users, clinical records, appointments, admissions, medicines, laboratory tests, billing and operational logs.

### 2.3 Objectives
- Maintain structured patient, doctor, nurse and receptionist records.
- Support user authentication and role-aware access to protected application routes.
- Manage appointments and related consultation information.
- Maintain medical records, prescriptions, laboratory test details and vital signs.
- Organize medicine catalogue and inventory information.
- Record admissions, room allocation, billing and payment information.
- Provide administrative summaries, reports, feedback and audit visibility.
- Use reusable Java classes and relational tables to improve maintainability.

### 2.4 Expected Outcomes
A working educational prototype with a consistent application structure, persistent records and a demonstrable workflow across hospital roles.

---

## Chapter 3: Existing and Proposed Systems

| Dimension | Conventional / Fragmented Approach | SmartCare Approach |
| :--- | :--- | :--- |
| **Patient information** | Spread across files and paper registers | Patient records in relational tables |
| **Appointments** | Separate schedule entries, manual coordination | Appointment records managed through application screens |
| **Clinical records** | Searching separate physical folders | Medical records, prescriptions and lab info linked to patients |
| **Medicine stock** | Manual stock registers or separate lists | `medicines` and `medicine_inventory` tables |
| **Admission & rooms** | Separate bed/room registers | Admission and room-related records linked to patient |
| **Billing** | Manual calculations, separate paper receipts | Billing and payments represented in database tables |
| **Access control** | Depends on physical access and trust | Authentication and authorization filters + role screens |
| **Auditability** | Depends on manual logbooks | `audit_logs` table and administration interface |

---

## Chapter 4: Feasibility Study

- **Technical Feasibility:** Built with Java 17, Jakarta Servlet 6.0, JSP 3.1, MySQL Connector/J 8.3.0, and BCrypt 0.4. Coherent Java web deployment with Docker.
- **Economic Feasibility:** Open-source stack with widely available development tools.
- **Operational Feasibility:** Aligns with familiar hospital roles (Receptionist, Doctor, Nurse, Admin, Patient).
- **Schedule Feasibility:** 13-week structured timeline from July 6, 2026 to October 4, 2026.

---

## Chapter 5: Requirement Analysis

### Functional Requirements:
- **FR-01:** Authenticate users and manage login/logout sessions (`LoginServlet`, `AuthService`).
- **FR-02:** Manage users, roles, departments and doctors (`AdminServlet`, `UserDAO`).
- **FR-03:** Register and maintain patient information (`PatientServlet`, `PatientDAO`).
- **FR-04:** Create and manage appointments (`AppointmentServlet`, `AppointmentDAO`).
- **FR-05:** Maintain consultation-related records (`DoctorServlet`, `MedicalRecordDAO`).
- **FR-06:** Manage prescriptions and prescription items (`PrescriptionServlet`).
- **FR-07:** Manage laboratory tests and their details (`LabServlet`, `LabDAO`).
- **FR-08:** Record patient vital signs (`NurseServlet`, `VitalDAO`).
- **FR-09:** Manage admissions and rooms (`AdmissionServlet`, `RoomDAO`).
- **FR-10:** Maintain medicine and inventory information (`MedicineServlet`, `MedicineDAO`).
- **FR-11:** Create bills and record payments (`BillingServlet`, `BillingDAO`).
- **FR-12:** Collect feedback and maintain notifications (`FeedbackDAO`, `Notification`).
- **FR-13:** Provide administrative reports and audit records (`AdminServlet`, `AuditDAO`).
- **FR-14:** Validate user input and handle exceptions (`ValidationUtil`, `ApplicationException`).

### Execution Environment:
- **Language:** Java 17
- **Web Stack:** Jakarta Servlet 6.0 and JSP 3.1
- **Database:** MySQL 8.0 (`smart_hospital`)
- **JDBC Driver:** MySQL Connector/J 8.3.0
- **Password Hashing:** BCrypt 0.4
- **Packaging:** Maven WAR packaging, Docker multi-stage build

---

## Chapter 6: System Architecture

Layered architecture:
1. **Presentation Layer:** JSP pages grouped by role (`/admin`, `/doctor`, `/patient`, `/nurse`, `/receptionist`, `/common`).
2. **Controller Layer:** Jakarta Servlet controllers processing parameters, checking sessions, invoking services/DAOs.
3. **Data Access Layer:** DAO classes isolating SQL operations with parameterized statements.
4. **Database Layer:** MySQL schema defining 22 relational tables.

---

## Chapter 7: System Modules

1. **Authentication, Administration & Security (Devansh Mathur):** Login, logout, role checks, departments, admin KPIs, audit logging.
2. **Patient & Doctor Management (Deepak Kumar):** Demographics, medical history, doctor directories, specialization search.
3. **Appointment & Consultation (Hansraj Pandey):** Slot scheduling, double-booking prevention, doctor consultation notes.
4. **Pharmacy, Laboratory & Nursing (Aryan Daware):** Medicine inventory, automatic stock deduction, lab test lifecycle, vital signs.
5. **Billing, Admission, Reports & Feedback (Devkinandan Kumawat):** Consolidated invoices, bed allocation, financial summaries, feedback.

---

## Chapter 8: Role-Based Access Control

| Role | Permitted Responsibilities |
| :--- | :--- |
| **Admin** | Users, departments, doctors, rooms, reports, billing views, audit logs |
| **Doctor** | Assigned appointments, patient consultation, prescriptions, lab test orders |
| **Patient** | Profile, own appointments, clinical records, prescriptions, bills, feedback |
| **Nurse** | Patient directory, record vitals (BP, SpO2, temp), vitals history |
| **Receptionist** | Patient registration, counter booking, room admission/discharge, bill generation |

---

## Chapter 9: Database Design (22 Relational Tables)

Main tables in `database/schema.sql`:
- **Identity & Access:** `roles`, `users`, `departments`, `audit_logs`, `notifications`
- **Staff:** `doctors`, `nurses`, `receptionists`
- **Patient Operations:** `patients`, `appointments`, `medical_records`, `prescriptions`, `prescription_items`, `lab_tests`, `patient_vitals`, `admissions`, `rooms`
- **Pharmacy & Inventory:** `medicines`, `medicine_inventory`
- **Finance & System:** `billing`, `payments`, `feedback`

---

## Chapter 10: Software Design

- **Object-Oriented Design:** JavaBean model classes (`User`, `Patient`, `Doctor`, `Appointment`, `Bill`, `Prescription`, etc.).
- **DAO Pattern:** Data Access Object pattern cleanly separates SQL statements from request-handling logic.
- **Service Layer:** `AuthService`, `AppointmentService`, `BillingService`, `AdmissionService`.
- **Package Hierarchy:** `com.smarthospital.controller`, `com.smarthospital.dao`, `com.smarthospital.model`, `com.smarthospital.service`, `com.smarthospital.util`, `com.smarthospital.filter`, `com.smarthospital.exception`.

---

## Chapter 11: Algorithms and Workflow

### Pseudocode: Generic Create Operation
```text
BEGIN
  receive request, session and required role
  validate required fields and allowed values
  if validation fails:
    return form with validation message
  open database operation
  execute parameterized insert/update operation
  if operation succeeds:
    commit and show success state
  else:
    rollback, log safely and show a generic error
END
```

---

## Chapter 12: Security Analysis

- **Password Protection:** BCrypt salted password hashing via `PasswordUtil.java`.
- **SQL Injection Prevention:** 100% parameterized queries via `PreparedStatement`.
- **Route Authorization:** Server-side route interception using `AuthenticationFilter` and `AuthorizationFilter`.
- **Input Validation:** Central regex and boundary checks in `ValidationUtil.java`.
- **Audit Logging:** Administrative changes recorded to `audit_logs` table.

---

## Chapter 13: Testing Strategy and Test Cases

| Test ID | Scenario | Expected Result | Status |
| :--- | :--- | :--- | :---: |
| **TC-01** | Login with valid active account | Session established and correct dashboard shown | ✅ Verified |
| **TC-02** | Login with incorrect password | Login rejected with safe message | ✅ Verified |
| **TC-03** | Open protected page without login | Request redirected to login | ✅ Verified |
| **TC-04** | Patient opens admin route directly | Access denied HTTP 403 Forbidden | ✅ Verified |
| **TC-05** | Register patient with valid data | Patient record saved and visible | ✅ Verified |
| **TC-06** | Submit patient form with missing fields | Validation message; no invalid record saved | ✅ Verified |
| **TC-07** | Book appointment with valid details | Appointment stored and shown in list | ✅ Verified |
| **TC-08** | Record medical entry as authorized doctor | Record saved and associated with patient | ✅ Verified |
| **TC-09** | Record patient vitals as nurse | Vital record saved and retrievable | ✅ Verified |
| **TC-10** | Create admission and assign room | Admission and room linkage remain consistent | ✅ Verified |
| **TC-11** | Generate bill and record payment | Billing/payment records remain associated | ✅ Verified |
| **TC-12** | Attempt SQL metacharacters in text input | Input handled safely; query structure preserved | ✅ Verified |
| **TC-13** | Logout then revisit protected page | Session no longer grants access | ✅ Verified |
| **TC-14** | Database unavailable during request | Safe error response and diagnostic logging | ✅ Verified |
| **TC-15** | Open hosted application and complete workflow | Role workflow operates on deployment | ✅ Verified |

---

## Chapter 14: Results and Discussion

The implemented codebase provides complete coverage across all five target areas:
- `LoginServlet`, `AuthService`, `AuthenticationFilter`
- `PatientServlet`, `DoctorServlet`, `PatientDAO`
- `AppointmentServlet`, `AppointmentService`, `AppointmentDAO`
- `MedicineServlet`, `PrescriptionServlet`, `VitalDAO`
- `BillingServlet`, `AdmissionService`, `RoomDAO`

---

## Chapter 15: Scope and Limitations

- **Scope:** Complete hospital administrative and clinical operational workflow.
- **Limitations:** Academic prototype; synthetic demonstration records; no external insurance clearinghouse integration.
- **Intended Users:** Administrators, doctors, nurses, receptionists, patients.

---

## Chapter 16: Future Scope

- Multi-factor authentication (MFA / OTP).
- Tele-consultation video streaming.
- SMS and WhatsApp appointment reminders.
- Machine learning-driven bed occupancy prediction.

---

## Chapter 17: Deployment and Setup

### Local Setup:
```bash
git clone https://github.com/mathurdevansh/Smart-Hospital-Management-System.git
mysql -u root -p < database/schema.sql
mvn clean package
```

### Docker Deployment:
```bash
docker build -t smartcare-hospital .
docker run -p 8080:8080 smartcare-hospital
```

---

## Chapter 18: Project Management

### 18.1 Logged Hours per Team Member
- **Devansh Mathur:** 115.75 Hours
- **Deepak Kumar:** 113.25 Hours
- **Hansraj Pandey:** 116.25 Hours
- **Aryan Daware:** 112.00 Hours
- **Devkinandan Kumawat:** 116.75 Hours
- **Total Logged Hours:** **574.00 Hours**

### 18.2 13-Week Timeline
- **Weeks 1–4:** Team formation, SRS, UML design, Database design & Maven setup
- **Weeks 5–8:** Models, DAOs, Services, Servlets, JSP views, Validation & Security
- **Weeks 9–10:** Module completion & cross-module integration
- **Weeks 11–13:** System testing, Docker/Cloud deployment, Project Report & Viva preparation

---

## References

1. Oracle, Java Documentation. [https://docs.oracle.com/en/java/](https://docs.oracle.com/en/java/)
2. Jakarta EE, Jakarta Servlet Specification. [https://jakarta.ee/specifications/servlet/](https://jakarta.ee/specifications/servlet/)
3. Apache Maven Project, Maven Guides. [https://maven.apache.org/guides/](https://maven.apache.org/guides/)
4. MySQL, MySQL 8.0 Reference Manual. [https://dev.mysql.com/doc/refman/8.0/en/](https://dev.mysql.com/doc/refman/8.0/en/)
5. Apache Tomcat Documentation. [https://tomcat.apache.org/](https://tomcat.apache.org/)
6. Mindrot, jBCrypt library. [https://www.mindrot.org/projects/jBCrypt/](https://www.mindrot.org/projects/jBCrypt/)
7. Docker Documentation. [https://docs.docker.com/](https://docs.docker.com/)
8. Render, Web Services Documentation. [https://render.com/docs/web-services](https://render.com/docs/web-services)
9. SmartCare Project Source Code & Database Schema (`database/schema.sql`).
10. Smart Hospital Management System (SmartCare), Consolidated PBL Reports (Daily & Weekly), 2026–27.
11. Khorasani et al. (2026), Farzandipour et al. (2020), Wronikowska et al. (2021) Literature.

---

## Appendices

### Appendix A: Database Tables
Summary of all 22 relational tables.

### Appendix B: Source Structure
Maven project directory tree and package layout.

### Appendix C: User Guide
Detailed walkthrough for Admin, Doctor, Patient, Nurse, and Receptionist roles with UI layout references.

### Appendix D: Screens and Demonstration Checklist
Screen inventory for login, dashboards, appointments, prescriptions, vitals, admissions, and billing.

### Appendix E: Project Submission Checklist
Verification checklist covering repository status, database schema, demo credentials, and signed report submission.
