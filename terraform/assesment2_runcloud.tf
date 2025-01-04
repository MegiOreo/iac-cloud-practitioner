# Provider Configuration
provider "aws" {
  region     = "ap-southeast-1"
  access_key = ""
  secret_key = ""
}

# Security Group
resource "aws_security_group" "kimi_sg" {
  name        = "kimi-vpc-security-group"
  description = "Allow SSH and HTTP access"

  # SSH Ingress Rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access from anywhere"
  }

  # HTTP Ingress Rule
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access from anywhere"
  }

  # Egress Rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "DefaultVPCSecurityGroup"
  }
}

# First EC2 Instance
resource "aws_instance" "kimiEC2_1" {
  ami           = ""
  instance_type = "t2.micro"
  key_name      = "kimikt"

  vpc_security_group_ids = [aws_security_group.kimi_sg.id]

  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_size = 10
    volume_type = "gp2"
  }

  tags = {
    Name = "Kimi-Terraform-EC2-Instance-1"
  }
}

# Second EC2 Instance
resource "aws_instance" "kimiEC2_2" {
  ami           = ""
  instance_type = "t2.micro"
  key_name      = "kimikt"

  vpc_security_group_ids = [aws_security_group.kimi_sg.id]

  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_size = 10
    volume_type = "gp2"
  }

  tags = {
    Name = "Kimi-Terraform-EC2-Instance-2"
  }
}