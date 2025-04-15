# --------- vpc outputs ----------
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "public subnet ID"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "private subnet ID"
  value       = module.vpc.private_subnet_id
}

# --------- ecr outputs ----------
output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  description = "The name of the ECR repository"
  value       = module.ecr.repository_name
}

output "ecr_repository_registry_id" {
  description = "The registry ID where the ECR repository was created"
  value       = module.ecr.registry_id
}

output "ecr_repository_arn" {
  description = "The ARN of the ECR repository"
  value       = module.ecr.repository_arn
}

# --------- cloudwatch outputs ----------
output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = module.cloudwatch.log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group"
  value       = module.cloudwatch.log_group_arn
}

# --------- iam outputs ----------
# IAM Role Outputs
output "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = module.iam.task_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = module.iam.task_role_arn
}

output "ecs_execution_role_name" {
  description = "Name of the ECS task execution role"
  value       = module.iam.task_execution_role_name
}

output "ecs_task_role_name" {
  description = "Name of the ECS task role"
  value       = module.iam.task_role_name
}

# ECS outputs
output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.service_name
}

output "ecs_task_definition_family" {
  description = "Family of the ECS task definition"
  value       = module.ecs.task_definition_family
}
