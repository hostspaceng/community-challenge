#####################################
# Load balancer for the ECS service #
#####################################

resource "aws_lb" "ecs-lb" {
  name               = "${var.project_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = [module.Public_Subnet_A.id, module.Public_Subnet_B.id]

  tags = {
    Environment = "production",
    Project     = var.project_name
  }
}

resource "aws_lb_target_group" "test" {
  name            = "${var.project_name}-tg"
  port            = 80
  protocol        = "HTTP"
  vpc_id          = aws_vpc.main.id
  target_type     = "ip"
  ip_address_type = "ipv4"

  tags = {
    Environment = "production",
    Project     = var.project_name
  }
}

resource "aws_lb_listener" "ec-lb-listener" {
  load_balancer_arn = aws_lb.ecs-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }

  tags = {
    Project = var.project_name
  }

}