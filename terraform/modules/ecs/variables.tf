# # ECS module variables.tf - Variables for ECS cluster, task definition, and service

# # General
# variable "project_name" {
#   description = "Name of the project"
#   type        = string
# }

# variable "environment" {
#   description = "Environment (dev, staging, prod)"
#   type        = string
# }

# variable "aws_region" {
#   description = "AWS region"
#   type        = string
# }

# variable "tags" {
#   description = "Tags to apply to all resources"
#   type        = map(string)
#   default     = {}
# }

# # Task configuration
# variable "task_cpu" {
#   description = "CPU units for the task (for vertical scaling)"
#   type        = number
# }

# variable "task_memory" {
#   description = "Memory for the task in MiB (for vertical scaling)"
#   type        = number
# }

# variable "task_execution_role_arn" {
#   description = "ARN of the task execution role"
#   type        = string
# }

# variable "task_role_arn" {
#   description = "ARN of the task role"
#   type        = string
# }

# # Container configuration
# variable "container_name" {
#   description = "Name of the container"
#   type        = string
# }

# variable "container_image" {
#   description = "Docker image for the application"
#   type        = string
# }

# variable "container_port" {
#   description = "Port exposed by the container"
#   type        = number
# }

# variable "container_environment" {
#   description = "Environment variables for the container"
#   type        = list(map(string))
# }


# # Network configuration
# variable "vpc_id" {
#   description = "ID of the VPC"
#   type        = string
# }

# variable "subnet_ids" {
#   description = "List of subnet IDs for the ECS service"
#   type        = list(string)
# }

# variable "assign_public_ip" {
#   description = "Assign public IP to the ENI"
#   type        = bool
# }

# # Service configuration
# variable "service_desired_count" {
#   description = "Number of instances of the task to run"
#   type        = number
# }

# variable "health_check_grace_period" {
#   description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks"
#   type        = number
# }

# variable "deployment_minimum_healthy_percent" {
#   description = "Minimum healthy percent during deployment"
#   type        = number
#   # default     = 100
# }

# variable "deployment_maximum_percent" {
#   description = "Maximum percent during deployment"
#   type        = number
#   # default     = 200
# }

# # Monitoring and logging
# variable "enable_container_insights" {
#   description = "Enable CloudWatch Container Insights for the cluster"
#   type        = bool
# }

# variable "log_retention_days" {
#   description = "Number of days to retain CloudWatch logs"
#   type        = number
# }

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod, etc.)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

# Task configuration
variable "task_cpu" {
  description = "CPU units for the task (for vertical scaling)"
  type        = number
}

variable "task_memory" {
  description = "Memory for the task in MiB (for vertical scaling)"
  type        = number
}

variable "task_execution_role_arn" {
  description = "ARN of the task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the task role"
  type        = string
}

# Container configuration
variable "container_image" {
  description = "Docker image for the application"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "container_environment" {
  description = "Environment variables for the container"
  type        = list(map(string))
}

# Network configuration
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Assign public IP to the ENI"
  type        = bool
}

# Service configuration
variable "service_desired_count" {
  description = "Number of instances of the task to run"
  type        = number
}

variable "health_check_grace_period" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks"
  type        = number
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

# Monitoring and logging
variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights for the cluster"
  type        = bool
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
}