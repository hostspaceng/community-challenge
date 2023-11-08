variable "region" {
  type        = string
  description = "Region"
  default = "us-east-1"
}

variable "av_zone1" {
  type        = string
  description = "Availability zone1"
  default = "us-east-1a"
}

variable "av_zone2" {
  type        = string
  description = "Availability zone2"
  default = "us-east-1b"
}

variable "instance_type" {
  type        = string
  description = "Type of instance used"
  default = "t2.micro"
}

variable "montoring_instance_type" {
  type        = string
  description = "Type of instance used for monitoring"
  default = "t2.medium"
}

variable "domain_name" {
  default    = "victoriaakinyemi.me"
  type        = string
  description = "Domain name"
}

variable "keypair_filename" {
  default    = "hostober-test-key"
  type        = string
  description = "hostober server private key"
}

variable "key_dir" {
  default    = "../ansible/"
  type        = string
}
variable "server_user" {
  default    = "ubuntu"
  type        = string
}

variable "s3_bucket" {
  description = "s3_bucket"
  default = "hostober"
}

variable "aws_keypair_name" {
  description = "hostober_keypair"
  type        = string
  default     = "hostober"  # Provide a default value or change it when needed
}

variable "public_key_path" {
  description = "public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"  # Provide the default path to your public key
}

variable "aws_keypair_private_key" {
  description = "public key file"
  type        = string
  default     = "~/.ssh/id_rsa"  # Provide the default path to your public key
}

variable "docker_username" {
  description = "username"
  type        = string
  default     = "oluwasanmivic123"
}

variable "docker_password" {
  description = "password"
  type        = string
  default     = "Sanmi&123"
} 