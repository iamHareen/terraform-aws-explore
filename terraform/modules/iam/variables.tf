# IAM module variables.tf - Variables for IAM roles and policies

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "create_ecs_service_linked_role" {
  description = "Whether to create the ECS service linked role"
  type        = bool
  default     = false
}

variable "additional_task_role_policies" {
  description = "List of additional policy ARNs to attach to the task role"
  type        = list(string)
  default     = []
}

variable "additional_execution_role_policies" {
  description = "List of additional policy ARNs to attach to the execution role"
  type        = list(string)
  default     = []
}