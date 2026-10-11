# Week 12 Progress Report | SmartCare Hospital Management System

**Period:** `21-09-2026 to 27-09-2026`  
**Milestone Theme:** **Deployment (Docker, Render, cloud MySQL) and bug fixing**  
**Project:** Smart Hospital Management System (SmartCare) | Java PBL 2026-27  
**Team:** Team Nobita (`PBL2627-AI&DS-A-031;`)  
**Mentor:** Er. Ram Babu Buri  
**GitHub Report Link:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-12.md](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/reports/week-12.md)  

---

## 📋 Official Portal Submission Fields
> Use the exact content in the three boxes below for copying directly into the College Weekly Report Portal tab.

### Box 1: Work Completed This Week
```text
This week the whole team the application was deployed to the cloud and bugs were fixed. Devansh (Authentication): wrote a Dockerfile (Maven build stage and Tomcat 10.1 run stage); created a cloud MySQL instance and moved the schema to it; updated db.properties for the cloud database with SSL. Deepak (Patient): checked patient and doctor pages on the deployed site; fixed date format issue on the cloud database; added missing seed data for departments and doctors. Hansraj (Appointment): tested booking flow on the live Render site; fixed time zone difference between local and cloud server; corrected status display bug on the appointments list. Aryan (Pharmacy): checked inventory and prescription pages on the live site; fixed foreign key insert order in seed data; corrected date display in the lab details page. Devkinandan (Billing): checked billing, admission and report pages on live site; fixed decimal formatting on the cloud database; corrected a missing room status default in seed data. All members shared their work on GitHub and discussed it in the team and in the Saturday mentor meeting.
```

#### Member-wise Contribution Breakdown
| Member | Module | Work Executed |
| :--- | :--- | :--- |
| **Devansh Mathur** | Module 1 - Authentication, Admin and Security | Wrote a Dockerfile (Maven build stage and Tomcat 10.1 run stage); created a cloud MySQL instance and moved the schema to it; updated db.properties for the cloud database with SSL. |
| **Deepak Kumar** | Module 2 - Patient and Doctor Management | Checked patient and doctor pages on the deployed site; fixed date format issue on the cloud database; added missing seed data for departments and doctors. |
| **Hansraj Pandey** | Module 3 - Appointment and Consultation | Tested booking flow on the live Render site; fixed time zone difference between local and cloud server; corrected status display bug on the appointments list. |
| **Aryan Daware** | Module 4 - Pharmacy, Laboratory and Nursing | Checked inventory and prescription pages on the live site; fixed foreign key insert order in seed data; corrected date display in the lab details page. |
| **Devkinandan Kumawat** | Module 5 - Billing, Admission, Reports and Feedback | Checked billing, admission and report pages on live site; fixed decimal formatting on the cloud database; corrected a missing room status default in seed data. |

### Box 2: Problems Faced
```text
Devansh: Cloud DB SSL connection refused at first. Deepak: Date format differed on cloud MySQL. Hansraj: Time zone differed on cloud server. Aryan: Seed data failed on cloud DB. Devkinandan: Decimal formatting changed on cloud DB. All problems were solved by team discussion and guidance from the mentor.
```

### Box 3: Plan for Next Week
```text
Next week the team will move to: Report, PPT, demo video and viva preparation. Devansh: wrote the introduction and tools sections of the project report. Deepak: wrote the patient and doctor module section of the report. Hansraj: wrote the appointment module section of the report. Aryan: wrote the pharmacy, lab and nursing section of the report. Devkinandan: wrote the billing, admission and reports section of the report.
```

---

## 🔍 Proof of Work & Code Evidence
The table below links every deliverable and task accomplished during this week directly to the corresponding source files, configurations, and documentation committed in this GitHub repository:

| Deliverable / Component | Contributor | Repository File | Direct GitHub Proof Link | Description & Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Multi-Stage Production Dockerfile** | Devansh Mathur | `Dockerfile` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/Dockerfile) | Multi-stage build: Maven 3.9 JDK-17 compilation + Apache Tomcat 10.1 runtime. |
| **Cloud MySQL Properties with SSL** | Devansh Mathur | `src/main/resources/db.properties` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/src/main/resources/db.properties) | Production configuration connected to managed Aiven Cloud MySQL with SSL encryption enabled. |
| **Production Seed Data Script** | All Members | `database/schema.sql` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/database/schema.sql) | Seed database populated with pre-configured departments, doctors, demo logins, and rooms. |
| **Repository .gitignore Rules** | Devansh Mathur | `.gitignore` | [Inspect Source Code](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/.gitignore) | Configured ignore rules for build artifacts, target binaries, and local configuration. |

### Key Milestones Achieved in Week 12
- **Containerized Architecture:** Built Docker container with Maven compilation and Tomcat 10.1 (`Dockerfile`).
- **Cloud Database Provisioned:** Successfully migrated relational schema to managed Aiven Cloud MySQL (`mysql-c582a6f-devanshmathur78-6447.i.aivencloud.com`) with `sslmode=REQUIRED`.
- **Cloud Timezone & SSL Handshake Solved:** Resolved MySQL UTC vs IST timezone disparities and SSL handshake issues in JDBC connection parameters.

---

### Navigation
[⬅️ Week 11](week-11.md) | [📑 All 13 Weeks Overview](README.md) | [Week 13 ➡️](week-13.md)
