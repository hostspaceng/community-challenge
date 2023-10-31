# Over-all name of the project

variable "project_name" {
  type = string
}

# Tags to be used in the project resources for isolation
variable "tags" {
  type = object({
  })
}

# Launch type for the ECS Task definition and cluster
variable "launch-type" {
  type = string
}

# Memory allocation for the tasks
variable "memory" {
  type = number
}

# cpu allocation for the tasks
variable "cpu" {
  type = number
}

# Port for the VUE js frontend task
variable "web_server_port" {
  type = number
}

# Port for the python proxy backend task
variable "proxy_port" {
  type = number
}

# cpu architecture for the tasks
variable "cpu_architecture" {
  type = string
}

# Total cpu allocation for the task definition
variable "total_cpu" {
  type = number
}

# Total memory for the whole task definition
variable "total_memory" {
  type = number
}

# AWS region for the whole deployment
variable "region" {
  type = string
}