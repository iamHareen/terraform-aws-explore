# main.tf - Root Module

# module "tf-state" {
#   source = "./modules/tf-state"
#   bucket_name = var.bucket_name
#   table_name = var.dynamodb_table_name
# }

module "vpc" {
  source       = "./modules/vpc"
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
}

module "cloudwatch" {
  source            = "./modules/cloudwatch"
  project_name      = var.project_name
  environment       = var.environment
  tags              = var.default_tags
}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment
  tags         = var.default_tags

  ecr_repository_arn          = module.ecr.repository_arn
  cloudwatch_log_group_arn    = module.cloudwatch.log_group_arn
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
  tags                   = var.default_tags


  # Task configuration
  task_cpu               = var.ecs_task_cpu
  task_memory            = var.ecs_task_memory
  task_execution_role_arn = module.iam.task_execution_role_arn
  task_role_arn          = module.iam.task_role_arn
  cloudwatch_log_group_name = module.cloudwatch.log_group_name

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

  # Monitoring and logging
  enable_container_insights = var.ecs_enable_container_insights

}