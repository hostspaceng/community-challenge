terraform {
  required_providers {
    aws = {
      version = "~>5.21.0"
    }
  }

  #     backend "s3" {
  #     bucket = "kanban-app-state-files"
  #     key = "state/terraform.tfstate"
  #     region = "us-west-2"
  #     encrypt = true
  # }

}

provider "aws" {
  region = "us-west-2"
}


