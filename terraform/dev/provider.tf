terraform {
  backend "s3" {
    bucket = "app-terraform-state-1470"
    key    = "tf-state/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.user_access_key
  secret_key = var.user_secret_key
}