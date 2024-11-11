output "vpc_owner" {
  description = "Conta que a VPC está"
  value       = aws_vpc.main_vpc.owner_id
}

output "public_subnet_id" {
  description = "Id da Subnet publica"
  value       = aws_subnet.public_subnet.id
}

output "security_group_id" {
  description = "Id do Security Group"
  value       = aws_security_group.ec2_sg.id
}