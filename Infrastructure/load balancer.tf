# Create an Application Load Balancer
resource "aws_lb" "hostober_load_balancer" {
  name               = "hostober-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.hostober_load_balancer_sg.id]
  subnets            = [aws_subnet.hostober_public_subnet1.id, aws_subnet.hostober_public_subnet2.id]
  #enable_cross_zone_load_balancing = true
  enable_deletion_protection = false
  depends_on                 = [aws_instance.app_server]
}

# Create the target group
resource "aws_lb_target_group" "hostober_target_group" {
  name        = "hostober-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.hostober_vpc.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}


# Create the listener
resource "aws_lb_listener" "hostober_listener" {
  load_balancer_arn = aws_lb.hostober_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
     # content      = "OK"
    }
  }
}

# Create the listener rule
resource "aws_lb_listener_rule" "hostober_listener_rule" {
  listener_arn = aws_lb_listener.hostober_listener.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hostober_target_group.arn
  }
  condition {
    path_pattern {
      values = ["/"]
    }
  }
}


# Create the listener
#resource "aws_lb_listener" "hostober_listener" {

 # load_balancer_arn = aws_lb.hostober_load_balancer.arn
  #port              = 443
  #protocol          = "HTTPS"

#  ssl_policy      = "ELBSecurityPolicy-2016-08"
 # certificate_arn = aws_acm_certificate.hostober_lb_certificate.arn

  #default_action {
   # type             = "forward"
    #target_group_arn = aws_lb_target_group.hostober_target_group.arn
  #}
#}
# Create the listener rule
#resource "aws_lb_listener_rule" "hostober_listener_rule" {
 # listener_arn = aws_lb_listener.hostober_listener.arn
  #priority     = 1
  #action {
   # type             = "forward"
    #target_group_arn = aws_lb_target_group.hostober_target_group.arn
  #}
  #condition {
   # path_pattern {
    #  values = ["/"]
    #}
  #}
#}

# Attach the target group to the load balancer
resource "aws_lb_target_group_attachment" "hostober_target_group_attachment1" {
  target_group_arn = aws_lb_target_group.hostober_target_group.arn
  target_id        = aws_instance.app_server.id
  port             = 80
}
#resource "aws_lb_target_group_attachment" "hostober_target_group_attachment2" {
 # target_group_arn = aws_lb_target_group.hostober_target_group.arn
  #target_id        = aws_instance.monitoring_server.id
  #port             = 80
#}
