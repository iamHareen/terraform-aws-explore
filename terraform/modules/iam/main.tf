# modules/iam/main.tf

# ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-task-execution-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# Attach the AmazonECSTaskExecutionRolePolicy
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# ECR Access Policy for ECS Execution Role
resource "aws_iam_policy" "ecr_access" {
  name        = "${var.project_name}-ecr-access-policy-${var.environment}"
  description = "Policy to allow ECS to pull images from ECR"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = var.ecr_repository_arn != "" ? var.ecr_repository_arn : "*"
      }
    ]
  })

  tags = var.tags
}

# Attach ECR Access Policy to Execution Role
resource "aws_iam_role_policy_attachment" "ecs_ecr_access_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecr_access.arn
}

# ECS Task Role
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project_name}-ecs-task-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = var.tags
}

# CloudWatch Logs Access Policy for Task Role
resource "aws_iam_policy" "cloudwatch_logs_access" {
  name        = "${var.project_name}-cloudwatch-logs-policy-${var.environment}"
  description = "Policy to allow writing to CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${var.cloudwatch_log_group_arn}:*"
      }
    ]
  })

  tags = var.tags
}

# Attach CloudWatch Logs Access Policy to Task Role
resource "aws_iam_role_policy_attachment" "ecs_cloudwatch_access_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_access.arn
}

# Custom task permissions if specified
resource "aws_iam_policy" "custom_task_policy" {
  count       = var.custom_task_policy_document != "" ? 1 : 0
  name        = "${var.project_name}-custom-task-policy-${var.environment}"
  description = "Custom policy for ECS task"
  policy      = var.custom_task_policy_document
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "custom_task_policy_attachment" {
  count      = var.custom_task_policy_document != "" ? 1 : 0
  role       = aws_iam_role.ecs_task_role.name
  # Access the ARN only if the policy was created (count > 0)
  policy_arn = element(aws_iam_policy.custom_task_policy.*.arn, 0)
}