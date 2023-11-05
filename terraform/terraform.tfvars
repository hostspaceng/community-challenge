# Variable for the project name for tags
tags = {
  Project = "community-challenge"
}

# Variable for launch type

launch-type = "FARGATE"

# CPU for the whole task definition

total_cpu    = 512

# Total memory of the whole task definition

total_memory = 1024


# variable for specific container memory
memory = 512

# variable for specific container cpu 
cpu = 256

# variable for the web server conatiner port
web_server_port = 80

# variable for the proxy backend container port
proxy_port = 5000

# cpu archtecture for the fargate tasks
cpu_architecture = "X86_64"

# over all project name
project_name = "community-challenge"

# region for aws deployment
region = "us-west-2"

# desired number of ecs tasks
desired_count = 2

# cidr block for the vpc
vpc_cidr = "10.0.0.0/16"

# cidr block for the public subnets
public_subnet_cidr = [ "10.0.0.0/24", "10.0.1.0/24" ]

# cidr block for the private subent
private_subnet_cidr = [ "10.0.2.0/24", "10.0.3.0/24" ]

# availablilty zones for the subnets
azs = [ "us-west-2a", "us-west-2b" ]

# name of user group for grafana to associate with

user_group_name = "Admin"
