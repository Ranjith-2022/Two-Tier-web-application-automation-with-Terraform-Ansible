#  Vpc Cidr Ip'source
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.250.0.0/16"
}

#  Public Subnets
variable "private_subnets" {
  description = "private subnet arguments"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = [
    {
      cidr_block        = "10.250.0.0/24"
      availability_zone = "us-east-1b"
    },
    {
      cidr_block        = "10.250.1.0/24"
      availability_zone = "us-east-1c"
    },
    {
      cidr_block        = "10.250.2.0/24"
      availability_zone = "us-east-1d"
    }
  ]
}

variable "public_subnets" {
  description = "public subnet arguments"
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = [
    {
      cidr_block        = "10.250.3.0/24"
      availability_zone = "us-east-1b"
    },
    {
      cidr_block        = "10.250.4.0/24"
      availability_zone = "us-east-1c"
    },
    {
      cidr_block        = "10.250.5.0/24"
      availability_zone = "us-east-1d"
    }
  ]
}

# Environment
variable "env" {
  default     = "production"
  type        = string
  description = "Deployment Environment"
}

variable "instance_type" {
  default     = "t3.medium"
  type        = string
  description = "Deployment Environment"
}