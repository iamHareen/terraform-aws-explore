# modules/ecs/variables.tf

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
  description = "A map of tags to apply to resources in the ECS module"
  default     = {}
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "vpc_id" {
  description = "The VPC ID where ECS resources will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "The public subnet ID for the ECS service"
  type        = string
}

variable "task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

variable "container_image" {
  description = "The container image URL"
  type        = string
}

variable "container_tag" {
  description = "The container image tag"
  type        = string
  default     = "latest"
}

variable "container_port" {
  description = "The port the container listens on"
  type        = number
  default     = 5000 # Default Flask port
}

variable "task_cpu" {
  description = "The CPU units for the ECS task"
  type        = number
  default     = 256 # 0.25 vCPU
}

variable "task_memory" {
  description = "The memory for the ECS task in MB"
  type        = number
  default     = 512 # 0.5 GB
}

variable "desired_count" {
  description = "The number of tasks to run"
  type        = number
  default     = 1
}

variable "enable_container_insights" {
  description = "Whether to enable Container Insights for the ECS cluster"
  type        = bool
  default     = false
}

variable "environment_variables" {
  description = "List of environment variables for the container"
  type        = list(map(string))
  default     = []
}

variable "secrets" {
  description = "List of secrets for the container"
  type        = list(map(string))
  default     = []
}

