# main.tf - Root Module

# module "tf-state" {
#   source = "./modules/tf-state"
#   bucket_name = var.bucket_name
#   table_name = var.dynamodb_table_name
# }

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone

  project_name = var.project_name
  environment  = var.environment
  tags         = var.default_tags
}

# ECR Module - Container registry for Docker images
module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.default_tags

  image_tag_mutability     = var.image_tag_mutability
  scan_on_push             = var.scan_on_push
  encryption_type          = var.encryption_type
  force_delete             = var.force_delete
  create_repository_policy = var.create_repository_policy
  repository_policy        = var.repository_policy
  create_lifecycle_policy  = var.create_lifecycle_policy
  lifecycle_policy         = var.lifecycle_policy
}

# CloudWatch Log Group for ECS
# resource "aws_cloudwatch_log_group" "ecs_logs" {
#   name              = "/ecs/${var.project_name}-${var.environment}"
#   retention_in_days = var.ecs_log_retention_days
#   tags              = var.default_tags
# }

module "iam" {
  source = "./modules/iam"
  
  project_name  = var.project_name
  environment   = var.environment
  tags          = var.default_tags
  
  ecr_repository_arn = module.ecr.repository_arn
  cloudwatch_log_group_arn = "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/ecs/${var.project_name}-${var.environment}:*"
  custom_task_policy_document = var.enable_custom_task_policy ? var.custom_task_policy : ""
}

# AWS Account ID for resource ARNs
data "aws_caller_identity" "current" {}

module "ecs" {
  source = "./modules/ecs"
  
  # Basic configuration
  project_name           = var.project_name
  environment            = var.environment
  aws_region             = var.aws_region
  
  # Task configuration
  task_cpu               = var.ecs_task_cpu
  task_memory            = var.ecs_task_memory
  task_execution_role_arn = module.iam.task_execution_role_arn
  task_role_arn          = module.iam.task_role_arn
  
  # Container configuration
  container_image        = "${module.ecr.repository_url}:latest"
  container_port         = var.ecs_container_port
  container_environment  = var.ecs_container_environment
  
  # Service configuration
  service_desired_count  = var.ecs_service_desired_count
  health_check_grace_period = var.ecs_health_check_grace_period
  deployment_minimum_healthy_percent = var.ecs_deployment_minimum_healthy_percent
  deployment_maximum_percent = var.ecs_deployment_maximum_percent
  
  # Network configuration - UPDATED FOR SINGLE SUBNET
  vpc_id                 = module.vpc.vpc_id
  subnet_ids           = [module.vpc.private_subnet_id] # Use private subnet for ECS tasks
  assign_public_ip       = var.ecs_assign_public_ip
  
  # Monitoring and logging
  enable_container_insights = var.ecs_enable_container_insights
  log_retention_days     = var.ecs_log_retention_days
  
  # Tags
  tags                   = var.default_tags
}