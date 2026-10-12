# Software Requirements Specification (SRS)
## SmartCare – Smart Hospital Management System

> **Document ID:** `SC-SRS-001` | **Version:** `1.0` | **Status:** Academic Project Draft  
> **Institution:** Arya College of Engineering & I.T., Kukas, Jaipur  
> **Department:** Department of Artificial Intelligence & Data Science  
> **Affiliation:** Rajasthan Technical University, Kota (Raj.)  
> **Academic Session:** 2026–27  
> **Project Guide:** Er. Ram Babu Buri  
> **Prepared By:** Team Nobita  
> - **Devansh Mathur** (`24EARAD040`)  
> - **Deepak Kumar** (`24EARAD035`)  
> - **Hansraj Pandey** (`24EARAD055`)  
> - **Aryan Daware** (`24EARAD020`)  
> - **Devkinandan Kumawat** (`24EARAD042`)  
> 
> 📄 **Official PDF Document:** [Download Original SRS PDF (SC-SRS-001)](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/docs/SmartCare_SRS.pdf)

---

## Document Control

| Field | Details |
| :--- | :--- |
| **Project** | SmartCare – Smart Hospital Management System |
| **Prepared by** | Team Nobita, Department of AI & Data Science |
| **Reviewed by** | Project Guide: Er. Ram Babu Buri |
| **Academic session** | 2026–27 |
| **Technology baseline** | Java 17, Jakarta Servlets/JSP, JDBC, MySQL, Maven WAR; BCrypt; Docker deployment if used |

---

