# ECS cluster for the task defination

resource "aws_ecs_cluster" "cc-cluster" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}