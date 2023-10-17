variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type = map
}

variable "tags" {
  type = object
}

variable "availability_zone" {
  type = string
}