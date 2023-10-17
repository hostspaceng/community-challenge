terraform {
  required_providers {
    aws =  {
        region = "us-west-2"
        version = "~>4.18.0"
    }
  }

    backend "s3" {
    bucket = "kanban-app-state-files"
    key = "state/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
}

}


