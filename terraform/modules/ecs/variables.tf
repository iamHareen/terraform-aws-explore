# ECS module variables.tf - Variables for ECS cluster, task definition, and service

# General
variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Network
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the task"
  type        = bool
  default     = false
}

# ECS Cluster
variable "enable_container_insights" {
  description = "Whether to enable container insights for the cluster"
  type        = bool
  default     = false
}

# Task Definition
variable "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "task_cpu" {
  description = "CPU units for the task (e.g., 256)"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory for the task in MiB (e.g., 512)"
  type        = number
  default     = 512
}

variable "container_image_url" {
  description = "URL of the container image repository"
  type        = string
}

variable "container_image_tag" {
  description = "Tag of the container image"
  type        = string
  default     = "latest"
}

variable "container_port" {
  description = "Port on which the container is listening"
  type        = number
  default     = 80
}

variable "container_environment" {
  description = "Environment variables for the container"
  type        = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "log_retention_days" {
  description = "Number of days to retain log events"
  type        = number
  default     = 30
}

# ECS Service
variable "service_desired_count" {
  description = "Desired count of tasks in the service"
  type        = number
  default     = 1
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum healthy percent during deployment"
  type        = number
  default     = 100
}

variable "deployment_maximum_percent" {
  description = "Maximum percent during deployment"
  type        = number
  default     = 200
}