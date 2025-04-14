

# ECR Repository for storing Docker images
# This creates a private repository in Amazon Elastic Container Registry
resource "aws_ecr_repository" "main" {
  # Repository name - must be unique in your AWS account
  name = "${var.project_name}-${var.environment}-repo00"
  
  # Enable image scanning on push to identify security vulnerabilities
  image_scanning_configuration {
    scan_on_push = true
  }

  # Enable image tag immutability to prevent overwriting existing tags
  # This is a best practice for production environments
  image_tag_mutability = var.image_tag_mutability
  
  # Enable encryption for images at rest
  encryption_configuration {
    encryption_type = var.encryption_type
  }

    # Enable force deletion to allow terraform to delete the repository even if it contains images
  # Use with caution in production environments
  force_delete = var.force_delete
  
  tags = {
    Name = "${var.project_name}-${var.environment}-repo"
  }
}

