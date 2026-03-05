#!/bin/bash

# Update system
apt update -y
apt upgrade -y
# Install required packages
apt install -y python3-pip python3-venv nginx git certbot python3-certbot-nginx

# Go to home directory
cd /home/ubuntu
# Clone project
git clone https://github.com/vikas-reddy-21/todo_project.git
cd todo_project

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt
pip install gunicorn

# Django setup
python manage.py migrate
python manage.py collectstatic --noinput

# Create Gunicorn systemd service
cat > /etc/systemd/system/gunicorn.service <<EOT
[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=ubuntu
Group=www-data
UMask=0007
WorkingDirectory=/home/ubuntu/todo_project/todo_project
ExecStart=/home/ubuntu/todo_project/venv/bin/gunicorn \
    --workers 3 \
    --bind unix:/home/ubuntu/todo_project/todo_project/app.sock \
    todo_project.wsgi:application

[Install]
WantedBy=multi-user.target
EOT

# Set permissions
chmod 755 /home/ubuntu
chmod 755 /home/ubuntu/todo_project

# Start Gunicorn
systemctl daemon-reload
systemctl start gunicorn
systemctl enable gunicorn

# Remove default nginx site
rm -f /etc/nginx/sites-enabled/default

# Create Nginx config (HTTP first)
cat > /etc/nginx/sites-available/todo_project <<EOT
server {
    listen 80;
    server_name vikastodo.in www.vikastodo.in;
    return 301 https://$host$request_uri;
    }

    location = /favicon.ico { access_log off; log_not_found off;

    location /static/ {
        root /home/ubuntu/todo_project/todo_project;
    }

    location / {
        include proxy_params;
        proxy_set_header X-Forwarded-Proto https;
        proxy_pass http://unix:/home/ubuntu/todo_project/todo_project/app.sock;
    }
}
EOT

ln -sf /etc/nginx/sites-available/django /etc/nginx/sites-enabled/

nginx -t
systemctl restart nginx

# ===============================
# 🔐 Enable HTTPS with Let's Encrypt
# ===============================

certbot --nginx \
    --non-interactive \
    --agree-tos \
    --redirect \
    --email jamandlavikaskreddy18@gmail.com \
    -d vikastodo.in \
    -d www.vikastodo.in

# Restart nginx after SSL
systemctl restart nginx
