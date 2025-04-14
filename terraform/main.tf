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
  create_nat_gateway = var.create_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  tags = var.default_tags
}

# ECR Module - Container registry for Docker images
module "ecr" {
  source = "./modules/ecr"
  
  # Pass variables to the ECR module
  project_name        = var.project_name
  environment         = var.environment
  image_tag_mutability = var.image_tag_mutability
  encryption_type     = var.encryption_type
  force_delete        = var.force_delete
}
