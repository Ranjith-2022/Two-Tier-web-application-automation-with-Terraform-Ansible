variable "tags" {
  default = {
    service = "shadowy_inspiration"
  }
  type        = map(string)
  description = "Extra tags to attach to the alb-asg resources"
}

variable "vm_sg" {
  type        = list(string)
  description = "Security group id of the ec2 instance"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to use for the resources."
}

variable "public_subnet" {
  type        = list(string)
  description = "Private subnet that ASG is in"
}

variable "env" {
  type        = string
  description = "The environment name for the resources."
}