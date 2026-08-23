# 🏫 School Management System (SMS)

[![Django Version](https://img.shields.io/badge/Django-4.2.1-092E20?style=flat&logo=django)](https://www.djangoproject.com/)
[![Python Version](https://img.shields.io/badge/Python-3.8%2B-3776AB?style=flat&logo=python)](https://www.python.org/)
[![UI Framework](https://img.shields.io/badge/Bootstrap-5.3.0-7952B3?style=flat&logo=bootstrap)](https://getbootstrap.com/)
[![Deployment](https://img.shields.io/badge/Vercel-Ready-000000?style=flat&logo=vercel)](https://vercel.com/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A comprehensive, production-ready School Management System built on **Django**. This web application provides a complete dashboard interface tailored for three key roles: **Administrators**, **Teachers**, and **Students**. It is designed with modularity, security, and scalability in mind, making it ready to be deployed instantly on platforms like Vercel, Render, or Heroku.

---

## 🚀 Live Demo & Testing Accounts

If you are a recruiter or reviewer testing the live deployment, you can log in using these pre-configured demo accounts. 

### [👉 Click Here to Open the Live App](https://your-deployment-url.vercel.app/)

| Role | Username / ID | Password |
| :--- | :--- | :--- |
| **Administrator** | `admin` | `admin123` |
| **Teacher** | `TCH_MANUAL` (or `teacher_manual`) | `TeacherPass123!` |
| **Student** | `STD_MANUAL` (or `student_manual`) | `StudentPass123!` |

*Note: The login page includes a built-in **Password Visibility Toggle** (eye icon) and a **Demo Credentials Helper Card** for quick copy-pasting.*

---

## 🛠️ Tech Stack & Key Integrations

### Backend
* **Django 4.2+** - Core MVC web framework.
* **WhiteNoise** - Serving compressed static assets directly in production.
* **dj-database-url** - Dynamic database configurations parsing PostgreSQL credentials.
* **ReportLab** - Dynamic PDF generation for timetables and payment receipts.
* **openpyxl / xlsxwriter** - Excel spreadsheets exporter for student datasets.

### Frontend
* **Bootstrap 5.3** - Modern, responsive styling.
* **FontAwesome 6** - Vector icons.
* **Chart.js** - Interactive dashboards rendering attendance percentages and grade summaries.
* **FullCalendar 5.11** - TIMETABLE and event scheduling calendar.

---

## 🌟 Core Features

### 👤 Student Portal
* **Interactive Dashboard**: View academic progress charts, upcoming exam schedules, notice boards, and pending fees.
* **Course Enrollment**: Request and self-enroll in active courses mapped to your grade level.
* **Timetables**: View and export personal weekly calendars to PDF/Excel.
* **Assignments & Exams**: Submit assignment files online and review exam schedules.
* **Fee Invoices**: Make test payments and download print-ready receipts.

### 👩‍🏫 Teacher Portal
* **Course Hub**: Manage assignments, upload course material files (worksheets, slides), and post course announcements.
* **Grading System**: View lists of enrolled students, review assignment file submissions, and submit scores.
* **Attendance Manager**: Record daily attendance (Present, Absent, Late, Excused) with history logs.
* **Messaging Center**: Compose and exchange direct messages with students, other teachers, or administrators.

### 🔑 Administrator Panel
* **Onboarding Management**: Register, edit, and manage accounts for students, teachers, and staff.
* **Academics Control**: Define departments, class sections, subjects, and schedule room allotments.
* **Financial Auditing**: View system-wide fee collections, check expenses, and generate reports.
* **Notice Board Manager**: Broadcast general notices targeting parents, students, or teachers.

---

## ⚙️ Project Structure

```text
SMS/
├── accounts/           # Main Django app containing views, models, and forms
│   ├── templates/      # Nested HTML templates (Admin, Teacher, Student views)
│   ├── static/         # Custom CSS, JS, and image assets
│   └── management/     # Seeder commands (e.g. ensure_manual_accounts)
├── SMS/                # Project configuration folder (settings, urls, wsgi)
├── templates/          # Root layout overrides
├── staticfiles/        # Directory where static files are collected for production
├── Procfile            # Deployment declarations for Render / Heroku
├── vercel.json         # Serverless function configuration for Vercel
├── build_files.sh      # Build script running collectstatic on Vercel
├── requirements.txt    # Application dependencies list
└── .env.example        # Reference environment variables template
```

---

## 💻 Local Quick Start

### Option 1: Automated setup (Recommended)

**For Windows:**
Double-click `setup.bat` or run:
```bash
setup.bat
```

**For macOS/Linux:**
```bash
chmod +x setup.sh
./setup.sh
```

---

### Option 2: Manual setup

1. **Clone and Navigate:**
   ```bash
   git clone <your-repository-url>
   cd SMS
   ```

2. **Setup Virtual Environment:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows use: venv\Scripts\activate
   ```

3. **Install Dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Setup Environment variables:**
   Create a `.env` file in the root directory (refer to `.env.example`):
   ```bash
   cp .env.example .env
   ```

5. **Run Migrations & Seed Database:**
   ```bash
   python manage.py migrate
   python manage.py update_admin_credentials
   python manage.py ensure_manual_accounts
   ```

6. **Start Development Server:**
   ```bash
   python manage.py runserver
   ```
   Open `http://127.0.0.1:8000/` in your browser.

---

## ☁️ Vercel Serverless Deployment

This project is configured out-of-the-box for serverless deployment on Vercel:

1. **Connect Repository**: Import your GitHub project to your [Vercel Dashboard](https://vercel.com).
2. **Environment Variables**: Set the following in your Vercel settings:
   * `DJANGO_DEBUG` = `False`
   * `DJANGO_SECRET_KEY` = `your-secure-production-key`
   * `DATABASE_URL` = `your-postgres-url` *(Use Supabase, Neon, or Vercel Postgres to ensure data is preserved permanently)*
   * `DJANGO_ALLOWED_HOSTS` = `localhost,127.0.0.1,.vercel.app`
3. **Build Command**: Vercel will automatically read `vercel.json` and execute `build_files.sh` to compile files, run collectstatic, and launch the server.

---

## 🔒 Security Practices Applied
* **No committed Secrets**: Key settings like secret keys, passwords, and SMTP logs are extracted to `.env` using `python-dotenv`.
* **Database Agnostic**: Uses `dj-database-url` to support secure Postgres connections on hosting servers while keeping lightweight SQLite for local developers.
* **WhiteNoise Serving**: Serves static files efficiently in production with caching and compression headers, eliminating separate storage dependencies.

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
