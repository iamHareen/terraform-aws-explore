# modules/iam/variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod, etc.)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all IAM resources"
  type        = map(string)
  default     = {}
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository to allow access"
  type        = string
  default     = ""
}

variable "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for ECS tasks"
  type        = string
}

variable "enable_custom_task_policy" {
  description = "Whether to enable a custom IAM policy for the ECS task role"
  type        = bool
  default     = false
}

variable "custom_task_policy" {
  description = "JSON document for the custom IAM policy for the ECS task role"
  type        = string
  default     = ""
}

variable "custom_task_policy_document" {
  description = "JSON document for the custom IAM policy for the ECS task role (used internally)"
  type        = string
  default     = ""
}