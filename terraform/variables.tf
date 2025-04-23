variable "bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
  default     = "gtn-s3-bucket"
}
variable "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "gtn-dynamoDB-table"
}

# Common Tags
variable "default_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    "Terraform"   = "true"
    "Project"     = "hareen"
    "Environment" = "dev"
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "hareen"
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

variable "container_tag" {
  description = "The tag of the container image to deploy."
  type        = string
  default     = "latest"
}
