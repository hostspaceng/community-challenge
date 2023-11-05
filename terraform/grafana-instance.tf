# EC2 instance for grafana
# You'll need to provide a name for the key pair from one of the key pairs in your management console
# the grafana instance is an ubuntu machine from the latest aws ami


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"


  name = "instance-grafana"

  instance_type          = "t2.micro"
  key_name               = var.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [ module.vpc.default_security_group_id ]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  
  ami = "ami-00448a337adc93c05"
  user_data = <<EOF
  #!/bin/bash
  sudo apt-get install -y apt-transport-https software-properties-common wget -y
  sudo mkdir -p /etc/apt/keyrings/
  wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null -y
  echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
  echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
  sudo apt-get update -y
  sudo apt-get install grafana -y
  sudo apt-get install grafana-enterprise -y
  EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}