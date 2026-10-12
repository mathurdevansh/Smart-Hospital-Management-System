# Research Review: Smart Hospital Management System
## A Literature Review of Hospital Information Systems, Security, Usability and Digital Workflow Management

> **Institution:** Arya College of Engineering & I.T., Jaipur  
> **Department:** Department of Artificial Intelligence & Data Science  
> **Affiliation:** Rajasthan Technical University, Kota (Raj.)  
> **Academic Session:** 2026–27  
> **Course:** Project Based Learning (Java Web PBL)  
> **Project Guide:** Er. Ram Babu Buri  
> **Head of Department:** Dr. Ashok Kumar Kajla  
> **Submitted By:** Team Nobita  
> - **Devansh Mathur** (RTU Roll No: `24EARAD040` / `24E1ARADM40P040`)  
> - **Deepak Kumar** (RTU Roll No: `24EARAD035` / `24E1ARADM30P035`)  
> - **Hansraj Pandey** (RTU Roll No: `24EARAD055` / `24E1ARADM40P055`)  
> - **Aryan Daware** (RTU Roll No: `24EARAD020` / `24E1ARADM30P020`)  
> - **Devkinandan Kumawat** (RTU Roll No: `24EARAD042` / `24E1ARADM30P042`)  
> 
> 📄 **Official PDF Document:** [Download Original Research Review PDF](https://github.com/mathurdevansh/Smart-Hospital-Management-System/blob/main/docs/Smart_Hospital_Management_System_Research_Review.pdf)

---

## Abstract

Hospital Information Systems (HIS) support the administrative and information-management activities of modern hospitals. Their purpose is not limited to storing patient records; they can also coordinate appointments, staff, pharmacy, laboratory work, billing, admissions, reporting and communication. However, a hospital system is useful only when its information is accurate, its workflows are understandable, access is controlled and the software remains dependable during routine use. This review examines published research on hospital information-system evaluation, technical requirements and electronic-record usability, and connects those findings to the design of **SmartCare**, a student-developed Smart Hospital Management System.

The reviewed literature shows that HIS evaluation is multidimensional. Khorasani et al. (2026) grouped evaluation indicators into human, technological, informational, organizational, legal and patient-safety domains. Farzandipour et al. (2020) proposed a technical-requirements framework covering communication services, system architecture, security and response time. Wronikowska et al. (2021) found variation in the usability methods and metrics used to evaluate hospital electronic-record systems. Together, these studies suggest that a system should be evaluated through both technical checks and user-centred workflow testing.

This document is a literature review prepared to support the academic project; it is not an original clinical study or a peer-reviewed research article. It does not claim that SmartCare has been clinically validated. The project-specific discussion translates published findings into design considerations and a proposed evaluation plan. Actual performance, security and usability results must be established through documented testing.

**Keywords:** Hospital Information System, Smart Hospital Management System, Electronic Health Records, Usability, Data Security, Appointment Management, Interoperability, Java, MySQL.

---

## Document Structure
The review is organised into background and objectives, literature-search approach, thematic analysis of research, relevance to SmartCare, a proposed test and evaluation framework, limitations, conclusion and references. Published findings are distinguished from recommendations made for the student project.

---

## 1. Introduction

Hospitals handle many related processes at the same time. Patient registration, appointment scheduling, consultation, diagnostic testing, medicine dispensing, admission, billing and discharge may involve different departments and staff members. When these activities are recorded in disconnected files or paper registers, staff can face duplicated entry, delays in locating information, inconsistent records and difficulty preparing management reports. A Hospital Information System aims to organise such information and support coordinated workflows.

A digital system does not automatically guarantee better care. Poorly designed screens can slow users down; weak access controls can expose sensitive information; inconsistent data can create confusion; and unreliable integrations can prevent departments from sharing updates. Therefore, evaluation should consider more than whether a page opens or a form saves. It should examine the accuracy, security, usability, reliability and organisational fit of the system.

SmartCare is considered in this report as a software engineering project that brings several common hospital-administration modules into one application. Its described technology stack includes Java 17, Jakarta Servlet/JSP, JDBC, MySQL, Maven WAR packaging, BCrypt and Docker. The module scope includes authentication and administration, patient and doctor records, appointments and consultation, pharmacy, laboratory, nursing, billing, admissions, reports and feedback. These project details define the context for applying research findings; they are not evidence that each workflow has passed independent testing.

### Objectives of the Review:
1. Summarise research findings that are relevant to hospital information-system quality.
2. Identify design and evaluation considerations for SmartCare, particularly usability, security, data quality and integration.
3. Propose a practical testing framework that can be used to assess the project without claiming unmeasured outcomes.

**Central Question:** *Which quality factors from published HIS research should guide the design and evaluation of a student-developed Smart Hospital Management System?*

---

## 2. Background and Concepts

### 2.1 Hospital Information Systems
An HIS is an organised combination of software, hardware, data, users and operating procedures used to manage hospital information. It may support clinical records, administration, finance, pharmacy, laboratory services, scheduling and reporting. The exact boundaries differ between hospitals: one organisation may use a single integrated platform, while another may connect several specialised applications.

### 2.2 Electronic Health Records and Administrative Records
Electronic health records (EHRs) organise information related to an individual’s care over time. Administrative records support activities such as registration, appointment allocation, admission and billing. These information types are related but should not be treated as identical. Access to clinical information should be appropriate to a user's responsibilities, and administrative access should not automatically imply unrestricted access to every clinical detail.

### 2.3 Workflow Integration
Integration means that related steps and data remain consistent across modules. For example, an appointment may refer to a registered patient and a doctor; a consultation may be associated with that appointment; and a bill may contain charges related to services actually recorded. Integration is not simply placing links to different pages in a common menu. It also involves data relationships, validation rules, error handling and traceable updates.

### 2.4 Quality Attributes
The quality of a hospital system can be discussed through functional suitability, usability, reliability, performance, security, maintainability and compatibility. In a healthcare context, informational quality and patient safety are especially important because mistakes in records or confusing workflows can have consequences beyond ordinary office software. A student project can demonstrate software-engineering principles, but it should not be presented as clinically safe without appropriate validation and governance.

### 2.5 Scope of This Review
The report focuses on system evaluation and implementation considerations rather than medical diagnosis or treatment algorithms. It uses published studies to discuss software and organisational quality. SmartCare is used as an application context for recommendations, not as a source of experimentally verified research results.

---

## 3. Literature Review Method

This document uses a focused narrative-review approach. Relevant published research was located through scholarly and publisher records, including PubMed, PubMed Central and BMC/Springer Nature pages. The search focused on research about hospital information-system evaluation criteria, technical requirements and electronic-record usability.

### 3.1 Selection Focus
The included studies cover three complementary questions:
- (a) What dimensions should be considered when evaluating an HIS?
- (b) Which technical requirements can be checked?
- (c) How usability evaluation has been conducted for hospital electronic-record systems?

### 3.2 Extraction and Synthesis
For each selected study, the review records the publication details, the research purpose, the general method, the main findings reported by the authors and the implications for SmartCare. The synthesis is thematic: system-level evaluation, technical quality and usability are discussed separately and then combined into a project-oriented framework.

### 3.3 Interpretation Rules
Reported numerical findings are attributed to the original studies and should not be interpreted as measurements of SmartCare. Recommendations for SmartCare are reasoned applications of those findings. Where the available project information does not establish that a function has been tested, this review describes a test that should be performed rather than reporting a successful result.

### 3.4 Limitations of the Method
Because the review is focused and narrative, it does not claim exhaustive database coverage, duplicate independent screening, formal risk-of-bias assessment or a registered systematic-review protocol. Its purpose is to provide a structured academic foundation and an actionable quality checklist for the project.

---

## 4. Review of Related Research

### 4.1 Khorasani et al. (2026): Hospital Information Systems Evaluation Criteria
Khorasani and colleagues published a scoping review that aimed to identify and organise criteria used to evaluate hospital information systems. The review searched several scholarly sources and reported 52 included studies from an initial set of 561 records. Its findings grouped evaluation indicators into six broad domains:
1. **Human Domain**
2. **Technological Domain**
3. **Informational Domain**
4. **Organizational Domain**
5. **Legal Domain**
6. **Patient Safety Domain**

The authors also organised indicators using the **Structure–Process–Outcome** perspective.

**Importance:** A system cannot be judged only by technical functionality because users, organisational procedures, information quality, legal responsibilities and patient-safety considerations also shape performance. A technically stable application may still be unsuitable if users cannot understand it or if its records are incomplete. Similarly, a usable application may be inadequate if access is not properly controlled.

**Application to SmartCare:** Assess across multiple dimensions. Human factors can be evaluated through role-based usability scenarios. Technology can be assessed through response time, reliability and deployment checks. Information quality can be checked through required fields, validation and database consistency.

### 4.2 Relevance of the Structure–Process–Outcome View
- **Structure:** Application codebase, database schema, roles and deployment environment.
- **Process:** Patient registration, appointment scheduling, consultation documentation, and billing.
- **Outcomes:** Fewer duplicate entries, complete records, faster workflow completion. Such outcomes must be measured in a defined evaluation.

---

## 5. Technical Requirements and Architecture

### 5.1 Farzandipour et al. (2020): Technical Requirements Framework
Farzandipour and colleagues developed and evaluated a framework of technical requirements for hospital information systems using Delphi techniques to establish a 73-item list across four domains:
- **Communication service** (63.8% fulfillment in reviewed hospitals)
- **System architecture** (65.5% fulfillment)
- **Security service** (72.4% fulfillment)
- **System response time** (76.3% fulfillment)

**Application to SmartCare:** The Java/Jakarta Servlet/JSP and JDBC/MySQL stack should be tested for correct request handling, database connectivity, error recovery and consistency across modules. Authentication and authorization must be tested separately: logging in successfully does not prove that a user is restricted to the correct functions. Password storage should use BCrypt hashing.

### 5.2 Architecture and Separation of Responsibilities
A maintainable application separates presentation, application logic and data access. JSP pages and servlet controllers support the web interaction layer, service logic applies business rules, and JDBC-based repositories handle database operations. Clear separation reduces duplication and makes it easier to test rules such as appointment conflicts, billing calculations and role restrictions.

### 5.3 Response Time and Reliability
A response-time test should specify the action, test data, environment, number of repetitions and observed time. Examples include opening the patient list, searching doctors, saving an appointment and generating a report. Reliability tests should include invalid input, missing database connectivity and expired sessions.

---

## 6. Usability of Hospital Software

### 6.1 Wronikowska et al. (2021): Systematic Review of Usability Metrics
Wronikowska and colleagues reviewed methods and metrics used to evaluate hospital electronic health-record systems for clinical staff. Their search identified 1,336 records, with 51 included studies. The authors reported 11 distinct usability-evaluation methods, 7 usability metrics and 70 measurement techniques (most frequently ISO 9241-11 and Nielsen's usability components).

**Application to SmartCare:** Prepare task-based scenarios instead of asking only whether users like the interface (e.g. registering a patient, locating a doctor, scheduling an appointment, entering a consultation note, dispensing medicine, preparing a bill).

### 6.2 Practical Usability Heuristics
- Clear feedback after saving actions.
- Understandable error messages without revealing system internals.
- Consistent labels between pages.
- Confirmation for destructive actions.
- Preserved form state upon invalid entry.

### 6.3 Accessibility and Error Prevention
Readable text, sufficient contrast, keyboard access, clear focus indicators, standardized date formats, patient identifiers, and monetary values.

---

## 7. Usability Evaluation and Local Context

### 7.1 Heuristic Evaluation of Hospital Information-System Subsystems (2018)
Examines heuristic evaluation of admission and medical records subsystems. Direct relevance to SmartCare because workflows depend on accurate patient identification, clear navigation, and consistent handling of records.

### 7.2 Electronic Health Records in Indian Hospitals (2017)
Research examined electronic health-record use in hospitals in Chandigarh, India. Contextual considerations for SmartCare: straightforward English labels, clear date and currency (₹ INR) formats, manageable workflows for busy staff, and support for realistic hospital roles.

### 7.3 Implications for Student Projects
A student project can demonstrate an understanding of usability through a documented inspection and a small, clearly described task test with synthetic data.

---

## 8. Thematic Synthesis of the Literature

| Source | Main Focus | Reported Contribution | SmartCare Implication |
| :--- | :--- | :--- | :--- |
| **Khorasani et al. (2026)** | HIS evaluation criteria | Six domains: human, technological, informational, organizational, legal and patient safety | Use a multidimensional quality checklist |
| **Farzandipour et al. (2020)** | Technical requirements | 73-item framework in four technical domains | Check architecture, security, communication and response time |
| **Wronikowska et al. (2021)** | Usability metrics and methods | Identified variation in evaluation methods, metrics and measurements | Define repeatable task-based usability measures |
| **Heuristic evaluation study (2018)** | Admission and medical records interfaces | Applies heuristic evaluation to hospital subsystems | Inspect registration, admission and record workflows |
| **Chandigarh EHR study (2017)** | EHR use in Indian hospitals | Examines EHR use in a regional hospital context | Consider adoption and local workflow fit |

### Common Themes:
1. Quality must be evaluated across several dimensions rather than by counting features.
2. Technical architecture, security and response time require explicit verification.
3. Usability should be measured through user tasks and structured observations.
4. Implementation context matters: the system should fit the roles and processes of the organisation.

---

## 9. Application to SmartCare Modules

- **9.1 Authentication and Administration:** Verify valid logins, reject invalid credentials, terminate session on logout, enforce server-side role restrictions, protect passwords using BCrypt, store secrets in protected configuration.
- **9.2 Patient and Doctor Management:** Validate required fields, input formats, prevent duplicates, test search queries, verify updates don't collide.
- **9.3 Appointments and Consultation:** Test creation, reschedule, cancellation, prevent doctor time slot collisions, link consultation notes to encounter.
- **9.4 Pharmacy, Laboratory and Nursing:** Validate medicine stock rules, prescription line items, diagnostic test orders, and patient vital sign logging.
- **9.5 Billing, Admissions, Reports and Feedback:** Verify arithmetic and tax rounding, payment allocation, room state transitions, reporting filters, and feedback submission.

---

## 10. Proposed Testing and Evaluation Framework

1. **Functional Testing:** Verify every feature against defined requirements with Test ID, module, preconditions, steps, expected and actual result.
2. **Integration Testing:** Examine data passed between modules (registration ➔ appointment ➔ consultation ➔ pharmacy ➔ billing).
3. **Security Testing:** Authentication, authorization, session management, parameterized SQL statements, error handling.
4. **Performance and Reliability:** Response time over multiple runs, database unavailability recovery, session expiration handling.
5. **Usability Testing:** Task completion, error rates, time-on-task, and feedback.
6. **Defect Management:** Track unique ID, severity, priority, reproduction steps, resolution status.

---

## 11. Proposed Metrics and Test Matrix

| Quality Area | Example Measure | Evidence to Record |
| :--- | :--- | :--- |
| **Functional correctness** | Passed tests / executed tests | Test-case sheet and screenshots/logs |
| **Data integrity** | Correct relationships and updates | Database checks and cross-module scenarios |
| **Usability** | Task completion, errors, time | Observation sheet and participant feedback |
| **Performance** | Median or average response time | Environment, repetitions and timings |
| **Security** | Authorisation and session test outcomes | Role matrix and negative test cases |
| **Reliability** | Recovery and error-handling behaviour | Failure scenario and recovery record |
| **Maintainability** | Build reproducibility and defect traceability | Build log, configuration notes and issue list |

---

## 12. Discussion, Limitations and Future Work

- **Discussion:** A balanced view of hospital software quality; architecture alone does not prove quality; security requires defense-in-depth.
- **Limitations:** Narrative review, synthetic academic test data, live deployment availability limitations.
- **Future Work:** Requirements traceability matrix, automated CI tests, performance benchmarking, accessibility compliance.
- **Ethical Considerations:** Strictly fictional/synthetic patient records; no real medical decision making.

---

## 13. Conclusion & References

HIS quality is multidimensional: technology, information quality, people, organisational processes, security, usability and patient safety all matter. SmartCare addresses these academic dimensions through layered engineering and documented testing.

### Formal Citations:
1. Khorasani, H., Damiri, S., Abbasi, S., Fathabadi, A., Dehghani, M., & Sadeghi, M. (2026). Hospital information systems evaluation criteria: a scoping review. *BMC Health Services Research*, 26, 184. [https://doi.org/10.1186/s12913-025-13972-3](https://doi.org/10.1186/s12913-025-13972-3)
2. Farzandipour, M., Meidani, Z., Nabovati, E., Sadeqi Jabali, M., & Dehghan Banadaki, R. (2020). Technical requirements framework of hospital information systems: design and evaluation. *BMC Medical Informatics and Decision Making*, 20, 61. [https://doi.org/10.1186/s12911-020-1076-5](https://doi.org/10.1186/s12911-020-1076-5)
3. Wronikowska, M. W., Malycha, J., Morgan, L. J., Westgate, V., Petrinic, T., Young, J. D., & Watkinson, P. J. (2021). Systematic review of applied usability metrics within usability evaluation methods for hospital electronic healthcare record systems. *Journal of Evaluation in Clinical Practice*, 27(6), 1403–1416. [https://doi.org/10.1111/jep.13582](https://doi.org/10.1111/jep.13582)
4. Usability Evaluation of Three Admission and Medical Records Subsystems Integrated into Nationwide Hospital Information Systems: Heuristic Evaluation. (2018). PubMed indexed record. [https://pubmed.ncbi.nlm.nih.gov/30061787/](https://pubmed.ncbi.nlm.nih.gov/30061787/)
5. Electronic health record use in an affluent region in India: Findings from a survey of Chandigarh hospitals. (2017). *International Journal of Medical Informatics*, 103, 78–82. [https://doi.org/10.1016/j.ijmedinf.2017.04.011](https://doi.org/10.1016/j.ijmedinf.2017.04.011)
6. Killedar. (2025). Web Based Hospital Management System. *International Journal of Engineering Development and Research (IJEDR)*. [https://rjwave.org/ijedr/viewpaperforall.php?paper=IJEDR2504071](https://rjwave.org/ijedr/viewpaperforall.php?paper=IJEDR2504071)