## Table of Contents
1. [Introduction and Scope](#1-introduction-and-scope)
2. [Overall Description](#2-overall-description)
3. [System Architecture](#3-system-architecture)
4. [Functional Requirements](#4-functional-requirements)
5. [Non-Functional Requirements](#5-non-functional-requirements)
6. [Data and External Interface Requirements](#6-data-and-external-interface-requirements)
7. [Data Flow Diagrams (DFD)](#7-data-flow-diagrams-dfd)
8. [Entity Relationship Diagram (ERD)](#8-entity-relationship-diagram-erd)
9. [Use-Case Model and Workflows](#9-use-case-model-and-workflows)
10. [Verification, Acceptance and Traceability](#10-verification-acceptance-and-traceability)
11. [Assumptions, Constraints and Risks](#11-assumptions-constraints-and-risks)
12. [Glossary and Conclusion](#12-glossary-and-conclusion)

---

## 1. Introduction and Scope

### 1.1 Purpose
This Software Requirements Specification defines the functional and non-functional requirements for SmartCare, a web-based hospital management application. It establishes a common reference for the development team, guide, testers and academic evaluators, and provides a basis for deriving test cases and reviewing system completeness.

### 1.2 Product Scope
The supplied project structure indicates modules for login and role management, patient and doctor management, appointment scheduling, medical records and consultation, prescriptions, medicines and inventory, laboratory tests, nursing and patient vitals, admissions and rooms, billing and payments, feedback, audit logs and notifications. These modules are presented as the project scope because corresponding database entities and application components are present in the supplied project archive. Feature details must still be confirmed in the running build.

### 1.3 Intended Audience
This document is intended for developers, testers, project guides and academic evaluators. Developers use it to understand requirements; testers use it to design verification scenarios; evaluators use it to assess whether the documented scope is supported by the implementation and test evidence.

### 1.4 Definitions and Requirement Notation
- **FR-x:** Functional Requirement
- **NFR-x:** Non-Functional Requirement
- **PK:** Primary Key; **FK:** Foreign Key
- **DFD:** Data Flow Diagram; **ERD:** Entity Relationship Diagram
- **"Shall":** Required behaviour in defined scope
- **"Should":** Recommended quality or implementation practice

### 1.5 System Boundary
SmartCare is an academic software project for hospital administration and record workflows. This SRS does not claim clinical validation, regulatory certification, integration with external national health platforms, or suitability for real-world clinical decision-making.

---

## 2. Overall Description

### 2.1 Product Perspective
The project follows a Java web-application structure. Browser requests are handled by JSP-based presentation pages and servlet controllers. Authentication and authorization filters protect routes, DAO components communicate with the MySQL database through JDBC, and the database schema defines the principal entities and relationships. Maven is used for build packaging; Docker may be used where included in the deployment setup.

### 2.2 User Classes
- **Administrator:** Manages system-level users, roles and administrative data.
- **Doctor:** Accesses appointment, patient, consultation, medical-record, prescription and laboratory information permitted by the application.
- **Nurse:** Accesses permitted patient and vital-record workflows.
- **Receptionist:** Manages patient registration, appointments, rooms/admissions and billing workflows supported by the application.
- **Patient:** Accesses permitted profile, appointments, medical records, prescriptions, laboratory reports, bills and feedback pages.

### 2.3 Operating Environment
The application is intended to be accessed through a modern web browser. The project stack specifies Java 17, Jakarta Servlets/JSP, JDBC and MySQL.

### 2.4 Constraints and Dependencies
The application depends on a running Java web container, valid configuration, reachable MySQL database and a correctly created schema. Some features depend on linked records—for example, appointments depend on patients and doctors, prescriptions depend on patients and doctors, and payments depend on bills. The actual role permissions must match the supplied authorization logic.

### 2.5 Assumptions
Users have valid accounts and use only their assigned roles. Test data is synthetic. The final implementation may differ from the intended scope, so requirements must be reconciled against the running system and source code before formal acceptance.

---

## 3. System Architecture

```text
       ┌──────────────────────────────────────────────────┐
       │             Browser UI (JSP / HTML / CSS)        │
       └─────────────────────────┬────────────────────────┘
                                 │ HTTP request / response
                                 ▼
       ┌──────────────────────────────────────────────────┐
       │ Servlet Controllers + Auth / Authz Filters       │
       └─────────────────────────┬────────────────────────┘
                                 │ validated operations
                                 ▼
       ┌──────────────────────────────────────────────────┐
       │             DAO / JDBC Data Access Layer         │
       └─────────────────────────┬────────────────────────┘
                                 │ SQL / result sets
                                 ▼
       ┌──────────────────────────────────────────────────┐
       │                 MySQL Database                   │
       └──────────────────────────────────────────────────┘
```

### 3.1 Presentation Layer
JSP pages and browser-facing components display forms, dashboards, lists and status messages. The interface should use consistent labels, predictable navigation and clear validation feedback.

### 3.2 Controller and Access-Control Layer
Servlet controllers process incoming requests and invoke the appropriate application/data operations. Authentication filters verify session state; authorization logic restricts access based on role and route/action permissions. Server-side checks are required even when the interface hides unavailable actions.

### 3.3 Data-Access Layer
DAO classes encapsulate database operations and map stored records to application models. Database operations should use safe parameter handling, appropriate transaction boundaries and predictable error handling.

### 3.4 Persistence Layer
MySQL stores users, roles, patients, doctors, appointments, medical records, medicines, prescriptions, lab tests, admissions, billing and other supported records. Referential integrity is expressed through primary keys and foreign keys in the schema.

---

## 4. Functional Requirements

### 4.1 Authentication and Roles
- **FR-01:** The system shall allow registered users to authenticate using valid credentials.
- **FR-02:** Invalid credentials shall not grant access and shall produce a non-sensitive message.
- **FR-03:** An authenticated user shall be able to log out.
- **FR-04:** Protected routes shall require an authenticated session.
- **FR-05:** Access to functions shall be restricted according to the user's assigned role.
- **FR-06:** Passwords shall not be stored or displayed in plain text; the supplied project describes BCrypt-based password handling.

### 4.2 Patient and Doctor Management
- **FR-07:** Authorised users shall be able to create, view, search and update patient records within the implemented fields.
- **FR-08:** Authorised users shall be able to view and maintain doctor information and department associations supported by the application.
- **FR-09:** The system shall validate required fields and reject invalid values.
- **FR-10:** The system should prevent accidental duplicate records when a reliable unique identifier is available.

### 4.3 Appointment Management
- **FR-11:** Authorised users shall be able to create appointments associated with a patient and doctor.
- **FR-12:** Appointment data shall be validated before saving.
- **FR-13:** The system shall support viewing appointment details and status for authorised roles.
- **FR-14:** Rescheduling, cancellation and conflict prevention shall follow the rules implemented in the application and must be tested explicitly.

### 4.4 Medical Records and Prescriptions
- **FR-15:** Authorised clinicians shall be able to create or view medical records associated with the relevant patient and doctor.
- **FR-16:** Medical records may be linked to an appointment where the schema supports that relationship.
- **FR-17:** Authorised users shall be able to create and view prescriptions for the relevant patient and doctor.
- **FR-18:** Prescription items shall reference medicines supported by the database schema.

### 4.5 Laboratory and Pharmacy
- **FR-19:** Authorised users shall be able to manage laboratory test records and status/results supported by the application.
- **FR-20:** Lab records shall be associated with the relevant patient and doctor and optionally appointment where supported.
- **FR-21:** Authorised users shall be able to view medicine information and inventory records.
- **FR-22:** If inventory quantity changes are implemented, values shall be validated and stored consistently.

### 4.6 Nursing, Admissions and Rooms
- **FR-23:** Authorised nursing users shall be able to record and view patient vital information supported by the application.
- **FR-24:** Vital records shall reference the relevant patient and nurse.
- **FR-25:** Authorised staff shall be able to manage admissions and room associations where implemented.
- **FR-26:** Admission records shall reference the appropriate patient and, where applicable, doctor and room.

### 4.7 Billing and Payments
- **FR-27:** Authorised staff shall be able to create and view billing records supported by the application.
- **FR-28:** Billing records shall be linked to the relevant patient and may reference an appointment or admission where applicable.
- **FR-29:** Payment records shall reference the bill to which the payment belongs.
- **FR-30:** Monetary fields and calculated totals shall be validated and tested against known examples.

### 4.8 Feedback, Audit Logs and Notifications
- **FR-31:** The system shall support patient feedback records as implemented, with optional association to a doctor where supported.
- **FR-32:** Audit events should record relevant user actions where the audit module is implemented.
- **FR-33:** Notifications shall be associated with the intended user and displayed only to authorised recipients.
- **FR-34:** Successful and failed actions should return clear status messages.

### 4.9 Reports and Search
- **FR-35:** The system shall expose only the reports and search features actually provided by the application.
- **FR-36:** Search and report results shall respect user permissions and use consistent filtering rules.
- **FR-37:** Empty result sets and invalid filters shall be handled with clear messages rather than misleading output.

### 4.10 Error Handling
- **FR-38:** The application shall handle invalid input and unexpected server/database errors without displaying sensitive implementation details.
- **FR-39:** A failed database operation shall not be presented to the user as a successful save.
- **FR-40:** Access-denied, not-found and internal-error pages should provide an appropriate response without exposing secrets.

---

## 5. Non-Functional Requirements

### 5.1 Security
- **NFR-01:** Authentication shall be required for protected functions.
- **NFR-02:** Authorization shall be enforced on the server side.
- **NFR-03:** Passwords shall be protected using the configured password-hashing method.
- **NFR-04:** Database queries should use parameterized statements where applicable.
- **NFR-05:** Credentials and secret configuration values shall not be committed to public source code.
- **NFR-06:** Logs and user-facing errors shall avoid unnecessary sensitive information.
- **NFR-07:** Sessions shall be handled safely, including logout and expired-session behaviour.

### 5.2 Usability and Accessibility
- **NFR-08:** Pages shall use consistent navigation, labels and terminology.
- **NFR-09:** Form errors shall identify the invalid or missing input clearly.
- **NFR-10:** Save/update actions should provide visible confirmation.
- **NFR-11:** Text, form controls and status indicators should remain readable and usable across common screen sizes.

### 5.3 Performance
- **NFR-12:** Common actions should meet response-time targets defined before performance testing.
- **NFR-13:** Performance reports shall document environment, dataset size, number of repetitions and observed response times.

### 5.4 Reliability and Data Integrity
- **NFR-14:** The system should handle database unavailability and invalid input without silent data loss.
- **NFR-15:** Related records shall maintain the primary-key/foreign-key relationships defined in the schema.
- **NFR-16:** Critical data changes should be traceable where audit logging is implemented.

### 5.5 Maintainability and Portability
- **NFR-17:** Source code should maintain clear separation between presentation, controller and data-access responsibilities.
- **NFR-18:** Build and setup instructions should be documented and repeatable.
- **NFR-19:** Schema changes should be versioned or documented.
- **NFR-20:** Deployment-specific configuration should be documented separately from source code.

### 5.6 Privacy and Ethical Use
- **NFR-21:** Demonstrations and testing should use synthetic data unless authorised data use has been approved.
- **NFR-22:** Patient-related information shall be accessible only for authorised purposes.
- **NFR-23:** The academic prototype shall not be used as a substitute for professional medical systems or clinical judgement.

---

## 6. Data and External Interface Requirements

### 6.1 User Interface Requirements
Sign-in, role-specific navigation, clear form error handling, confirmation for irreversible actions, persistent patient context.

### 6.2 Software Interfaces
Java 17, Jakarta Servlets/JSP, JDBC and MySQL, Maven WAR packaging, BCrypt, Docker containerization.

### 6.3 Database Entities
`roles`, `users`, `departments`, `doctors`, `patients`, `nurses`, `receptionists`, `rooms`, `admissions`, `appointments`, `medical_records`, `medicines`, `medicine_inventory`, `prescriptions`, `prescription_items`, `lab_tests`, `billing`, `payments`, `patient_vitals`, `feedback`, `audit_logs`, `notifications`.

### 6.4 Communication and Deployment
Browser sends HTTP requests to Java web app, which accesses MySQL via JDBC over SSL/TLS.

### 6.5 Backup and Recovery
Team documentation on restoring schema from `database/schema.sql` and seeding synthetic demonstration records.

---

## 7. Data Flow Diagrams (DFD)

### 7.1 DFD Level 0 — Context Diagram
```text
           ┌─────────────────┐             ┌──────────────────┐
           │  Administrator  │             │  Doctor / Nurse  │
           └────────┬────────┘             └────────┬─────────┘
                    │ Users / roles                 │ Clinical workflows
                    ▼                               ▼
       ┌────────────────────────────────────────────────────────┐
       │         SmartCare Hospital Management System           │
       └────────────────────────────────────────────────────────┘
                    ▲                               ▲
                    │ Admin / appt data             │ Appointments / bills
           ┌────────┴────────┐             ┌────────┴─────────┐
           │  Receptionist   │             │     Patient      │
           └─────────────────┘             └──────────────────┘
```

### 7.2 DFD Level 1 — Major Processes and Data Stores
```text
  [ External Users ]
          │ credentials
          ▼
   ┌──────────────┐     authorised req      ┌──────────────┐    workflow data    ┌──────────────┐
   │ 1.0 Auth &   │ ──────────────────────> │ 2.0 Manage   │ ──────────────────> │ 3.0 Hospital │
   │ Route        │                         │ Records      │                     │ Workflows    │
   └──────┬───────┘                         └──────┬───────┘                     └──────┬───────┘
          │ read/verify                            │ read/write                         │ read/write
          ▼                                        ▼                                    ▼
   [ D1: Users/Roles ]                      [ D2: Patient/Doctor ]               [ D3: Clinical/Finance ]
```

---

## 8. Entity Relationship Diagram (ERD)

```text
  [ROLES] ──1:N── [USERS] ──1:1── [PATIENTS]   ──1:N── [APPOINTMENTS]
                             └──1:1── [DOCTORS]    ──1:N── [MEDICAL_RECORDS]
                             └──1:1── [NURSES]     ──1:N── [PATIENT_VITALS]
                             └──1:1── [RECEPTION]  ──1:N── [ADMISSIONS] ── [ROOMS]
                                                   ──1:N── [BILLING] ──1:N── [PAYMENTS]
                                                   ──1:N── [PRESCRIPTIONS] ──1:N── [PRESCRIPTION_ITEMS]
                                                   ──1:N── [LAB_TESTS]
```

### 8.1 Principal Relationships
- `roles` 1-to-many `users`
- `users` 1-to-0/1 profile records: `doctors`, `patients`, `nurses`, `receptionists`
- `departments` 1-to-many `doctors`
- `patients` and `doctors` referenced by `appointments`, `medical_records`, `prescriptions`, `lab_tests`
- `prescriptions` 1-to-many `prescription_items` (references `medicines`)
- `billing` 1-to-many `payments`
- `admissions` references `patients` and `rooms`

---

## 9. Use-Case Model and Core Workflows

### 9.1 Use-Case Model
- **Staff User:** Sign in, manage patients/doctors, clinical records, pharmacy, billing.
- **Patient:** Sign in, book appointment, view prescriptions, view invoices, give feedback.
- **Administrator:** Sign in, manage users/roles, manage departments, view audit logs, view analytics.

### 9.2 Use Case: Sign In
- **Actor:** Any registered user.
- **Main Flow:** User submits credentials ➔ system verifies against BCrypt hash ➔ session created ➔ redirected to role dashboard.
- **Alternate Flow:** Invalid credentials return generic error.

### 9.3 Use Case: Book Appointment
- **Actor:** Patient or Receptionist.
- **Main Flow:** Select doctor, date, time slot ➔ validate input and check doctor availability ➔ appointment stored as `SCHEDULED`.
- **Alternate Flow:** Slot occupied ➔ collision message returned.

### 9.4 Use Case: Clinical Record and Prescription
- **Actor:** Authorized Doctor.
- **Main Flow:** Doctor opens consultation ➔ records diagnosis and notes ➔ writes prescription items ➔ stock deducted ➔ appointment marked `COMPLETED`.

---

## 10. Verification, Acceptance and Traceability

| Requirement Area | IDs | Evidence to Collect |
| :--- | :--- | :--- |
| **Authentication & roles** | FR-01–06; NFR-01–07 | Valid/invalid login, logout, restricted-route tests |
| **Patient / doctor** | FR-07–10 | Create, search, update, validation results |
| **Appointments** | FR-11–14 | Appointment creation, linkage and invalid-input cases |
| **Clinical / pharmacy / lab** | FR-15–22 | Record relationships and permitted-role access |
| **Nursing / admissions** | FR-23–26 | Vital record and admission/room relationship tests |
| **Billing / payments** | FR-27–30 | Totals, payment-to-bill link and invalid values |
| **Feedback / audit / notifications** | FR-31–34 | Submission, user linkage, logs and permissions |

### Test Case Template:
`Test ID | Requirement ID | Preconditions | Test data | Steps | Expected result | Actual result | Pass/Fail | Evidence | Tester/date`

---

## 11. Assumptions, Constraints and Risks
- **Risks:** Incorrect role checks, foreign key inconsistencies, deployment configuration faults, unhandled exceptions.
- **Mitigations:** Server-side filter authorization, parameterized SQL queries, database transactions, synthetic test data.
- **Out of Scope:** Clinical decision algorithms, medical device integrations, insurance clearinghouses, production HIPAA compliance.

---

## 12. Glossary and Conclusion
- **Authentication:** Verifying user identity.
- **Authorization:** Deciding permitted role actions.
- **BCrypt:** Cryptographic salted password hashing.
- **DAO:** Data Access Object.
- **RBAC:** Role-Based Access Control.

**Conclusion:** This SRS establishes the baseline for SmartCare and is verified against the project source code and relational database schema.
