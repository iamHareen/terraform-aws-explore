# modules/ecr/variables.tf

variable "image_tag_mutability" {
  description = "The image tag mutability setting for the repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Whether to enable image scanning on push"
  type        = bool
  default     = false
}

variable "encryption_type" {
  description = "The encryption type to use for the repository (AES256 or KMS)"
  type        = string
  default     = "AES256"
}

variable "create_repository_policy" {
  description = "Whether to create a repository policy"
  type        = bool
  default     = false
}

variable "repository_policy" {
  description = "JSON policy document for the repository"
  type        = string
  default     = ""
}

variable "create_lifecycle_policy" {
  description = "Whether to create a lifecycle policy"
  type        = bool
  default     = true
}

variable "lifecycle_policy" {
  description = "JSON lifecycle policy document for ECR lifecycle policy"
  type        = string
  default     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 10 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

# Common variables for all modules
variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
