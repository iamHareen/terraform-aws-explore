# modules/iam/outputs.tf

output "task_execution_role_arn" {
  description = "ARN of the ECS Task Execution IAM Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "task_execution_role_name" {
  description = "Name of the ECS Task Execution IAM Role"
  value       = aws_iam_role.ecs_task_execution_role.name
}

output "task_role_arn" {
  description = "ARN of the ECS Task IAM Role"
  value       = aws_iam_role.ecs_task_role.arn
}

output "task_role_name" {
  description = "Name of the ECS Task IAM Role"
  value       = aws_iam_role.ecs_task_role.name
}