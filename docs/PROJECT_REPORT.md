# Final Project Report
## SmartCare — Smart Hospital Management System

> **Academic Program:** Project Based Learning (Java Web PBL 2026-27)  
> **Course:** Java Web Technologies & Enterprise Application Development  
> **Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
> **Project Mentor:** Er. Ram Babu Buri  
> **Repository:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System](https://github.com/mathurdevansh/Smart-Hospital-Management-System)  
> **Submission Date:** October 2026

---

## 1. Executive Summary
SmartCare is a comprehensive hospital information management system designed to streamline clinical, pharmaceutical, diagnostic, and administrative workflows in healthcare facilities. Built using modern Java EE standards (Jakarta Servlet 6.0, JSP, JSTL, MySQL 8.0), SmartCare replaces error-prone paper workflows with an integrated digital environment featuring Role-Based Access Control (RBAC), collision-free scheduling, automated pharmacy inventory synchronization, and unified multi-service patient billing.

---

## 2. Project Team & Contribution Matrix

| Member | Assigned Module | Key Deliverables & Implementation Highlights |
| :--- | :--- | :--- |
| **Devansh Mathur** *(Lead)* | **Module 1: Authentication, Admin & Security** | BCrypt password hashing, session lifecycle, security filters (`AuthenticationFilter`, `AuthorizationFilter`), admin console, department directory, audit logs, Docker containerization. |
| **Deepak Kumar** | **Module 2: Patient & Doctor Management** | Patient registration and profile management, medical record history interfaces, doctor profiles, specializations, directory search. |
| **Hansraj Pandey** | **Module 3: Appointment & Consultation** | Appointment booking engine, doctor availability scheduling, slot collision detection, clinical consultation interface, appointment status lifecycle. |
| **Aryan Daware** | **Module 4: Pharmacy, Laboratory & Nursing** | Pharmaceutical stock catalog, low-stock notifications, multi-row prescription dispensing, lab test tracking, nurse vital signs logging. |
| **Devkinandan Kumawat** | **Module 5: Billing, Admission, Reports & Feedback** | Invoice generation, payment recording, bed allocation, room occupancy management, admission/discharge flows, financial reports. |

---

## 3. Technology Stack & Development Tools

- **Programming Language:** Java 17 (Eclipse Temurin / OpenJDK).
- **Web Technologies:** Jakarta EE 10 / Servlet 6.0, JavaServer Pages (JSP), JSTL 3.0.
- **Database Engine:** MySQL 8.0+ with InnoDB transactional storage.
- **Security & Cryptography:** jBCrypt 0.4 salted password hashing.
- **Build & Dependency Tool:** Apache Maven 3.9+.
- **Containerization & Deployment:** Docker multi-stage build, Apache Tomcat 10.1, Render Cloud, Aiven Cloud MySQL.
- **Version Control:** Git & GitHub (`mathurdevansh/Smart-Hospital-Management-System`).

---

## 4. Database Design (22 Relational Tables)

The database schema (`database/schema.sql`) encompasses 22 normalized relational tables:
1. `roles`: Master table for system roles (`ADMIN`, `DOCTOR`, `PATIENT`, `NURSE`, `RECEPTIONIST`).
2. `departments`: Hospital clinical departments (Cardiology, Orthopedics, Pediatrics, etc.).
3. `users`: Master authentication credentials and role mappings.
4. `doctors`: Medical credentials, department links, fees, and qualification notes.
5. `patients`: Demographics, blood group, emergency contact details, and registered timestamps.
6. `nurses`: Nursing staff profile and departmental assignments.
7. `receptionists`: Front-desk operational staff records.
8. `rooms`: Room numbers, room types (`GENERAL`, `ICU`, `SEMI_PRIVATE`), daily charges, and occupancy status.
9. `admissions`: Patient admission, bed allocation, admit date, discharge date, and status.
10. `appointments`: Scheduled consultations, doctor IDs, date, time slot, and status.
11. `medical_records`: Clinical diagnoses, treatment notes, and physician notes.
12. `medicines`: Pharmaceutical catalog, dosage forms, manufacturer, and unit prices.
13. `medicine_inventory`: Batch tracking, stock balances, and expiration tracking.
14. `prescriptions`: Consultation prescription headers.
15. `prescription_items`: Individual medicine lines, dosage, frequency, and duration.
16. `lab_tests`: Diagnostic laboratory orders and status (`REQUESTED`, `COMPLETED`).
17. `billing`: Consolidated invoices with subtotal, tax amounts, and discount calculations.
18. `payments`: Payment transaction records, payment methods, and transaction references.
19. `patient_vitals`: Nursing physiological readings (BP, pulse, SpO2, temp).
20. `feedback`: Patient ratings, doctor feedback, and service reviews.
21. `audit_logs`: Timestamped administrative system change events.
22. `notifications`: System notifications for upcoming visits, lab alerts, and bills.

---

## 5. Testing and Quality Assurance

The application underwent rigorous multi-stage testing throughout Week 11:

| Test Category | Test Case ID | Test Scenario | Expected Outcome | Status |
| :--- | :--- | :--- | :--- | :---: |
| **Security** | TC-SEC-01 | Unauthenticated user opens `/admin/dashboard` | Redirected to `/login.jsp?error=login_required` | ✅ PASS |
| **Security** | TC-SEC-02 | Patient user attempts to access `/doctor/consultation.jsp` | Access Denied HTTP 403 Forbidden | ✅ PASS |
| **Scheduling** | TC-APP-01 | Two patients attempt to book same doctor at same slot | First booking succeeds; second booking returns conflict warning | ✅ PASS |
| **Pharmacy** | TC-PHR-01 | Prescription created with 5 units of Amoxicillin | Inventory stock drops by exactly 5 units | ✅ PASS |
| **Pharmacy** | TC-PHR-02 | Attempting to dispense more stock than available | Error thrown; transaction rolls back; stock unchanged | ✅ PASS |
| **Financial** | TC-BIL-01 | Invoice generated with doctor fee, lab test, and medicine | Correct sum calculated with tax applied; payment logged | ✅ PASS |
| **Boundary** | TC-VAL-01 | Patient registration with invalid 8-digit phone number | ValidationUtil rejects input with user alert | ✅ PASS |

---

## 6. Deployment & Cloud Hosting

As finalized in Week 12:
1. **Docker Containerization:** A multi-stage `Dockerfile` handles Maven compilation of the source files into `SmartCareHospital.war` and serves it on Apache Tomcat 10.1.
2. **Cloud Database:** Hosted on Aiven Managed Cloud MySQL over an SSL-encrypted TLS connection.
3. **Application Hosting:** Configured for cloud hosting with instant restart and health check probes.

---

## 7. Conclusion & Future Scope

SmartCare successfully demonstrates an end-to-end hospital operational system meeting all academic and functional requirements.
Future enhancements planned include:
- Integrated tele-consultation video streaming.
- SMS and WhatsApp appointment reminders.
- Machine-learning driven bed occupancy forecasting.
