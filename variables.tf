variable "vpc_east1" {
  type = string
  default = "10.0.0.0/16"

}

# variaveis de subnet Publicas
variable "subnet1_public" {
  description = "public subnet 1 cider block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet2_public" {
  description = "public subnet 2 cidr block"
  type        = string
  default     = "10.0.2.0/24"
}

# variaveis de subnet Privadas
variable "subnet1_private" {
  description = "private subnet1 cidr block"
  type        = string
  default     = "10.0.3.0/24"
}

variable "subnet2_private" {
  description = "private subnet2 cidr block"
  type        = string
  default     = "10.0.4.0/24"
}

variable "aws_internet_gateway" {
  type = string
  default = "igw"
}

