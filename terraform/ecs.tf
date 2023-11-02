# Service to manage the ecs cluster

resource "aws_ecs_service" "cc-service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.cc-cluster.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.desired_count
  launch_type     = var.launch-type


  # Privte subnet configuration with the ECCS service
  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.ecs-sg.id]
  }

# Load balancer for the ECS service
    load_balancer {
      target_group_arn = aws_lb_target_group.test.arn
      container_name   = "nginx-frontend"
      container_port   = 80
    }
}