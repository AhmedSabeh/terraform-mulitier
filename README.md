# 🏗️ Multi-Tier Application Deployment with Terraform

This project demonstrates a basic multi-tier architecture on AWS using Terraform.

## 📌 What It Does

- Uses an existing VPC called **"ivolve"**
- Creates 2 subnets across different AZs
- Deploys an EC2 instance in one subnet
- Deploys an RDS MySQL database in a DB subnet group
- Stores the EC2 public IP locally in `ec2_ip.txt`

## 📁 Files

- `provider.tf` – Sets the AWS region
- `variables.tf` – Declares input variables
- `main.tf` – All resources (data sources, EC2, RDS, security groups)
- `outputs.tf` – Useful info like EC2 IP and RDS endpoint
- `ec2_ip.txt` – Auto-generated file with the EC2 IP

## 🚀 How to Use

1. **Create the VPC manually** in AWS and name it `ivolve`
2. **Initialize Terraform**
   ```bash
   terraform init
