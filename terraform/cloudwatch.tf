# Log configuration for the tasks and container logs

# Log group for the frontend tasks

module "log_group-fe" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 3.0"

  name              = "${var.project_name}/frontend-task/log"
  retention_in_days = 7
}

# log group for the backend tasks

module "log_group-be" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 3.0"

  name              = "${var.project_name}/backend-task/log"
  retention_in_days = 7
}