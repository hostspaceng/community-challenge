
# Task Defination for the both containers

resource "aws_ecs_task_definition" "service" {
  family = "community-challenge-family"
  container_definitions = jsonencode([
    
    # nginx container definitions
    {
      name      = "nginx-frontend"
      image     = module.frontend_image.repository_url
      requires_compatibilities = var.launch-type
      cpu       = var.cpu
      memory    = var.memory
      cpu_architecture = var.cpu_architecture
      essential = true
      environment = [
        {"VUE_APP_PROXY_URL": "localhost:5000"}
      ]
      portMappings = [
        {
          containerPort = var.web_server_port
          hostPort      = var.web_server_port
        }
      ]
      tags = var.tags
    },

    # proxy backend container definition

    {
      name      = "proxy-backend"
      image     = module.backend_image.repository_url
      requires_compatibilities = var.launch-type
      cpu       = var.cpu
      cpu_architecture = var.cpu_architecture
      memory    = var.memory
      essential = true
      environment = [
        {
            "ZONE_ID": "${aws_secretsmanager_secret.zone.arn}",
            "CF_API_KEY": "${aws_secretsmanager_secret.api_key.arn}",
            "CF_API_EMAIL": "${aws_secretsmanager_secret.api_email.arn}"
        }
      ]
      portMappings = [
        {
          containerPort = var.proxy_port
          hostPort      = var.proxy_port
        }
      ]
      tags = var.tags
    }
  ])

}