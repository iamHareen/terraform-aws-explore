# Common Tags
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default = {
    Project     = "demo-tag-01"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "demo-version-0011"
}


variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
  default     = "s3-terraform-aws-demo"
}
variable "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "dynamo-terraform-aws-demo"
}

variable "ecr_repo_name" {
  description = "ECR Repo Name"
  type        = string
  default     = "repo-terraform-aws-demo"
}

# VPC Variables -------------------------------------
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to deploy the subnets in"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"] # Change according to your region
}

variable "public_subnets_cidr" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# NAT Gateway Variables
variable "create_nat_gateway" {
  description = "Flag to enable or disable the creation of NAT gateways"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Flag to create a single NAT gateway for all private subnets (cost-effective for dev/test)"
  type        = bool
  default     = true # Default to true for cost savings in a university project
}

# ECR module variables
variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
  type        = string
  default     = "MUTABLE"
}

variable "encryption_type" {
  description = "The encryption type to use for the repository. Valid values are AES256 or KMS"
  type        = string
  default     = "AES256"
}

variable "force_delete" {
  description = "If true, will delete the repository even if it contains images"
  type        = bool
  default     = true  # Set to true for easier cleanup in dev environments
}

# ECS variables
variable "use_private_subnets" {
  description = "Whether to use private subnets for the ECS service"
  type        = bool
  default     = true
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the ECS tasks"
  type        = bool
  default     = false
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

variable "service_desired_count" {
  description = "Desired count of tasks in the service"
  type        = number
  default     = 1
}

variable "container_environment" {
  description = "Environment variables for the container"
  type        = list(object({
    name  = string
    value = string
  }))
  default = []
}