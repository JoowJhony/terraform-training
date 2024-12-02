variable "availability_zone" {
  description = "AZ de criação dos recursos"
  type        = string
  default     = "us-east-1a"
}

variable "security_group" {
  description = "Nome do Security Group"
  type        = string
  default     = "ec2-sg"
}

variable "meu_ip" {
  description = "IP para acesso SSH a instância"
  type        = string
  default     = "177.172.61.64/32"
}
variable "vpc_id" {
  description = "ID da VPC que será herado do root module"
  type        = string
  default     = ""
}

variable "public_subnet_id" {
  description = "ID da subnet publica que será herado do root module"
  type        = string
  default     = ""
}