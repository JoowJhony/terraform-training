resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "igw_main_vpc" {
  vpc_id = aws_vpc.main_vpc.id
}

