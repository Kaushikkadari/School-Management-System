#!/bin/bash

echo "====================================="
echo "School Management System Setup"
echo "====================================="
echo ""

echo "Step 1: Creating virtual environment..."
python3 -m venv venv
if [ $? -ne 0 ]; then
    echo "Error: Failed to create virtual environment. Please ensure Python 3 is installed."
    exit 1
fi

echo "Step 2: Activating virtual environment..."
source venv/bin/activate

echo "Step 3: Installing required packages..."
pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "Error: Failed to install packages. Check your internet connection."
    exit 1
fi

echo "Step 4: Setting up database..."
python manage.py makemigrations
python manage.py migrate

echo "Step 5: Setting up admin credentials..."
python manage.py update_admin_credentials

echo "Step 6: Collecting static files..."
python manage.py collectstatic --noinput

echo ""
echo "====================================="
echo "Setup Complete!"
echo "====================================="
echo ""
echo "You can now run the server with:"
echo "python manage.py runserver"
echo ""
echo "Admin credentials:"
echo "Username: admin"
echo "Password: admin123"
echo ""
echo "Press Enter to start the server now..."
read

echo "Starting development server..."
python manage.py runserver


