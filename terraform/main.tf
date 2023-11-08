#Create the repository for the vue frontend image
resource "aws_ecr_repository" "hostspaceUi" {
  name                 = "ui"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

#Create the repository for the flask backend image
resource "aws_ecr_repository" "hostspaceBackend" {
  name                 = "backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

#The container cluster to run tasks and services with container insights enabled for monitoring
resource "aws_ecs_cluster" "hostspaceCluster" {
  name = "theyemihostspacecluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


#Create the task definition to run the container service
#I opted for the fargate serverless option with network mode awsvpc
#Specifying the network mode allows gives the flexibility to configure networking
#such as subnets, vpc and security group

resource "aws_ecs_task_definition" "theyemihostspaceTaskDefinition" {
  family= "theyemihostspaceTaskDefinition"
  requires_compatibilities= ["FARGATE"]
      cpu= "2048"
    memory= "5120"
    runtime_platform {
        cpu_architecture = "X86_64"
        operating_system_family = "LINUX"    
    }

  container_definitions = jsonencode([
           {
            "name": "ui",
            "image": "568305562431.dkr.ecr.ca-central-1.amazonaws.com/ui:latest",
            "cpu": 1024,
            "memory": 2048,
            "portMappings": [
                {
                    "name": "ui-80-tcp",
                    "containerPort": 80,
                    "hostPort": 80,
                    "protocol": "tcp",
                    "appProtocol": "http"
                }
            ],
            
            "essential": true,
            "environment": [],
            "environmentFiles": [],
            "mountPoints": [],
            "volumesFrom": [],
            "ulimits": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/theyemihostspaceTaskDefinition",
                    "awslogs-region": "ca-central-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            }
        },
        {
            "name": "backend",
            "image": "568305562431.dkr.ecr.ca-central-1.amazonaws.com/backend:latest",
            "cpu": 1024,
            "memory": 2048,
            "portMappings": [
                              {
                    "name": "backend"
                    "containerPort": 5000,
                    "hostPort": 5000,
                    "protocol": "tcp",
                }
            ],
            "essential": false,
            "environment": [],
            "environmentFiles": [],
            "mountPoints": [],
            "volumesFrom": []
        }
  ])
  task_role_arn = "arn:aws:iam::568305562431:role/ecsTaskExecutionRole"
execution_role_arn = "arn:aws:iam::568305562431:role/ecsTaskExecutionRole"
network_mode =  "awsvpc"

}


#Service definition for the fargate cluster task
resource "aws_ecs_service" "theyemihostspaceService" {
  name            = "theyemihostspaceservice"
  cluster         = aws_ecs_cluster.hostspaceCluster.id
  task_definition = aws_ecs_task_definition.theyemihostspaceTaskDefinition.arn
  desired_count   = 1
launch_type = "FARGATE"
#These are the default subnets in the aws default vpc.
#The security has already been created in the console and opens port 80 and other required ports
  network_configuration {
    subnets = [ "subnet-02cb571218d81d7ee", "subnet-0049ab68963350a8c", "subnet-07f653468f06b14ff" ]
    security_groups = ["sg-0596a34e33519c972"]
    assign_public_ip = true
  }

}