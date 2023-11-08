
#get ami id
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

#grafana
# Define Grafana configuration
resource "template_file" "grafana_config" {
  template = <<-EOF
    # Path to where grafana can store temp files, sessions, and the sqlite3 db (if that is used)
    data = /var/lib/grafana

    # HTTP server configuration
    [server]
    protocol = http
    http_port = 3000
    domain = var.monitoring_server_ip
    root_url = "%(protocol)s://%(domain)s:%(http_port)s/grafana/"

    # Serve Grafana from the subpath specified in 'root_url' setting
    router_logging = false

    # The public-facing domain name used to access Grafana from a web browser
    [server]
    domain = var.monitoring_server_ip

    # Root URL used for routing
    [server]
    root_url = "%(protocol)s://%(domain)s:%(http_port)s/grafana/"
    EOF
}
