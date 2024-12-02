### Security Group Features ###

resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.security_group
  }
}

resource "aws_vpc_security_group_egress_rule" "ec2_outbound_all" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_ingress_rule" "ec2_inbound_ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = var.meu_ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "ec2_inbound_icmp" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  ip_protocol       = "icmp"
  to_port           = -1
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
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  subnet_id                   = var.public_subnet_id
  # key_name = aws_key_pair.key_pair_ubuntu_ec2.key_name
  tags = {
    Name = "ec2-terraform"
  }
}

# resource "aws_key_pair" "key_pair_ubuntu_ec2" {
#   key_name   = "key_pair_ubuntu_ec2"
#   public_key = file("/home/joow/key_pair_ubuntu_ec2.pub")
# }