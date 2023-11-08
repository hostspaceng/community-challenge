# Monitoring Setup with Prometheus, Grafana, and Node Exporter

## Table of Contents
#### Introduction
 Design Choices

Prerequisites

Installation

Configuration

Deployment

Testing

Troubleshooting

Maintenance

Contributing



## Introduction
This README provides a comprehensive guide on setting up Prometheus, Grafana, and Node Exporter for monitoring your infrastructure. Prometheus is a powerful open-source monitoring system, Grafana is a data visualization and dashboarding tool, and Node Exporter is a Prometheus exporter for system and hardware metrics.

##  Design Choices
### prometheus
Prometheus was chosen as the monitoring system due to its flexible and scalable architecture.
The data retention period and storage configuration can be customized in the Prometheus configuration file.
### Grafana
Grafana is used for visualization and dashboarding, as it provides a user-friendly interface for creating and sharing dashboards.
Dashboards can be customized according to your specific monitoring needs.
### Node Exporter
Node Exporter is used to collect system and hardware metrics from target nodes, enabling comprehensive monitoring.
Multiple Node Exporters can be deployed across the infrastructure.


## Prerequisites
Before setting up the monitoring stack, ensure you have the following prerequisites:

Linux-based servers for deploying Prometheus, Grafana, and Node Exporter.
Docker and Docker Compose installed on these servers.
Basic knowledge of Linux, Docker, and Docker Compose.
Firewalls configured to allow communication between nodes.


## Installation
Clone this repository to your server where you want to set up the monitoring stack:

> git clone https://github.com/your/community-challenge.git

> Navigate to the project directory:

> cd Infrastructure


Customize the prometheus.yml and grafana/provisioning/datasources/datasource.yaml and grafana/provisioning/dashboards/dashboard.yaml files to match your environment and data sources.

Build and start the monitoring stack using:
> terraform init

> terraform plan

> terraform apply --auto-approve

## Configuration
### Prometheus
 Customize the prometheus.yml file to define your targets and scrape intervals.
### Grafana
 Configure data sources and dashboards in the grafana/provisioning directory.
### Node Exporter
 Node Exporter runs automatically with Docker Compose and scrapes metrics from the host system.
### Deployment
The monitoring stack should now be up and running. You can access Prometheus at http://your-prometheus-server:9090 and Grafana at http://your-grafana-server:3000.

### Testing
To ensure your monitoring stack is working correctly, follow these steps:

Access the Prometheus web UI and verify that targets are being scraped.
Access the Grafana web UI and import dashboards or create custom ones.
Create alerts and notifications in Prometheus and Grafana to test the alerting system.
Generate some test traffic or load on your monitored systems to see metrics being collected.

## Troubleshooting
In case of issues, refer to the following resources for troubleshooting:

Prometheus documentation: https://prometheus.io/docs/
Grafana documentation: https://grafana.com/docs/
Node Exporter documentation: https://github.com/prometheus/node_exporter

## Maintenance
Regular maintenance is essential to ensure the stability and reliability of your monitoring setup. Here are some recommended maintenance tasks:

Keep Prometheus and Grafana up to date.
Monitor disk space on your monitoring server to prevent data loss.
Regularly review and update your alerting and dashboard configurations.




