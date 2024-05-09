#  Vpc Cidr Ip'source
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

#  Public Subnets
variable "private_subnets" {
  description = "private subnet arguments"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "public_subnets" {
  description = "public subnet arguments"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
}

# Environment
variable "env" {
  type        = string
  description = "Deployment Environment"
}