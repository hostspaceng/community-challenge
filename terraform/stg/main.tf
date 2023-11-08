module "eks_config" {
  source = "github.com/KennedyUC/eks-terraform-module.git"

  vpc_cidr              = var.vpc_cidr
  enable_vpc_dns        = var.enable_vpc_dns
  subnet_count          = var.subnet_count
  subnet_bits           = var.subnet_bits
  project_name          = var.project_name
  env                   = var.env
  k8s_cluster_name      = "${var.project_name}-${var.env}"
  k8s_version           = var.k8s_version
  instance_type         = var.instance_type
  desired_node_count    = var.desired_node_count
  min_node_count        = var.min_node_count
  max_node_count        = var.max_node_count
  node_disk_size        = var.node_disk_size
  ami_type              = var.ami_type
  capacity_type         = var.capacity_type
  cluster_role          = "${var.project_name}-${var.env}-cluster"
  nodes_role            = "${var.project_name}-${var.env}-node"
}