variable "env" {
  type        = string
  description = "Deployment Environment"
}

variable "instance_type" {
  type        = string
  description = "Deployment Environment"
}

variable "public_subnet" {
  type        = list(string)
  description = "Public subnet to deploy Bastion into"
}

variable "bastion_sg" {
  type        = string
  description = "Security group to use for Bastion"
}

variable "vm_sg" {
  type        = string
  description = "Security group to use for ASG launch templates"
}