packer {
  required_version = ">=1.9.0"

  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.0"
    }
  }
}

# ------------------------------------------------
# Sources
# -------------------------------------------------

source "amazon-ebs" "nginx-git" {
  region                  = "us-east-1"
  instance_type           = "t3.micro"
  ssh_username            = "ec2-user"
  source_ami              = "ami-07ff62358b87c7116"
  ami_name                = "nginx-git-by-packer2"
  ami_virtualization_type = "hvm"
}

source "amazon-ebs" "python-git" {
  region                  = "us-east-1"
  instance_type           = "t3.micro"
  ssh_username            = "ec2-user"
  source_ami              = "ami-07ff62358b87c7116"
  ami_name                = "python-git-by-packer2"
  ami_virtualization_type = "hvm"
}

source "amazon-ebs" "java-git" {
  region                  = "us-east-1"
  instance_type           = "t3.micro"
  ssh_username            = "ec2-user"
  source_ami              = "ami-07ff62358b87c7116"
  ami_name                = "java-git-by-packer-2"
  ami_virtualization_type = "hvm"
}

 

build {
  name    = "nginx-git-ami-build"
  sources = ["source.amazon-ebs.nginx-git"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx git",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo '<h1>Hello from B-cube - Built by Packer</h1>' | sudo tee /usr/share/nginx/html/index.html"
    ]
  }

  post-processor "shell-local" {
    inline = ["echo 'AMI build is finished for Nginx'"]
  }
}

build {
  name    = "python-git-ami-build"
  sources = ["source.amazon-ebs.python-git"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y python3 git",
      "python3 --version"
    ]
  }

  post-processor "shell-local" {
    inline = ["echo 'AMI build is finished for Python'"]
  }
}

build {
  name    = "java-git-ami-build"
  sources = ["source.amazon-ebs.java-git"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y java-17-amazon-corretto git",
      "java -version"
    ]
  }

  post-processor "shell-local" {
    inline = ["echo 'AMI build is finished for Java'"]
  }
}