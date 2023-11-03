####################################
# Role for the Task definition     #
####################################

resource "aws_iam_role" "task_role" {
  name = "${var.project_name}-task-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    project = var.project_name
  }
}

resource "aws_iam_role_policy" "task_policy" {
  name = "${var.project_name}-task_policy"
  role = aws_iam_role.task_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "secretsmanager:GetSecretValue",
          "logs:CreateLogGroup"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


####################################
# Role for the ECS Service         #
####################################

resource "aws_iam_policy" "ecs-policy" {
  policy = file("./ecs-policy.json")
}

data "aws_iam_policy_document" "ecs-assume-role-role" {
  statement {
    actions = ["sts:AssumeRole"]
    sid     = ""

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }

}

resource "aws_iam_role" "ecs_role" {
  name               = "${var.project_name}-ecs-role"
  assume_role_policy = data.aws_iam_policy_document.ecs-assume-role-role.json

  tags = {
    project = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "ecs-policy-att" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = aws_iam_policy.ecs-policy.arn
}





