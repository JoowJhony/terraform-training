output "ec2_id" {
  description = "ID da EC2"
  value = aws_instance.ubuntu_ec2.id
}

output "vpc_owner" {
  description = "Conta que a VPC está"
  value = aws_vpc.main_vpc.owner_id
}
