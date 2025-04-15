variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod, etc.)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository to grant access to"
  type        = string
  default     = ""
}

variable "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for task logs"
  type        = string
  default     = "*"
}

variable "custom_task_policy_document" {
  description = "Custom IAM policy document for the ECS task role"
  type        = string
  default     = ""
}

variable "execution_role_name" {
  description = "Name for the ECS task execution role"
  type        = string
  default     = ""
}

variable "task_role_name" {
  description = "Name for the ECS task role"
  type        = string
  default     = ""
}