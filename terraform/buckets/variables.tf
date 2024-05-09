variable "env" {
  type        = list(string)
  default     = ["staging", "production"]
  description = "Deployment Environment"
}