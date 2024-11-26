variable "availability_zone" {
  description = "Zona de Disponibilidade de criação dos recursos"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_name" {
  description = "Nome da Virtual Private Cloud (VPC)"
  type        = string
  default     = "main_vpc"
}

variable "vpc_cidr" {
  description = "Range de IP da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "internet_gateway_name" {
  description = "Nome do Internet Gateway (IGW)"
  type        = string
  default     = "main_igw"
}

variable "subnets_name" {
  description = "Nome da Subnet Public ou Privada"
  type        = string
  default     = ""
}

variable "nat_gateway_elastic_ip_name" {
  description = "Nome do Elastic IP para Nat Gateway"
  type        = string
  default     = "main_nat_eip"
}

variable "nat_gateway_name" {
  description = "Nome do Nat Gateway"
  type        = string
  default     = "main_nat_gateway"
}
