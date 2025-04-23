variable "task_cpu" {
  description = "The number of CPU units used by the ECS task."
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens."
  type        = number
}