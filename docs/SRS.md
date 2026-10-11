# Software Requirements Specification (SRS)
## SmartCare — Smart Hospital Management System

> **Project Code:** PBL2627-AI&DS-A-031;  
> **Academic Session:** Java Web PBL 2026-27  
> **Team Nobita:** Devansh Mathur, Deepak Kumar, Hansraj Pandey, Aryan Daware, Devkinandan Kumawat  
> **Project Mentor:** Er. Ram Babu Buri  
> **Repository:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System](https://github.com/mathurdevansh/Smart-Hospital-Management-System)  
> **Status:** Final Approved Specification (Week 2 Milestone)

---

## 1. Introduction

### 1.1 Purpose
The purpose of this Software Requirements Specification (SRS) is to provide a complete, detailed specification of the requirements for the **SmartCare Hospital Management System (HMS)**. This document specifies the functional requirements, operational workflows, system actors, external interfaces, and non-functional constraints for all five core modules.

### 1.2 Scope of the System
SmartCare is an enterprise web-based healthcare operations platform developed using Java Enterprise (Jakarta Servlet 6.0), JSP, JSTL, and MySQL. It digitizes hospital operations across five key functional modules:
1. **Module 1: Authentication, Admin and Security** (Devansh Mathur)
2. **Module 2: Patient and Doctor Management** (Deepak Kumar)
3. **Module 3: Appointment and Consultation** (Hansraj Pandey)
4. **Module 4: Pharmacy, Laboratory and Nursing** (Aryan Daware)
5. **Module 5: Billing, Admission, Reports and Feedback** (Devkinandan Kumawat)

---

## 2. Overall Description

### 2.1 User Classes and Characteristics
The system identifies five distinct primary actors, each with customized privilege boundaries:

| Actor | Profile Description | Key Functional Responsibilities |
| :--- | :--- | :--- |
| **Admin** | System and hospital operational administrator | User account provisioning, role assignment, department directory, audit trail review, financial reporting. |
| **Doctor** | Licensed medical practitioner | Daily appointment schedule, patient consultation, clinical history review, electronic prescription writing, lab test orders. |
| **Patient** | Hospital patient / care recipient | Self-registration, profile maintenance, appointment scheduling, personal prescriptions, lab results, invoice payments. |
| **Nurse** | Registered clinical nurse | Patient vitals capture (BP, temperature, pulse, SpO2), vitals history logging, inpatient assistance. |
| **Receptionist** | Front-desk hospital staff | Counter patient registration, in-person appointment booking, bed/room allocation, admission/discharge, bill generation. |

### 2.2 Operating Environment
- **Server Platform:** Apache Tomcat 10.1 (Jakarta EE 10 / Servlet 6.0 runtime).
- **Execution Environment:** Java Runtime Environment (JRE 17+), Docker Engine.
- **Database Engine:** MySQL 8.0+ (InnoDB engine, UTF-8 unicode encoding, SSL encryption).
- **Client Interfaces:** Any standards-compliant modern web browser (Chrome, Firefox, Safari, Edge).

---

## 3. System Features & Functional Requirements

### 3.1 Module 1: Authentication, Admin & Security (Devansh Mathur)
- **FR 1.1 Secure Authentication:** The system shall authenticate users via username and password, validating hashes using BCrypt with salt (`PasswordUtil.java`).
- **FR 1.2 Role-Based Routing:** Upon successful authentication, the system shall redirect users to their role-designated dashboard (`/admin/dashboard`, `/doctor/dashboard`, etc.).
- **FR 1.3 Session Management:** Inactive user sessions shall automatically terminate after 30 minutes of inactivity.
- **FR 1.4 Route Interception:** `AuthenticationFilter` and `AuthorizationFilter` shall block unauthorized or unauthenticated requests to protected endpoints.
- **FR 1.5 Account Administration:** The administrator shall have capabilities to activate, deactivate, update roles, and create accounts.
- **FR 1.6 Immutable Audit Logs:** All critical administrative operations (user provisioning, role modifications) shall be logged with timestamps, IP address, and actor ID in the `audit_logs` table.

### 3.2 Module 2: Patient & Doctor Management (Deepak Kumar)
- **FR 2.1 Patient Registration:** The system shall support both patient self-registration and receptionist counter registration.
- **FR 2.2 Patient Unique ID:** Every patient shall receive an automatically assigned unique patient identifier (`patient_id`).
- **FR 2.3 Medical History:** Doctors and patients shall be able to view chronologically ordered medical records and past consultation histories.
- **FR 2.4 Doctor Profiles:** The system shall manage doctor profiles including medical specialization, qualifications, and department affiliations.
- **FR 2.5 Directory Search:** Staff and patients shall be able to search doctors by name, department, or specialization.

### 3.3 Module 3: Appointment & Consultation (Hansraj Pandey)
- **FR 3.1 Slot Booking:** Patients and receptionists shall be able to book appointments selecting doctor, date, and available time slot.
- **FR 3.2 Double-Booking Guard:** The system shall strictly prevent duplicate bookings for the same doctor at the same date and time slot (`AppointmentService.java`).
- **FR 3.3 Status Transitions:** Appointments shall support states: `SCHEDULED`, `COMPLETED`, and `CANCELLED`.
- **FR 3.4 Consultation Recording:** Doctors shall record patient symptoms, clinical diagnosis, and advice directly into the consultation view.
- **FR 3.5 Automated Record Creation:** Submitting consultation notes shall automatically generate a linked `medical_records` entry and mark the appointment `COMPLETED`.

### 3.4 Module 4: Pharmacy, Laboratory & Nursing (Aryan Daware)
- **FR 4.1 Medicine Catalog & Inventory:** The pharmacy module shall manage medicine inventory, including unit prices, batches, and current stock count.
- **FR 4.2 Electronic Prescriptions:** Doctors shall prescribe multiple medicine items with dosage, frequency, and duration.
- **FR 4.3 Automated Stock Deduction:** Prescribing or dispensing medicines shall atomically deduct the respective quantity from `medicine_inventory`.
- **FR 4.4 Diagnostic Test Requests:** Doctors shall be able to order diagnostic lab tests (Blood Test, X-Ray, MRI, etc.).
- **FR 4.5 Lab Result Upload:** Laboratory staff shall update test status from `REQUESTED` to `COMPLETED` and input diagnosis findings.
- **FR 4.6 Nursing Vitals Logging:** Nurses shall capture vital measurements (body temperature, pulse, blood pressure, respiratory rate, SpO2).

### 3.5 Module 5: Billing, Admission, Reports & Feedback (Devkinandan Kumawat)
- **FR 5.1 Multi-Service Invoicing:** The billing engine shall consolidate consultation charges, pharmacy items, lab tests, and room stay charges.
- **FR 5.2 Payment Tracking:** The system shall record payments (Cash, Card, UPI, Net Banking) and prevent overpayment beyond total due.
- **FR 5.3 Room & Bed Allocation:** Receptionists shall assign rooms (`GENERAL`, `SEMI_PRIVATE`, `ICU`) with automatic occupancy state updates.
- **FR 5.4 Patient Admission & Discharge:** Manage admission and release workflows with daily room rate calculations.
- **FR 5.5 Hospital Operational Reporting:** Administrators shall view aggregated analytics: monthly revenue, patient footfall, and bed occupancy.
- **FR 5.6 Patient Feedback:** Discharged patients shall have the ability to submit ratings and feedback.

---

## 4. Non-Functional Requirements

### 4.1 Security Requirements
- All passwords stored using one-way BCrypt cryptographic hashing.
- All SQL database interactions implemented through `java.sql.PreparedStatement` to prevent SQL injection.
- Session hijacking mitigation via servlet session regeneration and HTTPOnly cookies.

### 4.2 Performance Requirements
- Server response times under 500ms for typical database read/write queries.
- Database connection pooling configured to support up to 20 concurrent connections without resource leaks.

### 4.3 Reliability & Availability
- Transactional atomicity: multi-item prescription saves and billing payments utilize SQL transactions with automatic rollback on exception.
- Standard HTTP error handlers (403 Forbidden, 404 Not Found, 500 Server Error) prevent leaking sensitive stack traces.
