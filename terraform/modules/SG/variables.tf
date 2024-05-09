#  Vpc Cidr Ip'source
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "env" {
  type        = string
  description = "Deployment Environment"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC created"
}