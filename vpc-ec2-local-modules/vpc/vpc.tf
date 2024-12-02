### VPC Features ###

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

### Subnet Features ###


### Public Subnet

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.subnets_name}public_subnet"
  }
}

# resource "aws_eip" "nat_eip" {
#   domain = "vpc"
#   tags = {
#     Name = var.nat_gateway_elastic_ip_name
#   }
# }

# resource "aws_nat_gateway" "main_nat_gateway" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public_subnet.id
#   depends_on    = [aws_internet_gateway.internet_gateway]
#   tags = {
#     Name = var.nat_gateway_name
#   }
# }


resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "${var.subnets_name}public_route_table"
  }
}

resource "aws_route_table_association" "public-rt-association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

### Private Subnet

# resource "aws_subnet" "private_subnet" {
#   vpc_id            = aws_vpc.main_vpc.id
#   cidr_block        = var.private_subnet_cidr
#   availability_zone = var.availability_zone
#   tags = {
#     Name = "${var.subnets_name}private_subnet"
#   }
# }

# resource "aws_route_table" "private_subnet_route_table" {
#   vpc_id = aws_vpc.main_vpc.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.main_nat_gateway.id
#   }
#   tags = {
#     Name = "${var.subnets_name}private_route_table"
#   }
# }

# resource "aws_route_table_association" "private_rt_association" {
#   subnet_id      = aws_subnet.private_subnet.id
#   route_table_id = aws_route_table.private_subnet_route_table.id
# }