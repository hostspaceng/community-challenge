
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

# VPC endpoint for cloudwatch logs

# resource "aws_vpc_endpoint" "logs" {
#   vpc_id       = module.vpc.vpc_id
#   service_name = "com.amazonaws.${var.region}.logs"
#   private_dns_enabled = true
#   security_group_ids = [ aws_security_group.ecs-sg.id ]
#   subnet_ids = module.vpc.private_subnets
#   vpc_endpoint_type = "Interface"
# }