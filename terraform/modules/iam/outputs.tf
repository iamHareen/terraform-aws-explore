# modules/iam/outputs.tf
output "ecs_task_execution_role_arn" {
  description = "ARN of the task execution role used by ECS to pull images and send logs"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the task role used by the application inside containers"
  value       = aws_iam_role.ecs_task_execution_role.arn
}