variable "env" {
  type        = string
  description = "Deployment Environment"
}

variable "private_subnet" {
  type        = list(string)
  description = "Private subnet to launch ASG into"
}

variable "vm_launch_template_id" {
  type        = string
  description = "Launch template ID to use for ASG"
}

variable "vm_launch_template_latest_version" {
  type        = string
  description = "Launch template version to use for ASG"
}

variable "alb_target_group_arn" {
  type        = list(string)
  description = "ARN for attaching ASG to target group"
}