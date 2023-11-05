
# Security group for loadbalancer

resource "aws_security_group" "lb-sg" {
  name        = "load-balancer-sg"
  description = "Allow http traffic from public"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "Allow public access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}

# Security group for ECS service

resource "aws_security_group" "ecs-sg" {
  name        = "frontend-container"
  description = "Allow http traffic from load balancer"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "Allow public access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [ aws_security_group.lb-sg.id ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}

# Security group for the vpc endpoint

resource "aws_security_group" "task-endpoint" {
  name        = "${var.project_name}-task-endpoint-sg"
  description = "Allow http traffic from tasks"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "Allow traffic from frontend task"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [ aws_security_group.ecs-sg.id ]
  }

  ingress {
      description      = "Allow traffic from backend task"
      from_port        = 3000
      to_port          = 3000
      protocol         = "tcp"
      security_groups = [ aws_security_group.ecs-sg.id ]
    }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}

# Add security group for grafana instanace

resource "aws_security_group" "task-endpoint" {
  name        = "${var.project_name}-grafana-sg"
  description = "Allow http traffic from tasks"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "Allow traffic from frontend task"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
      description      = "Allow traffic from backend task"
      from_port        = 3000
      to_port          = 3000
      protocol         = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}