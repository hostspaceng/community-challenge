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

cpu_architecture = "X86_64"

project_name = "community-challenge"

region = "us-west-2"