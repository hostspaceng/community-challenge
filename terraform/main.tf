terraform {
  required_providers {
    aws = {
      version = "~>5.21.0"
    }
  }

  backend "s3" {
    
  }

}

provider "aws" {
  region = "us-west-2"
}


