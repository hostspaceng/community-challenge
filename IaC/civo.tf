# Query small instance size
data "civo_size" "medium" {
    filter {
        key = "name"
        values = ["g4s.kube.medium"]
        match_by = "re"
    }

}


# Create a firewall
resource "civo_firewall" "my-firewall-demo" {
    name = "my-firewall-demo"
    
}

# Create a firewall rule
resource "civo_firewall_rule" "kubernetes_api" {
    firewall_id = civo_firewall.my-firewall-demo.id
    protocol = "tcp"
    start_port = "6443"
    end_port = "6443"
    cidr = ["0.0.0.0/0"]
    direction = "ingress"
    label = "kubernetes-api-server"
    action = "allow"
}


# Create a cluster with k3s
resource "civo_kubernetes_cluster" "k8s-cluster" {
    name       = "k8s-cluster"
  applications = ""
  firewall_id = civo_firewall.my-firewall-demo.id
  num_target_nodes = 3
  pools {
    node_count = 3
    size = element(data.civo_size.medium.sizes, 0).name
  }
}
