output "vpc_owner" {
  description = "Conta que a VPC está"
  value       = aws_vpc.main_vpc.owner_id
}

output "vpc_id" {
  description = "Id da VPC"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  description = "Id da Subnet publica"
  value       = aws_subnet.public_subnet.id
}