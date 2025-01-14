terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.1"
    }
  }
}
#указать в readme, что нужно настроить aws cli
provider "aws" {
  shared_config_files      = ["/home/user/.aws/config"]
  shared_credentials_files = ["/home/user/.aws/credentials"]
  region                   = "us-east-1"
}

data "http" "my_public_ip" {
  url = "http://checkip.amazonaws.com"
}

resource "aws_key_pair" "deployer1" {
  key_name   = var.aws_key_name
  public_key = file(var.ssh_pkey_file)
}

resource "aws_security_group" "allow_my_ip" {
  name   = var.ec2_sgroup
  vpc_id = var.vpc_id
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [replace(data.http.my_public_ip.response_body, "\n", "") + "/32"]
    }
  }
  
}

resource "aws_instance" "example_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.allow_my_ip.id]
  associate_public_ip_address = true
  iam_instance_profile        = var.iam_role_name

  root_block_device {
    volume_type           = var.ec2_vol_type
    volume_size           = var.ec2_vol_size
    delete_on_termination = true
  }

  key_name  = var.aws_key_name
  user_data = file("userdata.tpl")

  tags = {
    Name = var.ec2_inst_name
  }
}

output "aws_instance_public_dns" {
  value = aws_instance.example_instance.public_ip
}
