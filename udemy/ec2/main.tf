terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
  backend "s3" {
    bucket = "my-tfstate-bucket-joow"
    key    = "aws-ec2/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Owner      = "jonatas"
      Managed-By = "terraform"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "my-tfstate-bucket-joow"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}



### EC2 Features ###

data "aws_ami" "ubuntu_ec2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu_ec2" {
  ami = data.aws_ami.ubuntu_ec2_ami.id

  instance_type               = "t2.micro"
  associate_public_ip_address = true
  availability_zone           = var.availability_zone
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_id
  key_name = aws_key_pair.key_pair_ubuntu_ec2.key_name
  tags = {
    Name = "ec2-terraform"
  }
}

resource "aws_key_pair" "key_pair_ubuntu_ec2" {
  key_name   = "key_pair_ubuntu_ec2"
  public_key = file("/home/joow/key_pair_ubuntu_ec2.pub")
}