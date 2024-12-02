output "ip_publico_ec2" {
  description = "IP publico da ec2"
  value       = aws_instance.ubuntu_ec2.public_ip
}