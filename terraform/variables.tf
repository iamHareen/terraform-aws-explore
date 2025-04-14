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