
# Create a security group for the load balancer
resource "aws_security_group" "hostober_load_balancer_sg" {
  name        = "hostober_load_balancer_sg"
  description = "Security group for the load balancer"
  vpc_id      = aws_vpc.hostober_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    description = "HTTP"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    description = "docker port"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    description = "HTTPS"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group to allow port 80, 443 and 2200
resource "aws_security_group" "hostober_security_grp_rule" {
  name        = "allow_ssh_http_https"
  description = "Allow SSH, HTTP and HTTPS inbound traffic for instances"
  vpc_id      = aws_vpc.hostober_vpc.id
  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.hostober_load_balancer_sg.id]
  }
  ingress {
    description     = "HTTPS"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.hostober_load_balancer_sg.id]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    description = "docker port"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.hostober_load_balancer_sg.id]
  }
  
   ingress {
    from_port   = 22
    to_port     = 22
    description = "SSH"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
#}

# Create a security group for the monitoring server

#resource "aws_security_group" "monitoring_security_group" {
 # name        = "monitoring_security_group"
  #description = "Security group for monitoring server"
  #vpc_id      = aws_vpc.hostober_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    description = "SSH"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    description = "HTTP"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    description = "HTTPS"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    description = "grafana"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9090
    to_port     = 9090
    description = "prometheus"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description      = "prometheus Node Exporter"
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hostober_security_grp_rule"
  }
}

