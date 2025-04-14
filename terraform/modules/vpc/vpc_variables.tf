# modles/vpc/variables.tf
# VPC Module - Variables

# Project Information
variable "project_name" {
  description = "The name of the project (used in tagging AWS resources)"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "Valid values for environment are: dev, test, staging, prod."
  }
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The VPC CIDR block must be a valid CIDR notation."
  }
}

# Subnets Configuration
variable "availability_zones" {
  description = "List of availability zones to deploy the subnets in"
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  validation {
    condition     = length(var.public_subnets_cidr) > 0
    error_message = "At least one public subnet CIDR block must be provided."
  }
}

variable "private_subnets_cidr" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
  validation {
    condition     = length(var.private_subnets_cidr) > 0
    error_message = "At least one private subnet CIDR block must be provided."
  }
}

# NAT Gateway Configuration
variable "create_nat_gateway" {
  description = "Flag to enable or disable the creation of NAT gateways"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Flag to create a single NAT gateway for all private subnets (cost-effective for dev/test)"
  type        = bool
  default     = false
}

# Tags
variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
