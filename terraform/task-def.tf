
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
      cpu_architecture = var.cpu_architecture
      essential        = true
      environment = [
        {
          "name" : "VUE_APP_PROXY_URL",
          "value" : "localhost:5000"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = "${module.log_group-fe.cloudwatch_log_group_name}"
          awslogs-region = var.region
          awslogs-create-group = "true"
          awslogs-stream-prefix = "frontend-task"
        }
      }
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
      cpu_architecture = var.cpu_architecture
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
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = "${module.log_group-be.cloudwatch_log_group_name}"
          awslogs-region = var.region
          awslogs-create-group = "true"
          awslogs-stream-prefix = "backend-task"
        }
      }
      tags = var.tags
    },

  # X-Ray Deamon for container logs to effiently get into cloudwatch
    {
      name = "xray-daemon"
      image = "amazon/aws-xray-daemon"
      portMappings = [
        {
          hostPort = 2000
          containerPort = 2000
          protocol = "udp"
        }
      ]
         logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = "${module.log_group-xray.cloudwatch_log_group_name}"
          awslogs-region = var.region
          awslogs-create-group = "true"
          awslogs-stream-prefix = "backend-task"
        }
      }

    }

  ])

}