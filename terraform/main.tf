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
  subnet_id              = aws_subnet.public-week5-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = "MasterClass2026"

  tags = {
    Name = "terraform-java-node"
  }

}

resource "aws_instance" "python-node" {
  ami                    = "ami-036c7b34d4f1fae43"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public-week5-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = "MasterClass2026"

  tags = {
    Name = "terraform-python-node"
  }

}

resource "aws_instance" "nginx-node" {
  ami                    = "ami-008da92ce3b118ee8"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public-week5-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = "MasterClass2026"

  tags = {
    Name = "terraform-nginx-node"
  }

}

