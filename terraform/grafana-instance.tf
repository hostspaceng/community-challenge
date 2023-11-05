# EC2 instance for grafana
# You'll need to provide a name for the key pair from one of the key pairs in your management console
# the grafana instance is an ubuntu machine from the latest aws ami


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"


  name = "instance-grafana"

  instance_type          = "t2.micro"
  key_name               = var.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [ aws_security_group.grafana-machine.id ]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  
  ami = "ami-00448a337adc93c05"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Instance profile for the grafana machine to have access to cloudwatch

resource "aws_iam_instance_profile" "test_profile" {
  name = "grafana-cloudwatch"
  role = aws_iam_role.grafana-ec2-role.name
}