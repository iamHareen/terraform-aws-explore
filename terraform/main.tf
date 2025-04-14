# This is the main Terraform configuration file for the project.

# module "tf-state" {
#   source = "./modules/tf-state"
#   bucket_name = var.bucket_name
#   table_name = var.dynamodb_table_name
# }

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr

  # NAT Gateway configuration
  # create_nat_gateway = var.create_nat_gateway
  # single_nat_gateway = var.single_nat_gateway

  tags = var.default_tags
}

# ECR Module - Container registry for Docker images
module "ecr" {
  source = "./modules/ecr"

  # Pass variables to the ECR module
  project_name         = var.project_name
  environment          = var.environment
  image_tag_mutability = var.image_tag_mutability
  encryption_type      = var.encryption_type
  force_delete         = var.force_delete
}

# IAM Module - Roles and policies for ECS
module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment
  tags         = var.default_tags

  # Set to true if you need to create the service-linked role
  create_ecs_service_linked_role = false
}


# ECS Module - Cluster, task definition, and service
module "ecs" {
  source = "./modules/ecs"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  # Network configuration
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = var.use_private_subnets ? module.vpc.private_subnet_ids : module.vpc.public_subnet_ids
  assign_public_ip = var.assign_public_ip

  # IAM roles from IAM module
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn

  # Container configuration
  container_image_url   = module.ecr.repository_url
  container_image_tag   = var.container_image_tag
  container_port        = var.container_port
  task_cpu              = var.task_cpu
  task_memory           = var.task_memory
  service_desired_count = var.service_desired_count

  # Add any additional container environment variables if needed
  container_environment = var.container_environment

  tags = var.default_tags
}

