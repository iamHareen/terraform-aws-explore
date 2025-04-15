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
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to run the ECS service in"
}

variable "assign_public_ip" {
  type        = bool
  description = "Whether to assign public IP addresses to the Fargate tasks"
  default     = false
}

variable "enable_container_insights" {
  type        = bool
  description = "Whether to enable Container Insights for the ECS cluster"
  default     = false
}

variable "task_cpu" {
  type        = string
  description = "The amount of CPU to assign to the task (e.g., 256, 512)"
  default     = "256"
}

variable "task_memory" {
  type        = string
  description = "The amount of memory (in MiB) to assign to the task (e.g., 512, 1024)"
  default     = "512"
}

variable "task_execution_role_arn" {
  type        = string
  description = "The ARN of the ECS task execution IAM role"
  # No sensible default, must be provided
}

variable "task_role_arn" {
  type        = string
  description = "The ARN of the ECS task IAM role"
  # No sensible default, must be provided
}

variable "container_image" {
  type        = string
  description = "The Docker image to run in the container"
  # No sensible default, must be provided
}

variable "container_port" {
  type        = number
  description = "The port the container exposes"
  default     = 80
}

variable "container_environment" {
  type        = list(object({
    name  = string
    value = string
  }))
  description = "A list of environment variables for the container"
  default     = []
}

variable "cloudwatch_log_group_name" {
  type        = string
  description = "The name of the CloudWatch Log Group for ECS tasks"
  # No sensible default, must be provided
}

variable "service_desired_count" {
  type        = number
  description = "The desired number of tasks to run in the service"
  default     = 1
}

variable "health_check_grace_period" {
  type        = number
  description = "The grace period for service health checks (in seconds)"
  default     = 0
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  description = "The minimum percentage of healthy tasks during deployments"
  default     = 100
}

variable "deployment_maximum_percent" {
  type        = number
  description = "The maximum percentage of tasks (as a percentage of desiredCount) that can be deployed at once"
  default     = 200
}