# Network for the whole archtecture deployment

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_name}-VPC"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnet_cidr
  public_subnets  = var.public_subnet_cidr

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    project_name = var.project_name
  }
}