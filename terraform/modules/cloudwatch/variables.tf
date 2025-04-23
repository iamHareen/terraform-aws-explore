# modules/cloudwatch/variables.tf
variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, prod)"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to resources"
  default     = {}
}

variable "log_retention_days" {
  type        = number
  description = "The number of days to retain CloudWatch logs"
  default     = 1
}