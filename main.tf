# Get the manually created VPC
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Get two subnets in different AZs within the VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a" # Update with valid AMI for your region
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnets.selected.ids[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ec2_ip.txt"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet-group"
  subnet_ids = data.aws_subnets.selected.ids

  tags = {
    Name = "DBSubnetGroup"
  }
}

# RDS Database
resource "aws_db_instance" "mydb" {
  identifier              = "mydb"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "MyStrongPassword123!"
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids  = [aws_security_group.web_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = true
  multi_az                = false
}

