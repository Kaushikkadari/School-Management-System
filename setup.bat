@echo off
echo =====================================
echo School Management System Setup
echo =====================================
echo.

echo Step 1: Creating virtual environment...
python -m venv venv
if errorlevel 1 (
    echo Error: Failed to create virtual environment. Please ensure Python is installed.
    pause
    exit /b 1
)

echo Step 2: Activating virtual environment...
call venv\Scripts\activate

echo Step 3: Installing required packages...
pip install -r requirements.txt
if errorlevel 1 (
    echo Error: Failed to install packages. Check your internet connection.
    pause
    exit /b 1
)

echo Step 4: Setting up database...
python manage.py makemigrations
python manage.py migrate

echo Step 5: Setting up admin credentials...
python manage.py update_admin_credentials

echo Step 6: Collecting static files...
python manage.py collectstatic --noinput

echo.
echo =====================================
echo Setup Complete!
echo =====================================
echo.
echo You can now run the server with:
echo python manage.py runserver
echo.
echo Admin credentials:
echo Username: admin
echo Password: admin123
echo.
echo Press any key to start the server now...
pause >nul

echo Starting development server...
python manage.py runserver


