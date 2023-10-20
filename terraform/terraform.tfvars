# Variable for the project name
tags = {
  Project = "community-challenge"
}

# Variable for launch type

launch-type = "FARGATE"

total_cpu    = 512
total_memory = 1024


# variable for the container memory
memory = 512

# variable for the container cpu 
cpu = 256

# variable for the web server conatiner port
web_server_port = 80

# variable for the proxy backend container port
proxy_port = 5000

cpu_architecture = "X86_64"

project_name = "community-challenge"