

resource "aws_vpc" "week5-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "week5-vpc"
  }
}

resource "aws_subnet" "public-week5-subnet" {
  vpc_id            = aws_vpc.week5-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-week5-subnet"
  }
}

resource "aws_subnet" "private-week5-subnet" {
  vpc_id            = aws_vpc.week5-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-week5-subnet"
  }
}

resource "aws_instance" "nginx" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"
  subnet_id              = aws_subnet.public-week5-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = "MasterClass2026"
  tags = {
    Name = "Nginx"
  }
}

resource "aws_instance" "python" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"
  subnet_id              = aws_subnet.private-week5-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = "MasterClass2026"
  tags = {
    Name = "python"
  }
}

resource "aws_instance" "java" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"
  subnet_id              = aws_subnet.private-week5-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = "MasterClass2026"
  tags = {
    Name = "java"
  }
}