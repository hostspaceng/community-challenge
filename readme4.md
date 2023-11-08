
---

# Monitoring Setup Documentation

## Table of Contents

1. *Infrastructure Setup*
2. *Web Application Deployment*
3. *Prometheus Configuration*
4. *Grafana Configuration*
5. *Web Application Integration*

---

## 1. Infrastructure Setup

### 1.1 AWS Infrastructure

You have two AWS EC2 instances:
- *Web Application Server*
- *Monitoring Server*

### 1.2 Security Groups

AWS Security Groups are configured to allow necessary traffic.

---

## 2. Web Application Deployment

### 2.1 Web Application Docker Container

The web application runs in a Docker container on the *Web Application Server*. Here's the deployment process:

```bash
# Pull the Docker image from Docker Hub
docker pull oluwasanmivic123/myapp:latest

# Run the Docker container
docker run -d -p 80:80 oluwasanmivic123/myapp:latest

```
### 2.2 Application Metrics

Ensure your web application exposes metrics for Prometheus scraping.

---

## 3. Prometheus Configuration

### 3.1 Prometheus Server

Prometheus is installed on the *Monitoring Server*.

### 3.2 Prometheus Configuration

bash
# Install Prometheus
```sudo apt-get update
sudo apt-get install -y prometheus
```
# Configure Prometheus scraping
```cat <<EOL > /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']

  - job_name: 'your_application'
    static_configs:
      - targets: ['localhost:80']
EOL
```

### 3.3 Data Storage

Prometheus stores collected metrics in its time-series database.

### 3.4 Prometheus UI

Access the Prometheus web UI at `http://[PROMETHEUS_SERVER_IP]:9090` for querying and data visualization.

---

## 4. Grafana Configuration

### 4.1 Grafana Server

Grafana is installed on a separate server.

### 4.2 Grafana Configuration

```bash
# Install Grafana
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

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
    url: http://localhost:9090
    isDefault: true
EOL
```

### 4.3 Grafana Dashboards and Panels

Create Grafana dashboards and panels for visualization.

### 4.4 Grafana Alerting

Set up alerts in Grafana based on specific metrics.

### 4.5 Access Grafana

Access the Grafana web UI at `http://[GRAFANA_SERVER_IP]:3000` for dashboard creation and visualization.

---

This document provides an overview of a monitoring setup, including the deployment of your web application in a Docker container. 