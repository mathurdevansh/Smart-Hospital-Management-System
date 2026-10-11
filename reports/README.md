# 📑 SmartCare Combined Team Weekly Reports (Weeks 1 – 13)

> **Course / Program:** Java Web PBL 2026-27  
> **Project:** Smart Hospital Management System (SmartCare)  
> **Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
> **Mentor:** Er. Ram Babu Buri  
> **Repository:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System](https://github.com/mathurdevansh/Smart-Hospital-Management-System)  
> **Reporting Duration:** 13 Weeks (`06-07-2026` to `04-10-2026`)

---

## 👥 Team Members & Module Distribution

| Member | Roll / ID | Assigned Module | Scope & Responsibilities |
| :--- | :--- | :--- | :--- |
| **Devansh Mathur** | Lead | **Module 1** - Authentication, Admin & Security | User auth, BCrypt hashing, RBAC filters, Admin dashboard, Audit logs |
| **Deepak Kumar** | Member | **Module 2** - Patient & Doctor Management | Patient onboarding, profile management, doctor directories, medical history |
| **Hansraj Pandey** | Member | **Module 3** - Appointment & Consultation | Slot scheduling, collision prevention, doctor consultation, status flows |
| **Aryan Daware** | Member | **Module 4** - Pharmacy, Laboratory & Nursing | Medicine inventory, automatic stock deduction, lab tests, vital signs |
| **Devkinandan Kumawat** | Member | **Module 5** - Billing, Admission, Reports & Feedback | Invoicing, payments, bed allocation, admission/discharge, revenue reports |

---

## 🗓️ Weekly Reports Directory & Direct Proof Links

Below is the master navigation index. For each week, you can click on the **Weekly Report Link** to view the full report or copy the **Direct GitHub Link** for submission in the College PBL Portal.

| Week | Date Range | Phase / Topic | Weekly Report Link | Direct GitHub Link for Portal | Primary Deliverables & Code Proof |
| :---: | :--- | :--- | :---: | :--- | :--- |
| **Week 1** | `06-07-2026 to 12-07-2026` | Team formation, guide selection & abstract | [📄 Week 1](week-01.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-01.md` | [Abstract & Vision](../README.md), [Architecture Plan](../docs/SYSTEM_ARCHITECTURE.md) |
| **Week 2** | `13-07-2026 to 19-07-2026` | SRS (Software Requirement Specification) | [📄 Week 2](week-02.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-02.md` | [SRS Document](../docs/SRS.md), [RBAC Matrix](../docs/SYSTEM_ARCHITECTURE.md#role-based-access-control-matrix) |
| **Week 3** | `20-07-2026 to 26-07-2026` | UML design (use-case, class, sequence) | [📄 Week 3](week-03.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-03.md` | [UML Diagrams](../docs/SYSTEM_ARCHITECTURE.md), [Model Specs](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/model/) |
| **Week 4** | `27-07-2026 to 02-08-2026` | Database (ER) design, UI mock-ups, setup | [📄 Week 4](week-04.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-04.md` | [schema.sql (22 Tables)](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/database/schema.sql), [pom.xml](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/pom.xml), [web.xml](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/WEB-INF/web.xml) |
| **Week 5** | `03-08-2026 to 09-08-2026` | Module coding - models and DAO layer | [📄 Week 5](week-05.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-05.md` | [DBConnection.java](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/util/DBConnection.java), [DAOs](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/dao/), [Models](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/model/) |
| **Week 6** | `10-08-2026 to 16-08-2026` | Module coding - services and servlets | [📄 Week 6](week-06.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-06.md` | [PasswordUtil.java](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/util/PasswordUtil.java), [Services](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/service/), [Servlets](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/) |
| **Week 7** | `17-08-2026 to 23-08-2026` | Module coding - JSP views and UI | [📄 Week 7](week-07.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-07.md` | [style.css](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/css/style.css), [Dashboards](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/admin/dashboard.jsp), [Invoices](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/common/invoice.jsp) |
| **Week 8** | `24-08-2026 to 30-08-2026` | Module coding - validation, exceptions, security | [📄 Week 8](week-08.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-08.md` | [AuthenticationFilter.java](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/filter/AuthenticationFilter.java), [ValidationUtil.java](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/util/ValidationUtil.java), [main.js](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/js/main.js) |
| **Week 9** | `31-08-2026 to 06-09-2026` | Module coding - module completion & self-review | [📄 Week 9](week-09.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-09.md` | [AdminServlet.java](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/AdminServlet.java), [records.jsp](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/doctor/records.jsp), [reports.jsp](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/admin/reports.jsp) |
| **Week 10** | `07-09-2026 to 13-09-2026` | Integration of all five modules | [📄 Week 10](week-10.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-10.md` | [Integrated web.xml](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/WEB-INF/web.xml), [RegisterServlet.java](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/java/com/smarthospital/controller/RegisterServlet.java), [lab_reports.jsp](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/doctor/lab_reports.jsp) |
| **Week 11** | `14-09-2026 to 20-09-2026` | Testing (unit, functional, role-based) | [📄 Week 11](week-11.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-11.md` | [403.jsp](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/errors/403.jsp), [404.jsp](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/errors/404.jsp), [500.jsp](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/webapp/errors/500.jsp), [Test Cases Matrix](../docs/PROJECT_REPORT.md#testing-and-quality-assurance) |
| **Week 12** | `21-09-2026 to 27-09-2026` | Deployment (Docker, Render, cloud MySQL) | [📄 Week 12](week-12.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-12.md` | [Dockerfile](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/Dockerfile), [db.properties (SSL)](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/resources/db.properties), [Seed Database](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/database/schema.sql) |
| **Week 13** | `28-09-2026 to 04-10-2026` | Report, PPT, demo video & viva preparation | [📄 Week 13](week-13.md) | `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-13.md` | [PROJECT_REPORT.md](../docs/PROJECT_REPORT.md), [SRS.md](../docs/SRS.md), [Architecture](../docs/SYSTEM_ARCHITECTURE.md) |

---

## 📌 Instructions for College Portal Submission

1. **Select Week:** In your college PBL portal dropdown, choose the corresponding week (`Week 1` through `Week 13`).
2. **Copy Box 1:** Open the specific markdown report (e.g. [week-01.md](week-01.md)) and copy the text inside **Box 1: Work Completed This Week** into the portal.
3. **Copy Box 2:** Copy the text inside **Box 2: Problems Faced** into the portal.
4. **Copy Box 3:** Copy the text inside **Box 3: Plan for Next Week** into the portal.
5. **Paste GitHub Proof Link:** Paste the specific week's permalink (e.g., `https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-01.md`) or the master repository link `https://github.com/mathurdevansh/Smart-Hospital-Management-System`.

---

## 📂 Downloadable Official Report PDFs

All officially submitted and mentor-reviewed PDF report documents are stored in the repository under [`docs/reports/`](../docs/reports/):

- 📄 [Combined Team Weekly Reports (All 5 Members)](../docs/reports/6_Combined_Team_Weekly_Reports.pdf)
- 📄 [Consolidated Daily & Weekly Reports](../docs/reports/Consolidated_Daily_and_Weekly_Reports.pdf)
- 📄 [1. Devansh Mathur - Daily & Weekly Reports](../docs/reports/1_Devansh_Daily_and_Weekly_Reports.pdf)
- 📄 [2. Deepak Kumar - Daily & Weekly Reports](../docs/reports/2_Deepak_Daily_and_Weekly_Reports.pdf)
- 📄 [3. Hansraj Pandey - Daily & Weekly Reports](../docs/reports/3_Hansraj_Daily_and_Weekly_Reports.pdf)
- 📄 [4. Aryan Daware - Daily & Weekly Reports](../docs/reports/4_Aryan_Daily_and_Weekly_Reports.pdf)
- 📄 [5. Devkinandan Kumawat - Daily & Weekly Reports](../docs/reports/5_Devkinandan_Daily_and_Weekly_Reports.pdf)
