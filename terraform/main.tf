terraform {
  required_version = "~> 1.3"

    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

module "tf-state" {
  source = "./modules/tf-state"
  bucket_name = var.bucket_name
  table_name = var.dynamodb_table_name
}

module "ecr" {
  source = "./modules/ecr"
  ecr_repo_name = var.ecr_repo_name
}