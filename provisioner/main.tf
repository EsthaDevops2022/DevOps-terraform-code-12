terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.61.0"
    }
  }
}

provider "aws" {
  
  region = "us-east-1"
}

resource "aws_instance" "demo1" {
  ami = "ami-033a1ebf088e56e81"
  instance_type = "t2.micro"
  key_name = "week12key"
  
}

resource "null_resource" "n1" {
  connection {
    type  = "ssh"
    user = "ec2-user"
    private_key = file(local_file.ssh_key.filename)
    host = aws_instance.demo1.public_ip
  } 
  provisioner "local-exec" {
    command = "echo hello" 
  }
  provisioner "remote-exec" {
    inline = [
        "sudo useradd serge1",
        "mkdir terraform1",
    ]
  }
  provisioner "file" {
    source = "week12key.pem"
    destination = "/tmp/key.pem"
  }
 depends_on = [ aws_instance.demo1, local_file.ssh_key ]
}
