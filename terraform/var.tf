variable "project_name" {
  type = string
}

variable "tags" {
  type = object({
  })
}

variable "launch-type" {
  type = string
}

variable "memory" {
  type = number
}

variable "cpu" {
  type = number
}

variable "web_server_port" {
  type = number
}

variable "proxy_port" {
  type = number
}

variable "cpu_architecture" {
  type = string
}

variable "total_cpu" {
  type = number
}

variable "total_memory" {
  type = number
}