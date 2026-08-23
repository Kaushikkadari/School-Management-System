#!/bin/bash
echo "Installing requirements..."
python -m pip install -r requirements.txt --break-system-packages

echo "Collecting static files..."
python manage.py collectstatic --noinput --clear
