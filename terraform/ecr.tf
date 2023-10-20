
# A module for the ECR image is in the ECR folder in /modules/ecr

# ECR repository for VUE js frontend

module "frontend-image" {
  source = "./modules/ecr"
  name   = "${local.name}-frontend"
  tags   = var.tags
}

# ECR repository for Python flask proxy app

module "backend-image" {
  source = "./modules/ecr"
  name   = "${local.name}-backend"
  tags   = var.tags
}

