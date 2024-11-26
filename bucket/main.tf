terraform {
  required_version = ">= 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "Jonatas"
      managed-by = "Terraform"
    }
  }
}


### Bucket ###

resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "my-tfstate-bucket-joow"
}

resource "aws_s3_bucket_versioning" "versioning_tfstate_bucket" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}