# Common Tags
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default = {
    Project     = "terraform-aws-demo"
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
  default     = "terraform-aws-demo"
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

# Add additional variables for ECR and ECS modules as needed