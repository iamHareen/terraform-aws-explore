variable "bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
  default     = "assignment-s3-bucket"
}
variable "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "assignment-dynamoDB-table"
}

# Common Tags
variable "default_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    "Terraform"   = "true"
    "Project"     = "terraform-aws-assignment"  
    "Environment" = "dev"
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-aws-assignment" 
}

variable "environment" {
  description = "Environment (dev, staging, prod, etc.)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# ----------------- IAM Variables -----------------------------
variable "enable_custom_task_policy" {
  description = "Whether to create a custom task policy"
  type        = bool
  default     = false
}

variable "custom_task_policy" {
  description = "Custom IAM policy document for the ECS task role"
  type        = string
  default     = ""
}


# ----------------- ECS Variables -----------------------------
variable "ecs_task_cpu" {
  description = "CPU units for the task (for vertical scaling)"
  type        = number
  default     = 256
  # Valid values: 256, 512, 1024, 2048, 4096, 8192, 16384
}

variable "ecs_task_memory" {
  description = "Memory for the task in MiB (for vertical scaling)"
  type        = number
  default     = 512
  # Valid values: 512, 1024, 2048, 4096, 8192, 16384
}

variable "container_tag" {
  type        = string
  description = "The tag of the Docker image to run in the container"
  default     = "latest"
}

variable "ecs_container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 80
}

variable "ecs_container_environment" {
  description = "Environment variables for the container"
  type        = list(map(string))
  default = [
    {
      name  = "ENV_VAR_NAME", 
      value = "ENV_VAR_VALUE"
    }
  ]
}

variable "ecs_service_desired_count" {
  description = "Number of instances of the task to run"
  type        = number
  default     = 1
}


variable "ecs_health_check_grace_period" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks"
  type        = number
  default     = 0
}

variable "ecs_deployment_minimum_healthy_percent" {
  description = "Minimum healthy percent during deployment"
  type        = number
  default     = 60
}

variable "ecs_deployment_maximum_percent" {
  description = "Maximum percent during deployment"
  type        = number
  default     = 200
}

variable "ecs_enable_container_insights" {
  description = "Enable CloudWatch Container Insights for the cluster"
  type        = bool
  default     = true
}

variable "ecs_log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 30
}