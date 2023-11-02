# configure aws provider to establish a secure connection between terraform and aws
provider "aws" {
  region = var.region
  #profile = "terraform-user"

  default_tags {
    tags = {
      "Automation"  = "terraform"
      "Project"     = var.project_name
      "Environment" = var.environment
    }
  }
}
