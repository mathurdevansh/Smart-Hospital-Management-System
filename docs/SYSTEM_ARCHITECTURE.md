# System Architecture & Technical Design
## SmartCare — Smart Hospital Management System

> **Course / Program:** Java Web PBL 2026-27  
> **Team Nobita:** Devansh Mathur, Deepak Kumar, Hansraj Pandey, Aryan Daware, Devkinandan Kumawat  
> **Mentor:** Er. Ram Babu Buri  
> **Repository:** [https://github.com/mathurdevansh/Smart-Hospital-Management-System](https://github.com/mathurdevansh/Smart-Hospital-Management-System)

---

## 1. Architectural Overview

SmartCare is structured following the classical **Model-View-Controller (MVC)** architectural pattern adapted for enterprise Jakarta Servlet and JSP applications:

```text
[ Browser / Client ]
         │
         │ HTTP Request (GET / POST)
         ▼
┌─────────────────────────────────────────────────────────────┐
│ 1. Filter Layer (Security & Routing)                        │
│    ├─ AuthenticationFilter (Session Check & Static Exemption)│
│    └─ AuthorizationFilter (Role-Based URL Access Control)   │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. Controller Layer (Jakarta Servlets)                      │
│    ├─ LoginServlet, LogoutServlet, RegisterServlet          │
│    ├─ AdminServlet, DoctorServlet, PatientServlet           │
│    ├─ AppointmentServlet, MedicineServlet, BillingServlet   │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. Service Layer (Business Logic & Transactions)            │
│    ├─ AuthService (Credential Verification & Audit Logging)  │
│    ├─ AppointmentService (Collision Prevention & Slot Rules)│
│    ├─ BillingService (Invoice Calculation & Tax Aggregation)│
│    └─ AdmissionService (Room Allocation & Discharge Engine) │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Data Access Layer (DAOs) & Utilities                     │
│    ├─ UserDAO, PatientDAO, DoctorDAO, AppointmentDAO        │
│    ├─ MedicineDAO, BillingDAO, RoomDAO, VitalDAO            │
│    ├─ DBConnection (Connection Pooling & Resource Cleanup)  │
│    └─ PasswordUtil (jBCrypt Hashing) / ValidationUtil       │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Database Layer (MySQL 8.0)                               │
│    22 Normalized Tables (Aiven Cloud / Local MySQL)         │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Role-Based Access Control (RBAC) Matrix

The system enforces strict boundary isolation using `AuthorizationFilter`:

| Endpoint URL Pattern | Admin | Doctor | Patient | Nurse | Receptionist | Unauthenticated |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| `/login.jsp`, `/login`, `/register.jsp` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/admin/*` (Departments, Users, Audit, Reports) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ (Redirect to Login) |
| `/doctor/*` (Consultation, Diagnosis, Records) | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ (Redirect to Login) |
| `/patient/*` (Bookings, Bills, Prescriptions) | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ (Redirect to Login) |
| `/nurse/*` (Record Vitals, Vitals History) | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ (Redirect to Login) |
| `/receptionist/*` (Counter Booking, Billing) | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ (Redirect to Login) |
| `/common/*` (Inventory, Invoices, Admissions) | ✅ | ✅ | ❌ | ✅ | ✅ | ❌ (Redirect to Login) |

---

## 3. Core Sequence Workflows

### 3.1 Authentication & Session Dispatch Flow
```mermaid
sequenceDiagram
    autonumber
    actor User as Client Browser
    participant Filter as AuthenticationFilter
    participant Servlet as LoginServlet
    participant Service as AuthService
    participant DAO as UserDAO
    participant DB as MySQL Database

    User->>Filter: POST /login (username, password)
    Filter->>Servlet: Pass-through (public auth route)
    Servlet->>Service: authenticate(username, password)
    Service->>DAO: getUserByUsername(username)
    DAO->>DB: SELECT * FROM users WHERE username = ?
    DB-->>DAO: User entity Record
    DAO-->>Service: Return User
    Service->>Service: PasswordUtil.checkPassword(password, hash)
    alt Password Matches
        Service-->>Servlet: Authentication Success
        Servlet->>Servlet: session.setAttribute("user", user)
        Servlet-->>User: HTTP 302 Redirect (/admin/dashboard, /doctor/dashboard, etc.)
    else Invalid Password
        Service-->>Servlet: Authentication Failed
        Servlet-->>User: HTTP 302 Redirect (/login.jsp?error=invalid_credentials)
    end
```

### 3.2 Appointment Booking & Collision Prevention Flow
```mermaid
sequenceDiagram
    autonumber
    actor Patient as Patient / Staff
    participant Servlet as AppointmentServlet
    participant Service as AppointmentService
    participant DAO as AppointmentDAO
    participant DB as MySQL Database

    Patient->>Servlet: POST /appointments/book (doctorId, date, slot)
    Servlet->>Service: validateAndBook(appointment)
    Service->>DAO: isSlotAvailable(doctorId, date, slot)
    DAO->>DB: SELECT COUNT(*) FROM appointments WHERE doctor_id=? AND date=? AND slot=? AND status='SCHEDULED'
    DB-->>DAO: Count result
    alt Slot Available (Count == 0)
        Service->>DAO: insertAppointment(appointment)
        DAO->>DB: INSERT INTO appointments (...)
        DB-->>DAO: Success (Generated ID)
        DAO-->>Service: Appointment Created
        Service-->>Servlet: Success
        Servlet-->>Patient: Redirect /patient/appointments?success=booked
    else Slot Occupied (Count > 0)
        Service-->>Servlet: Collision Error (Slot already taken)
        Servlet-->>Patient: Redirect /patient/book_appointment.jsp?error=slot_conflict
    end
```
