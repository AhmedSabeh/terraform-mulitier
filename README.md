🏗️ Multi-Tier Application Deployment with Terraform
This project demonstrates how to deploy a multi-tier architecture on AWS using Terraform. It includes the use of EC2, RDS, subnets in different Availability Zones, a VPC data block, and a local provisioner to output the EC2 IP address.

📦 What This Project Does
Uses an existing manually created VPC named ivolve

Retrieves the VPC ID using a Terraform data block

Defines two subnets across different Availability Zones (AZs)

Creates an EC2 instance (web server) in one of the subnets

Creates an RDS MySQL database inside a subnet group spanning the 2 AZs

Sets up a security group allowing HTTP (80) and SSH (22) access

Uses a local provisioner to write the EC2 public IP to a file called ec2_ip.txt

Outputs the EC2 public IP and the RDS endpoint

📁 Terraform File Breakdown
provider.tf: Specifies the AWS provider and region

variables.tf: Defines variables such as VPC name and AZs

main.tf: Contains the core infrastructure configuration including:

Data source for existing VPC and subnets

EC2 instance

RDS database with subnet group

Security groups

outputs.tf: Displays the EC2 IP and RDS endpoint after apply

ec2_ip.txt: Automatically generated file with EC2 IP (via local-exec provisioner)
