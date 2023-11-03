# Query small instance size
data "civo_size" "xsmall" {
    filter {
        key = "type"
        values = ["kubernetes"]
    }

}


# Create a firewall
resource "civo_firewall" "my-firewall" {
    name = "my-firewall"
    
}

# Create a firewall rule
resource "civo_firewall_rule" "kubernetes_api" {
    firewall_id = civo_firewall.my-firewall.id
    protocol = "tcp"
    start_port = "6443"
    end_port = "6443"
    cidr = ["0.0.0.0/0"]
    direction = "ingress"
    label = "kubernetes-api-server"
    action = "allow"
}


# Create a cluster with k3s
resource "civo_kubernetes_cluster" "k8s_demo_1" {
    name = "k8s_demo_1"
    applications = ""
    firewall_id = civo_firewall.my-firewall.id
    cluster_type = "k3s"
    pools {
        size = element(data.civo_size.xsmall.sizes, 0).name
        node_count = 3
    }
}
