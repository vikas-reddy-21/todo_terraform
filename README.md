# Terraform Django Deployment

This project provisions AWS infrastructure using Terraform.

Infrastructure created:
- VPC
- Public Subnet
- Internet Gateway
- Route Table
- EC2 Instance
- Elastic IP

The EC2 instance automatically deploys a Django Todo application using userdata.sh.

Technologies:
- Terraform
- AWS EC2
- Nginx
- Gunicorn
- Django

----------------------------------------------------------------------
Django To-Do Application – Cloud Deployment Project
Project Overview
========================================================
This is a simple To-Do web application that I built using the Django framework with Python.
The main purpose of this project is to help users manage their daily tasks by allowing them to create, update, complete, and delete tasks.

In this project, I also practiced deploying a real application to the cloud using Amazon Web Services. The application is hosted on an Amazon EC2 instance.

For the production setup, I used:


1.Nginx as the web server

2.Gunicorn as the application server

3.Terraform to create and manage AWS infrastructure

The main goal of this project was to learn Django development, cloud deployment, and basic DevOps practices.

Live Application
========================================    

http://vikastodo.com   # I stoped the resourse Because i am using free aws account to avoid billing 


Project Features
============================================
This application provides the following features:

-Add new tasks

-View all tasks

-Update existing tasks

-Delete tasks

-Mark tasks as completed

-Store tasks in a database


Deploy the application on AWS cloud
=========================================

            Project Architecture
            User Browser
                │
                ▼
            Nginx
            (Reverse Proxy)
                │
                ▼
            Gunicorn
            (Application Server)
                │
                ▼
            Django App
                │
                ▼
            SQLite Database


In this setup:
-->Nginx receives requests from users
-->It forwards the request to Gunicorn
-->Gunicorn runs the Django application
-->Django interacts with the SQLite database

This architecture helps in handling requests efficiently and makes the application ready for production deployment.

Technologies Used
====================================
1.Backend

 -->Python
 
 -->Django

2.Web Server

 -->Nginx
 
 -->Gunicorn

3.Cloud Platform

 -->AWS EC2

4.Infrastructure Automation

 -->Terraform

5.Version Control

 -->Git
 
 -->GitHub

Infrastructure Setup
===========================================
The AWS infrastructure for this project is created using Terraform.

Terraform automatically provisions the required resources in AWS such as:


•VPC

•Subnet

•Internet Gateway

•Route Table

•Security Groups

•EC2 Instance


Using Terraform helps in managing infrastructure using Infrastructure as Code (IaC), which makes the setup easier to recreate and maintain.

Deployment Steps
=============================================
1. Clone the Repository
   
    git clone https://github.com/your-username/todo-project.git
   
    cd todo-project

2. Install Dependencies
     pip install -r requirements.txt

3. Run Database Migrations
   
    python manage.py migrate

4. Start the Development Server

    python manage.py runserver

5. Production Deployment


For production, configure the following:

    •Gunicorn service
    •Nginx reverse proxy
    •Domain name configuration
    •SSL setup (optional)


What I Learned From This Project
=========================================

1.While working on this project, I learned:

2.How to build web applications using Django

3.How to deploy applications on AWS cloud

4.How Nginx works as a reverse proxy

5.How to run Django with Gunicorn in production

6.How to automate infrastructure using Terraform

7.How to manage project code using Git and GitHub



Future Improvements
===========================================
Some improvements I plan to add in the future:

•User authentication system

•REST API support

•Containerization using Docker

•CI/CD pipeline using GitHub Actions

•HTTPS support using SSL certificates

Author
===============
Jamanla Vikas Reddy

