resource "aws_instance" "grafana_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.aws_keypair_name
  vpc_security_group_ids = [aws_security_group.hostober_security_grp_rule.id]
  #vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id              = aws_subnet.hostober_public_subnet1.id

  user_data = <<-EOF
    #!/bin/bash
     # Grafana
    sudo apt-get install -y apt-transport-https software-properties-common wget
    sudo mkdir -p /etc/apt/keyrings/
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    #echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list    
    sudo wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -    
    sudo apt-get update
    sudo apt-get install -y grafana
    # Installs the latest Enterprise release:
    sudo apt-get install grafana-enterprise


    echo "${template_file.grafana_config.rendered}" | sudo tee /etc/grafana/grafana.ini

    # Configure Grafana data source (Prometheus)
    cat <<EOL > /etc/grafana/provisioning/datasources/prometheus.yml
    apiVersion: 1
    datasources:
      - name: Prometheus
        type: prometheus
        access: proxy
        url: http://localhost:9090  # Use localhost, Grafana and Prometheus are on the same server
        isDefault: true
    EOL

    # Start Grafana service
    sudo systemctl enable grafana-server
    sudo systemctl start grafana-server
  EOF


  tags = {
    Name = "app_server"
  }
}

