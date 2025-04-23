# main.tf - Root Module

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.default_tags
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.default_tags
}

module "cloudwatch" {
  source       = "./modules/cloudwatch"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.default_tags
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.default_tags
}


module "ecs" {
  source       = "./modules/ecs"
  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
  tags         = var.default_tags

  vpc_id                  = module.vpc.vpc_id
  public_subnet_id        = module.vpc.public_subnet_id
  task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  container_image         = "${module.ecr.repository_url}:${var.container_tag}"
  cloudwatch_log_group_name = module.cloudwatch.ecs_logs_group_name

  depends_on = [
    module.vpc,
    module.iam,
    module.ecr
  ]
}
