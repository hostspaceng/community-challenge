
# Task Defination for the both containers

resource "aws_ecs_task_definition" "service" {
  family                   = "${var.project_name}-family"
  requires_compatibilities = [var.launch-type]
  network_mode             = "awsvpc"
  cpu                      = var.total_cpu
  memory                   = var.total_memory
  execution_role_arn       = aws_iam_role.task_role.arn
  container_definitions = jsonencode([

    # nginx/frontend container definitions
    {
      name             = "nginx-frontend"
      image            = module.frontend-image.repository_url
      cpu              = var.cpu
      memory           = var.memory
      cpu_architecture = var.cpu_architecture
      essential        = true
      environment = [
        {
          "name" : "VUE_APP_PROXY_URL",
          "value" : "localhost:5000"
        }
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
      name             = "proxy-backend"
      image            = module.backend-image.repository_url
      cpu              = var.cpu
      cpu_architecture = var.cpu_architecture
      memory           = var.memory
      essential        = true
      secrets = [
        {
          "name" : "ZONE_ID", "valueFrom" : "${aws_secretsmanager_secret.zone.arn}"
        },
        {
          "name" : "CF_API_KEY", "valueFrom" : "${aws_secretsmanager_secret.api_key.arn}"
        },
        {
          "name" : "CF_API_EMAIL", "valueFrom" : "${aws_secretsmanager_secret.api_email.arn}"
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