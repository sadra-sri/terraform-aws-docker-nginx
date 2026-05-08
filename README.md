# Terraform AWS Docker Nginx

This project provisions an AWS EC2 instance using Terraform, installs Docker automatically, and deploys an Nginx container.

## Technologies Used

- Terraform
- AWS EC2
- Docker
- Nginx
- Git & GitHub

## Features

- Infrastructure as Code with Terraform
- Automatic Docker installation
- Automatic Nginx deployment
- Security Group configuration
- Public web access on port 8080

## Architecture

User Browser
↓
AWS EC2 Instance
↓
Docker Container
↓
Nginx Web Server

## Usage

```bash
terraform init
terraform apply

Access the application from:

http://PUBLIC_IP:8080
