terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
  backend "s3" {
    bucket = "joow-bucket-terraform-trainig"
    key    = "ec2-vpc-modules/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Managed-By = "terraform"
    }
  }
}

module "instance" {
  source = "./ec2"
  vpc_id = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
}

module "network" {
  source = "./vpc"
}