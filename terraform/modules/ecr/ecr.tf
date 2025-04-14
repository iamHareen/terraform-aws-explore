resource "aws_ecr_repository" "main" {
  name = var.ecr_repo_name
}