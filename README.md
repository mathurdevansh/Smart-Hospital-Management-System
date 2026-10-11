# SmartCare — Smart Hospital Management System 🏥

[![Java](https://img.shields.io/badge/Java-17%2B-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10%20(Servlet%206.0)-EE0000?style=for-the-badge&logo=eclipse-ide&logoColor=white)](https://jakarta.ee/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-10.1-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)](https://tomcat.apache.org/)
[![Cloud DB](https://img.shields.io/badge/Aiven%20Cloud-MySQL%20SSL-FF4D4D?style=for-the-badge&logo=aiven&logoColor=white)](https://aiven.io/)

> **Academic Program:** Project Based Learning (Java Web PBL 2026-27)  
> **Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
> **Mentor:** Er. Ram Babu Buri  
> **Repository:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System](https://github.com/mathurdevansh/Smart-Hospital-Management-System)  
> **Reports Hub:** [Detailed 13-Week Reports Directory](reports/README.md)

---

## 📖 Project Overview

**SmartCare** is an enterprise-grade, web-based Hospital Management System (HMS) developed using Jakarta Servlet 6.0, JavaServer Pages (JSP), JSTL, and MySQL. It digitizes hospital operations by eliminating paperwork, preventing booking collisions, enforcing granular Role-Based Access Control (RBAC), and connecting patients, doctors, nurses, pharmacists, and administrative staff into a single workflow.

### Key Objectives
1. **Role-Based Security:** Five dedicated actor roles (**Admin**, **Doctor**, **Patient**, **Nurse**, **Receptionist**) secured via BCrypt password hashing and HTTP servlet filters.
2. **Clinical Workflows:** Seamless flow from appointment booking to doctor consultation, electronic prescription generation, and diagnostic lab requests.
3. **Operational Automation:** Automatic deduction of pharmacy stock upon prescription issuance, real-time room occupancy tracking, and multi-service billing calculations.
4. **Cloud & Container Ready:** Packaged into a self-contained multi-stage Docker container deployed on cloud infrastructure with SSL-secured database pooling.

---

## 👥 Team Members & Module Distribution

SmartCare was designed and implemented by a collaborative team of five engineers, each owning a core functional module:

| Member | Assigned Module | Key Features & Responsibilities | Source Proof Link |
| :--- | :--- | :--- | :--- |
| **Devansh Mathur** *(Team Lead)* | **Module 1: Authentication, Admin & Security** | User authentication, BCrypt hashing, session tracking, RBAC filters (`AuthenticationFilter`, `AuthorizationFilter`), Admin dashboard, department directory, audit logs. | [`com.smarthospital.controller.AdminServlet`](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/AdminServlet.java) |
| **Deepak Kumar** | **Module 2: Patient & Doctor Management** | Patient onboarding, profile management, medical record histories, doctor directory, qualification records, patient search filters. | [`com.smarthospital.controller.PatientServlet`](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/PatientServlet.java) |
| **Hansraj Pandey** | **Module 3: Appointment & Consultation** | Appointment booking engine, doctor availability scheduling, double-booking prevention, clinical consultation notes, status lifecycle. | [`com.smarthospital.service.AppointmentService`](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/service/AppointmentService.java) |
| **Aryan Daware** | **Module 4: Pharmacy, Laboratory & Nursing** | Pharmaceutical stock inventory, low-stock warnings, multi-item prescription handling, lab test requests/results, patient vitals recording. | [`com.smarthospital.controller.MedicineServlet`](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/MedicineServlet.java) |
| **Devkinandan Kumawat** | **Module 5: Billing, Admission, Reports & Feedback** | Invoice generation, payments tracking, bed allocation & room occupancy, patient admission/discharge, financial analytics, feedback. | [`com.smarthospital.service.BillingService`](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/service/BillingService.java) |

---

## 🗓️ 13-Week Project Timeline & Proof of Work

Every week's progress is formally logged with full mentor-reviewed notes and direct links to code evidence:

| Week | Date Range | Phase / Topic | Report Markdown | Direct GitHub Proof Link |
| :---: | :--- | :--- | :---: | :--- |
| **Week 1** | `06-07-2026 to 12-07-2026` | Team formation, guide selection & abstract | [Week 1 Report](reports/week-01.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-01.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-01.md) |
| **Week 2** | `13-07-2026 to 19-07-2026` | SRS (Software Requirement Specification) | [Week 2 Report](reports/week-02.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-02.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-02.md) |
| **Week 3** | `20-07-2026 to 26-07-2026` | UML design (use-case, class, sequence) | [Week 3 Report](reports/week-03.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-03.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-03.md) |
| **Week 4** | `27-07-2026 to 02-08-2026` | Database (ER) design, UI mock-ups, project setup | [Week 4 Report](reports/week-04.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-04.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-04.md) |
| **Week 5** | `03-08-2026 to 09-08-2026` | Module coding - models and DAO layer | [Week 5 Report](reports/week-05.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-05.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-05.md) |
| **Week 6** | `10-08-2026 to 16-08-2026` | Module coding - services and servlets | [Week 6 Report](reports/week-06.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-06.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-06.md) |
| **Week 7** | `17-08-2026 to 23-08-2026` | Module coding - JSP views and UI | [Week 7 Report](reports/week-07.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-07.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-07.md) |
| **Week 8** | `24-08-2026 to 30-08-2026` | Module coding - validation, exceptions, security | [Week 8 Report](reports/week-08.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-08.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-08.md) |
| **Week 9** | `31-08-2026 to 06-09-2026` | Module coding - module completion & self-review | [Week 9 Report](reports/week-09.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-09.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-09.md) |
| **Week 10** | `07-09-2026 to 13-09-2026` | Integration of all five modules | [Week 10 Report](reports/week-10.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-10.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-10.md) |
| **Week 11** | `14-09-2026 to 20-09-2026` | Testing (unit, functional, role-based) | [Week 11 Report](reports/week-11.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-11.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-11.md) |
| **Week 12** | `21-09-2026 to 27-09-2026` | Deployment (Docker, Render, cloud MySQL) | [Week 12 Report](reports/week-12.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-12.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-12.md) |
| **Week 13** | `28-09-2026 to 04-10-2026` | Report, PPT, demo video & viva preparation | [Week 13 Report](reports/week-13.md) | [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-13.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-13.md) |

> 📑 **Master Reports Hub:** Visit [reports/README.md](reports/README.md) for the complete consolidated weekly reports dashboard.

---

## 🏛️ System Architecture

```text
[ Client Browser ]
        │
        ▼ (HTTP / HTTPS)
┌────────────────────────────────────────────────────────┐
│ Apache Tomcat 10.1 (Servlet Container)                 │
│                                                        │
│  ┌──────────────────────────────────────────────────┐  │
│  │ Security & Filters                               │  │
│  │  ├─ AuthenticationFilter                         │  │
│  │  └─ AuthorizationFilter (RBAC)                   │  │
│  └────────────────────────┬─────────────────────────┘  │
│                           ▼                            │
│  ┌──────────────────────────────────────────────────┐  │
│  │ Controllers (Jakarta Servlets)                   │  │
│  │  LoginServlet, PatientServlet, DoctorServlet,    │  │
│  │  AppointmentServlet, MedicineServlet, Billing... │  │
│  └────────────────────────┬─────────────────────────┘  │
│                           ▼                            │
│  ┌──────────────────────────────────────────────────┐  │
│  │ Business Services & Security Utilities           │  │
│  │  AuthService, AppointmentService, BillingService,│  │
│  │  AdmissionService, PasswordUtil (jBCrypt)        │  │
│  └────────────────────────┬─────────────────────────┘  │
│                           ▼                            │
│  ┌──────────────────────────────────────────────────┐  │
│  │ Data Access Layer (DAOs)                         │  │
│  │  UserDAO, PatientDAO, DoctorDAO, AppointmentDAO, │  │
│  │  MedicineDAO, BillingDAO, RoomDAO, VitalDAO...   │  │
│  └────────────────────────┬─────────────────────────┘  │
│                           ▼                            │
│  ┌──────────────────────────────────────────────────┐  │
│  │ Presentation Layer (JSP 3.0 / JSTL / CSS3)       │  │
│  │  /admin/*, /doctor/*, /patient/*, /nurse/*,      │  │
│  │  /receptionist/*, /common/*                      │  │
│  └──────────────────────────────────────────────────┘  │
└───────────────────────────┬────────────────────────────┘
                            │ (JDBC over TLS / SSL)
                            ▼
┌────────────────────────────────────────────────────────┐
│ MySQL 8.0 Database (Aiven Cloud / Local MySQL)         │
│ 22 Normalized Tables (roles, users, doctors,           │
│ appointments, prescriptions, billing, rooms...)        │
└────────────────────────────────────────────────────────┘
```

---

## 🗄️ Relational Database Schema (22 Tables)

The database schema is defined in [`database/schema.sql`](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/database/schema.sql) and structured into normalized functional domains:

1. **Authentication & Core Administration:** `roles`, `departments`, `users`, `audit_logs`, `notifications`.
2. **Staff & Patient Directory:** `doctors`, `patients`, `nurses`, `receptionists`.
3. **Clinical Operations:** `appointments`, `medical_records`.
4. **Pharmacy & Diagnostics:** `medicines`, `medicine_inventory`, `prescriptions`, `prescription_items`, `lab_tests`, `patient_vitals`.
5. **Hospitalization & Financials:** `rooms`, `admissions`, `billing`, `payments`, `feedback`.

---

## 🚀 Getting Started & Local Setup

### Prerequisites
- **Java Development Kit (JDK 17 or higher)**
- **Apache Maven (3.8+)**
- **MySQL Server (8.0+)** OR Cloud MySQL connection
- **Apache Tomcat 10.1** (or run via Docker)

### 1. Clone the Repository
```bash
git clone https://github.com/mathurdevansh/Smart-Hospital-Management-System.git
cd Smart-Hospital-Management-System
```

### 2. Configure Database
Import the schema into your MySQL instance:
```bash
mysql -u root -p < database/schema.sql
```
Update [`src/main/resources/db.properties`](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/resources/db.properties) with your database credentials:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/smart_hospital?useSSL=false&allowPublicKeyRetrieval=true
db.user=root
db.password=your_mysql_password
```

### 3. Build WAR Package
```bash
mvn clean package
```
This generates `target/SmartCareHospital.war`.

### 4. Run with Docker (Recommended)
```bash
docker build -t smartcare-hospital .
docker run -p 8080:8080 smartcare-hospital
```
Open your browser and navigate to: **`http://localhost:8080`**

---

## 🔑 Demo Test Accounts

The seed database pre-configures test credentials for all five system roles:

| Role | Username | Password | Access URL | Primary Capabilities |
| :--- | :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `admin123` | `/admin/dashboard` | Manage departments, doctor assignments, users, audit logs |
| **Doctor** | `doctor` | `doctor123` | `/doctor/dashboard` | View scheduled visits, write consultation notes & prescriptions |
| **Patient** | `patient` | `patient123` | `/patient/dashboard` | Book appointments, view medical records, prescriptions, pay bills |
| **Nurse** | `nurse` | `nurse123` | `/nurse/dashboard` | Record patient vitals, monitor inpatients, review vitals history |
| **Receptionist** | `receptionist` | `reception123` | `/receptionist/dashboard` | Patient registration, counter booking, admit/discharge, invoice generation |

---

## 📚 Project Documentation & Artifacts

- 📄 [Master Weekly Reports Directory (Weeks 1 to 13)](reports/README.md)
- 📄 [Software Requirements Specification (SRS)](docs/SRS.md)
- 📄 [Comprehensive Final Project Report](docs/PROJECT_REPORT.md)
- 📄 [System Architecture & UML Design](docs/SYSTEM_ARCHITECTURE.md)
- 📂 [Archived Official Signed PDF Reports](docs/reports/)

---

## 📄 License & Academic Integrity
Developed as part of the **Java Web PBL (2026-27)** curriculum under the guidance of **Er. Ram Babu Buri**.  
All rights reserved by **Team Nobita (PBL2627-AI&DS-A-031;)**.
