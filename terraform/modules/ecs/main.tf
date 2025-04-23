# modules/ecs/main.tf

# # ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.environment}-cluster"
  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ecs-cluster-${var.environment}"
    }
  )
}

# Task Definition
resource "aws_ecs_task_definition" "main" {
  family                   = "${var.project_name}-task-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.task_execution_role_arn

  container_definitions = jsonencode([{
    name      = "${var.project_name}-container-${var.environment}"
    image     = "${var.container_image}:${var.container_tag}"
    essential = true
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
    environment = var.environment_variables
    secrets     = var.secrets
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = var.cloudwatch_log_group_name
        "awslogs-region"        = data.aws_region.current.name,
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-task-definition-${var.environment}"
    }
  )
}

# ECS Service
resource "aws_ecs_service" "main" {
  name            = "${var.project_name}-service-${var.environment}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.public_subnet_id]
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = true
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ecs-service-${var.environment}"
    }
  )
}


# Security Group for ECS Service
resource "aws_security_group" "ecs_service" {
  name        = "${var.project_name}-ecs-sg-${var.environment}"
  description = "Security group for ECS service"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ecs-sg-${var.environment}"
    }
  )
}


# Declare the AWS Region data source
data "aws_region" "current" {
  # No configuration needed; fetches the current region
}