
# ECR Repository creation
resource "aws_ecr_repository" "main" {
  name                 = "${var.project_name}-${var.environment}-repo"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
  }
  force_delete = var.force_delete
  tags = {
    Name = "${var.project_name}-${var.environment}-repo"
  }
}


# Repository policy
resource "aws_ecr_repository_policy" "policy" {
  count      = var.create_repository_policy ? 1 : 0
  repository = aws_ecr_repository.main.name
  policy     = var.repository_policy
}


# Lifecycle policy
resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  count      = var.create_lifecycle_policy ? 1 : 0
  repository = aws_ecr_repository.main.name
  policy     = var.lifecycle_policy
}

