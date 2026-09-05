<div align="center">

# 🏫 School Management System (SMS)
### *Enterprise-Grade Academic Operations, Grading & Administration Platform*

[![Django](https://img.shields.io/badge/Django-4.2.1-092E20?style=for-the-badge&logo=django&logoColor=white)](https://www.djangoproject.com/)
[![Python](https://img.shields.io/badge/Python-3.8%20%7C%203.11%20%7C%203.12-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3.0-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)
[![Vercel](https://img.shields.io/badge/Vercel-Deployed-000000?style=for-the-badge&logo=vercel&logoColor=white)](https://vercel.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Ready-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![WhiteNoise](https://img.shields.io/badge/Static%20Serving-WhiteNoise-blue?style=for-the-badge)](http://whitenoise.evans.io/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

<p align="center">
  <b>A modular, high-performance, and secure full-stack school administration platform featuring multi-tenant Role-Based Access Control (RBAC) across Students, Teachers, and Administrators.</b>
</p>

[Explore Features](#-core-features--role-breakdown) •
[System Architecture](#-system-architecture) •
[Database ERD](#-database-schema--entity-relationships) •
[Quick Start](#-local-quick-start) •
[Vercel Deployment](#-vercel-serverless-deployment) •
[API Routing](#-url-routing--view-structure)

</div>

---

## 📑 Table of Contents

- [Executive Summary](#-executive-summary)
- [Live Demo & Test Credentials](#-live-demo--test-credentials)
- [System Architecture](#-system-architecture)
  - [High-Level Architectural Workflow](#high-level-architectural-workflow)
  - [Architectural Layers & Components](#architectural-layers--components)
  - [Dual-Database Strategy & Vercel Serverless Bridge](#dual-database-strategy--vercel-serverless-bridge)
- [Database Schema & Entity Relationships](#-database-schema--entity-relationships)
- [Core Features & Role Breakdown](#-core-features--role-breakdown)
  - [1. Student Portal](#1-student-portal)
  - [2. Teacher Portal](#2-teacher-portal)
  - [3. Administrator Operations](#3-administrator-operations)
- [Reporting & Data Export Engines](#-reporting--data-export-engines)
- [Technology Stack](#-technology-stack)
- [Security & Performance Engineering](#-security--performance-engineering)
- [Project Directory Structure](#-project-directory-structure)
- [URL Routing & View Structure](#-url-routing--view-structure)
- [Local Quick Start](#-local-quick-start)
  - [Automated Setup](#automated-setup-recommended)
  - [Manual Installation](#manual-installation)
- [Vercel Serverless Deployment](#-vercel-serverless-deployment)
- [Management Commands](#-management-commands)
- [Contributing & License](#-contributing--license)

---

## 💡 Executive Summary

The **School Management System (SMS)** is engineered to streamline institutional workflows, unify fragmented academic processes, and provide real-time data transparency across all education stakeholders:

1. **Institutions & Administrators** gain complete control over academic setups, staff/student lifecycle onboarding, class room schedules with conflict-prevention constraints, financial accounting (invoicing, payments, and operational expenses), and centralized announcements.
2. **Educators & Teachers** benefit from streamlined course hubs, dynamic digital syllabus/materials publishing, one-click attendance recording with historic tracking, gradebook computation, and student behavior logging.
3. **Students** experience an interactive self-service portal for self-enrollment, exam timetable tracking, assignment submission with online status feedback, fee receipt downloads, and private messaging with course instructors.

---

## 🚀 Live Demo & Test Credentials

For hiring managers, recruiters, and reviewers evaluating this project live:

| Role | Username / Identifier | Password | Access Scope |
| :--- | :--- | :--- | :--- |
| **🛡️ Administrator** | `admin` | `admin123` | Full administrative control, system settings, financial logs, faculty/student registries |
| **👨‍🏫 Teacher** | `TCH_MANUAL` *(or `teacher_manual`)* | `TeacherPass123!` | Class rosters, attendance taker, gradebook submission, course materials repository |
| **🎓 Student** | `STD_MANUAL` *(or `student_manual`)* | `StudentPass123!` | Personal profile, course enrollment, assignments submission, fees & payment receipts |

> **UI Enhancement**: The login screen features a built-in **Password Visibility Toggle** (eye icon) and an interactive **Demo Credentials Helper Card** for seamless copy-pasting during review.

---

## 🏛️ System Architecture

### High-Level Architectural Workflow

The application is architected around modern Django Model-View-Template (MVT) principles, optimized for both serverless containers and dedicated virtual machines:

```mermaid
flowchart TB
    subgraph ClientLayer [Client & Presentation Layer]
        Browser["Desktop & Mobile Browsers"]
        UI["Bootstrap 5.3 + FontAwesome 6 UI"]
        Widgets["Chart.js 4 (Analytics) + FullCalendar 5.11 (Timetable)"]
    end

    subgraph EdgeLayer [Edge Gateway & Static Delivery]
        VercelEdge["Vercel Edge Network / CDN"]
        WhiteNoise["WhiteNoise Static Engine (Cache-Control & Gzip/Brotli)"]
    end

    subgraph AppLayer [Application & Controller Layer (Django 4.2)]
        WSGI["WSGI Handler (SMS/wsgi.py)"]
        SecMiddleware["Security, Session & CSRF Middleware"]
        RBAC["Role-Based Access Control (Admin / Teacher / Student Dispatcher)"]
        Views["Domain Controllers & View Handlers (accounts/views.py)"]
    end

    subgraph ServiceLayer [Business & Processing Engines]
        DocGen["PDF Generator (ReportLab)"]
        SheetGen["Excel Streamer (openpyxl & xlsxwriter)"]
        AuthEngine["Authentication & Password Hashers (PBKDF2)"]
        Mailer["SMTP & Console Email Notifier"]
    end

    subgraph StorageLayer [Persistence & Data Layer]
        Bridge["Serverless /tmp Writable DB Bridge"]
        SQLite["SQLite 3 Engine (Local Dev & Ephemeral Preview)"]
        Postgres["PostgreSQL / Supabase / Neon (Production DB)"]
        MediaStore["Media Files Storage (Assignments, Course Materials, Receipts)"]
    end

    Browser -->|HTTPS Requests| VercelEdge
    VercelEdge -->|Static Assets /static/*| WhiteNoise
    VercelEdge -->|Dynamic App Routes| WSGI
    WSGI --> SecMiddleware
    SecMiddleware --> RBAC
    RBAC --> Views

    Views --> DocGen
    Views --> SheetGen
    Views --> AuthEngine
    Views --> Mailer

    Views -->|Django ORM Queries| Bridge
    Bridge -->|Local Fallback| SQLite
    Bridge -->|DATABASE_URL| Postgres
    Views -->|File Uploads| MediaStore
    UI --- Widgets
```

---

### Architectural Layers & Components

#### 1. Presentation Layer
- **Responsive Grid**: Built on Bootstrap 5.3 with custom CSS animations (`fadeIn`, `fadeInOut`, smooth button transforms).
- **Dynamic Visualizations**: Integrated **Chart.js** rendering real-time student attendance percentages and grade distribution curves.
- **Interactive Calendars**: Powered by **FullCalendar 5.11**, offering multi-category color-coded scheduling (Academic, Exams, Holidays, Meetings, Sports, Cultural).
- **Zero-Dependency High-Res Media**: Background hero graphics loaded asynchronously from verified Unsplash CDNs with offscreen text-indent fallbacks to avoid layout shifts.

#### 2. Security & RBAC Middleware Layer
- **Role Isolation**: Custom decorators and view-level authorization filters inspect `user.is_staff`, `user.teacher_profile`, and `user.student_profile` before dispatching requests.
- **Session Security**: Cookies are configured with `SESSION_EXPIRE_AT_BROWSER_CLOSE = True` and strict 30-minute idle expiration (`SESSION_COOKIE_AGE = 1800`).
- **CSRF & Injection Mitigation**: Built-in Django token validation on every POST/PUT mutation combined with parameterized ORM queries preventing SQL injection.

#### 3. Application & Controller Layer
- Over **5,900+ lines of domain logic** spanning 152 distinct URL endpoints across administrative setups, pedagogical grading, student lifecycle, and accounting.
- Native multi-channel messaging engine with attachment uploads for parent-teacher-student correspondence.

#### 4. Dual-Database Strategy & Vercel Serverless Bridge
A significant architectural challenge when deploying Django on serverless hosting (such as Vercel) is the **read-only ephemeral filesystem**:
- In standard Vercel environments, `/var/task` is completely write-protected. Direct writes to SQLite trigger `OperationalError: attempt to write a readonly database` when saving session tokens or submitting forms.
- **The Solution**: 
  - During the `BUILD_PHASE=1` build step, database migrations and default demo seeds are compiled directly into the root bundle.
  - At runtime, `SMS/settings.py` detects serverless invocation (`VERCEL == '1'`) and copies the pre-seeded `db.sqlite3` into the writable `/tmp/` filesystem.
  - Furthermore, using `dj-database-url`, the application automatically hot-swaps to an external hosted **PostgreSQL** instance (Neon, Supabase, AWS RDS) whenever a `DATABASE_URL` is configured.

---

## 🗄️ Database Schema & Entity Relationships

The following entity-relationship diagram details the core relational structure of the SMS database:

```mermaid
erDiagram
    User ||--o| Student : "has student_profile"
    User ||--o| Teacher : "has teacher_profile"
    User ||--o| Profile : "has general profile"

    Department ||--o{ Teacher : "employs"
    Department ||--o{ Expense : "incurs"

    Class ||--o{ Student : "enrolled in section"
    Class ||--o{ Course : "contains"

    Teacher ||--o{ Course : "instructs"
    Teacher ||--o{ ExamSchedule : "supervises"
    Teacher ||--o{ Evaluation : "evaluated by"

    Course ||--o{ CourseMaterial : "hosts"
    Course ||--o{ Activity : "assigns"
    Course ||--o{ Examination : "schedules"
    Course ||--o{ Attendance : "records"
    Course ||--o{ Grade : "assesses"
    Course ||--o{ Schedule : "allocated in room"
    Course ||--o{ Announcement : "broadcasts"

    Student ||--o{ Attendance : "logs presence"
    Student ||--o{ Grade : "receives"
    Student ||--o{ Behavior : "incident log"
    Student ||--o{ AssignmentSubmission : "submits"
    Student ||--o{ Fee : "owes"
    Student ||--o{ Invoice : "billed"
    Student ||--o{ Payment : "transacts"

    Activity ||--o{ AssignmentSubmission : "receives"
    Examination ||--o{ ExamSchedule : "has rooms"
    Payment ||--o| Invoice : "settles"
```

---

## 🌟 Core Features & Role Breakdown

### 1. 🎓 Student Portal
* **Dynamic Student Dashboard**: Quick-stats summarizing GPA, overall attendance percentage, upcoming assignments, exam dates, and recent institutional notices.
* **Course Hub & Enrollment**: Browse available academic courses, inspect instructor details, and self-enroll in approved class sections.
* **Timetable & Room Locator**: View daily time blocks, assigned classrooms, and download print-ready weekly schedules.
* **Online Assignment Submission**: Upload homework documents, lab reports, and projects directly to the course activity with custom notes.
* **Fee Payment & Receipts**: View pending invoice balances, simulate fee settlement across multiple payment channels, and download official PDF receipts.
* **Digital Notice Board**: Filter general, academic, and exam-related announcements with downloadable attachments.

---

### 2. 👨‍🏫 Teacher Portal
* **Course Administration Hub**: Manage multiple enrolled courses, monitor student rosters, and view real-time class counters.
* **Course Materials Repository**: Publish lecture slides, PDFs, worksheets, and references with auto-calculated file size badges.
* **Daily Attendance Marker**: High-speed attendance logger supporting `Present`, `Absent`, `Late`, and `Excused` with conflict prevention.
* **Assignments & Exam Manager**: Create activities (Assignments, Quizzes, Projects, Exams) with strict submission deadlines.
* **Grading & Feedback Engine**: Inspect student file submissions, enter numeric scores, and compute alphabetical grades with remarks.
* **Student Behavior Logger**: Record disciplinary or commendation incidents with severity levels (`Low`, `Medium`, `High`) and actions taken.
* **Direct Messaging**: Communicate in private threads with students, parents, and administrative staff.

---

### 3. 🛡️ Administrator Operations
* **Central Analytics Dashboard**: Visual summary of total enrollments, active faculty, overall fee collections, and monthly expenses.
* **Student & Faculty Management**: Comprehensive CRUD operations for onboarding, profile editing, photo uploading, and status toggling (`Active`, `Suspended`, `Graduated`).
* **Academic Department & Class Allocator**: Manage department codes, class sections (Grade Levels + Academic Years), and course credits.
* **Room Scheduling & Conflict Detection**: Intelligent schedule validator preventing double-booking of physical classrooms for the same time slot:
  ```python
  # Built-in Room Conflict Constraint (accounts/models.py)
  models.UniqueConstraint(
      fields=['room', 'day', 'start_time', 'end_time'],
      name='unique_room_schedule'
  )
  ```
* **Financial Ledger & Expense Auditor**: Categorize operational expenses (Salaries, Maintenance, Utilities, Supplies), upload receipts, and monitor balances.
* **Campus Event Planner**: Create calendar events with visual color coding across the entire institution.

---

## 📊 Reporting & Data Export Engines

SMS includes specialized reporting engines generating exportable artifacts:

| Report Type | Formats Supported | Key Metrics Covered |
| :--- | :--- | :--- |
| **Academic Performance** | `PDF`, `Excel (.xlsx)` | Subject scores, GPA calculation, class rank, pass/fail status |
| **Attendance Summary** | `PDF`, `Excel (.xlsx)` | Present/absent counts, percentage rates, excused absences |
| **Student Behavior** | `HTML`, `PDF` | Disciplinary history, incident severity aggregation, actions taken |
| **Financial & Invoicing** | `PDF`, `Excel (.xlsx)` | Fee collection rates, pending invoice dues, operational expense breakdown |
| **Timetable Schedule** | `PDF` | Weekly matrix of rooms, instructors, and time intervals |

---

## 🛠️ Technology Stack

```text
├── Framework:            Django 4.2.1 (Python Web Framework)
├── Database (Dev):       SQLite 3 (Zero-setup local testing)
├── Database (Prod):      PostgreSQL via psycopg2-binary & dj-database-url
├── Static Assets:        WhiteNoise 6.5.0 (Optimized compression & caching)
├── WSGI Server:          Gunicorn 20.1.0
├── PDF Generation:       ReportLab 4.0.4
├── Spreadsheet Engine:   openpyxl 3.1.2 & XlsxWriter 3.1.2
├── Image Processing:     Pillow 10.0.0
├── Frontend Core:        Bootstrap 5.3.0, Vanilla JavaScript (ES6+)
├── Icons & Fonts:        FontAwesome 6.0, Google Fonts (Poppins, Inter)
├── Analytics UI:         Chart.js 4.x
├── Calendar UI:          FullCalendar 5.11.x
└── Cloud Platform:       Vercel Serverless Functions (@vercel/python)
```

---

## 🔒 Security & Performance Engineering

1. **Strict Environment Segregation**: Hardcoded credentials and secret keys have been extracted into `.env` configurations utilizing `python-dotenv`.
2. **Password Hardening**: Passwords encrypted using Django's default PBKDF2 with SHA-256 hashers.
3. **Data Integrity Validators**:
   - `name_validator`: Enforces clean alphabetic strings preventing injection characters.
   - `phone_regex`: Validates international E.164 phone formats (`^\+?1?\d{9,15}$`).
4. **Resilient Type Fallbacks**: Settings parameters employ safe fallback casts (`os.environ.get('PORT') or 587`) to protect against unconfigured empty strings on cloud providers.
5. **Static Compression**: WhiteNoise delivers Gzip and Brotli compressed static assets with aggressive `max-age` caching headers.

---

## 📂 Project Directory Structure

```text
School-Management-System/
├── accounts/                     # Core Business Application
│   ├── management/
│   │   └── commands/             # CLI Seeding Commands
│   │       ├── ensure_manual_accounts.py  # Seeds Demo Student & Teacher
│   │       └── update_admin_credentials.py # Seeds Admin Superuser
│   ├── migrations/               # Database Migration History
│   ├── static/                   # Application Styles, Scripts & Assets
│   │   └── accounts/
│   │       ├── css/              # Custom Stylesheets
│   │       ├── js/               # UI Interaction Scripts
│   │       └── images/           # Badges and Default Icons
│   ├── templates/accounts/       # HTML Template Partials & Pages
│   │   ├── courses/              # Course CRUD Views
│   │   ├── reports/              # Academic, Financial & Behavior Reports
│   │   ├── student/              # Student Portal Views
│   │   ├── teacher/              # Teacher Dashboard & Grading
│   │   ├── base.html             # Global Layout Master
│   │   ├── base_admin.html       # Admin Portal Master Layout
│   │   ├── base_student.html     # Student Portal Master Layout
│   │   ├── base_teacher.html     # Teacher Portal Master Layout
│   │   ├── dashboard.html        # Admin Dashboard View
│   │   ├── login.html            # Role-Based Login Screen
│   │   └── register.html         # User Registration Screen
│   ├── admin.py                  # Django Admin Model Registrations
│   ├── forms.py                  # Form Definitions & ModelForms
│   ├── models.py                 # Core Domain Models (770+ lines)
│   ├── urls.py                   # App-Level Route Definitions
│   └── views.py                  # Controllers & Handlers (5,900+ lines)
├── SMS/                          # Project Configuration Directory
│   ├── __init__.py
│   ├── asgi.py                   # ASGI Configuration
│   ├── settings.py               # Settings, WhiteNoise, DB Bridge & Env Loading
│   ├── urls.py                   # Root URL Dispatcher
│   └── wsgi.py                   # WSGI Entry Point for Production
├── staticfiles/                  # Production Static Files (Compiled via collectstatic)
├── .env.example                  # Reference Environment Variables Template
├── .gitignore                    # Prevents Tracking of Secrets, DB & venv
├── build_files.sh                # Vercel Serverless Static & Database Build Script
├── manage.py                     # Django Management CLI
├── Procfile                      # Deployment Descriptor for Render / Heroku
├── README.md                     # Project Technical Documentation
├── requirements.txt              # Pinned Python Dependencies
├── setup.bat                     # 1-Click Setup Script for Windows
├── setup.sh                      # 1-Click Setup Script for macOS / Linux
└── vercel.json                   # Vercel Build & Lambda Routing Configuration
```

---

## 🌐 URL Routing & View Structure

SMS features a well-structured routing hierarchy:

| Route Pattern | Role Requirement | Description |
| :--- | :--- | :--- |
| `/login/` | Public | Role-tabbed login form (Student / Teacher / Admin) |
| `/register/` | Public | Account registration with password confirmation |
| `/forgot-password/` | Public | Password recovery workflow |
| `/dashboard/` | `Admin (Staff)` | Central metrics and operations dashboard |
| `/students/` | `Admin (Staff)` | Student directory, admissions, and status controls |
| `/teachers/` | `Admin (Staff)` | Faculty directory, departmental assignments |
| `/courses/` | `Admin (Staff)` | Course catalog and class room allocations |
| `/finance/fees/` | `Admin (Staff)` | Institutional fee collection and pending billings |
| `/calendar/` | `Authenticated` | Interactive school events and academic calendar |
| `/timetable/` | `Authenticated` | Room schedules and weekly timetable matrix |
| `/reports/` | `Admin (Staff)` | Central report generator (Academic, Attendance, Finance) |
| `/teacher/` | `Teacher` | Teacher dashboard, quick attendance and grading stats |
| `/teacher/courses/` | `Teacher` | Manage assigned courses, syllabus, and file uploads |
| `/teacher/attendance/` | `Teacher` | Fast daily attendance marker |
| `/teacher/grades/` | `Teacher` | Enter exam marks and compute letter grades |
| `/student/` | `Student` | Student dashboard with progress charts |
| `/student/courses/` | `Student` | Browse available courses and self-enroll |
| `/student/assignments/` | `Student` | Submit assignments and view teacher feedback |
| `/student/fees/` | `Student` | Pay pending tuition dues and download invoices |

---

## 💻 Local Quick Start

### Automated Setup (Recommended)

**For Windows:**
Double-click `setup.bat` or run:
```cmd
setup.bat
```

**For macOS / Linux:**
```bash
chmod +x setup.sh
./setup.sh
```

---

### Manual Installation

#### 1. Clone Repository & Navigate:
```bash
git clone https://github.com/Kaushikkadari/School-Management-System.git
cd School-Management-System
```

#### 2. Create and Activate Virtual Environment:
```bash
# macOS/Linux:
python3 -m venv venv
source venv/bin/activate

# Windows (Command Prompt / PowerShell):
python -m venv venv
venv\Scripts\activate
```

#### 3. Install Dependencies:
```bash
pip install -r requirements.txt
```

#### 4. Configure Environment Variables:
Copy the `.env.example` template into a local `.env` file:
```bash
cp .env.example .env
```
*(Default settings are pre-configured for instant local development with SQLite).*

#### 5. Execute Migrations & Seed Default Accounts:
```bash
# Run database migrations
python manage.py migrate

# Seed Administrator account (admin / admin123)
python manage.py update_admin_credentials

# Seed Demo Teacher and Student accounts
python manage.py ensure_manual_accounts
```

#### 6. Launch Local Development Server:
```bash
python manage.py runserver
```
Visit `http://127.0.0.1:8000/` in your browser.

---

## ☁️ Vercel Serverless Deployment

This project is pre-configured for seamless serverless deployment on **Vercel**:

### Step 1: Push Repository to GitHub
Ensure all code and configurations are pushed to your remote repository:
```bash
git push origin main
```

### Step 2: Import into Vercel
1. Go to your [Vercel Dashboard](https://vercel.com/dashboard) and click **"Add New" > "Project"**.
2. Select your `School-Management-System` repository.

### Step 3: Configure Environment Variables
Add the following key-value pairs under **Project Settings > Environment Variables**:

| Variable Name | Example Value | Description |
| :--- | :--- | :--- |
| `DJANGO_DEBUG` | `False` | Disables debug mode in production |
| `DJANGO_SECRET_KEY` | *(generate a strong secret key)* | Production encryption key |
| `DJANGO_ALLOWED_HOSTS` | `.vercel.app,localhost,127.0.0.1` | Whitelisted server domains |
| `DATABASE_URL` | `postgres://user:pass@host/db` *(Optional)* | Connects Supabase / Neon / RDS |

### Step 4: Deploy
Click **Deploy**. Vercel will:
1. Execute `build_files.sh`.
2. Compile and package dependencies using `--break-system-packages`.
3. Run database migrations and seed default demo accounts.
4. Execute `python manage.py collectstatic` to package WhiteNoise assets.
5. Launch the serverless function handler via `SMS/wsgi.py`.

---

## ⚡ Management Commands

SMS includes custom CLI management utilities located in `accounts/management/commands/`:

- **Seed Administrator Account**:
  ```bash
  python manage.py update_admin_credentials
  ```
  Creates/updates the `admin` superuser with password `admin123`.

- **Seed Faculty and Student Demo Profiles**:
  ```bash
  python manage.py ensure_manual_accounts
  ```
  Ensures `teacher_manual` (`TCH_MANUAL`) and `student_manual` (`STD_MANUAL`) exist and are linked to active course sections.

---

## 🤝 Contributing & License

Contributions, issues, and feature requests are welcome!

1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'feat: Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

### License
Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for more information.

---

<div align="center">
  <sub>Developed with ❤️ for academic institutions, educators, and students.</sub>
</div>
