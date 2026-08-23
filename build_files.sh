#!/bin/bash
echo "Installing requirements..."
python -m pip install -r requirements.txt --break-system-packages

echo "Running database migrations..."
python manage.py migrate --noinput

echo "Seeding default admin credentials..."
python manage.py update_admin_credentials

echo "Seeding demo teacher and student accounts..."
python manage.py ensure_manual_accounts

echo "Collecting static files..."
python manage.py collectstatic --noinput --clear
