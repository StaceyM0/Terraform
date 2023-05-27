# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create EC2 Instance
resource "aws_instance" "jenkins_instance" {
  ami                    = "ami-0715c1897453cabd1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_jenkins.id]

  tags = {
    Name = "jenkins_instance"
  }
}

# BOOTSTRAP EC2 INSTANCE TO INSTALL/START JENKINS
resource "aws_instance" "jenkins_instance" {
  ami                    = "ami-0715c1897453cabd1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_jenkins.id]

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install java-1.8.0-openjdk -y
                sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo
                sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
                sudo yum upgrade -y
                sudo yum install jenkins -y
                sudo systemctl enable jenkins
                sudo systemctl start jenkins
              EOF

  tags = {
    Name = "jenkins_instance"
  }
}


# Create and assign a security group to the Jenkins EC2 instance
resource "aws_security_group" "sg_jenkins" {
  name_prefix = "sg_jenkins"

  # Allow incoming TCP on port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow incoming TCP on port 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg_jenkins"
  }
}

# Create an S3 bucket for Jenkins artifacts
resource "aws_s3_bucket" "jenkins_artifacts" {
  bucket = "jenkins-artifacts-${random_id.randomness.hex}"

  tags = {
    Name = "jenkins_artifacts"
  }
}

# Make the S3 bucket private
resource "aws_s3_bucket_acl" "private_jenkins_bucket" {
  bucket = aws_s3_bucket.jenkins_artifacts.id
  acl    = "private"
}

# Create random number for S3 bucket name
resource "random_id" "randomness" {
  byte_length = 4
}