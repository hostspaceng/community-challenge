
# Security group for loadbalancer

resource "aws_security_group" "lb-sg" {
  name        = "load-balancer-sg"
  description = "Allow http traffic from public"
  vpc_id      = aws_vpc.main.id

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
  vpc_id      = aws_vpc.main.id

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
