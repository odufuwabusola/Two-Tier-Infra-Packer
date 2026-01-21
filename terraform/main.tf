terraform {
  required_version = ">=1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"

    }
  }
}

provider "aws" {
  region = "us-east-1"

}


resource "aws_instance" "java-node" {
  ami                    = "ami-02aa3c01c7c7a50e5"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.java_web.id]
  key_name               = "MasterClass2026"

  tags = {
    Name = "terraform-java-node"
  }

}

resource "aws_instance" "python-node" {
  ami                    = "ami-036c7b34d4f1fae43"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.python_web.id]
  key_name               = "MasterClass2026"

  tags = {
    Name = "terraform-python-node"
  }

}

resource "aws_instance" "nginx-node" {
  ami                    = "ami-008da92ce3b118ee8"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.nginx_web.id]
  key_name               = "MasterClass2026"

  tags = {
    Name = "terraform-nginx-node"
  }

}

resource "aws_security_group" "nginx_web" {

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "java_web" {

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 9090
    to_port     = 9090
    protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "python_web" {

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}