#!/bin/bash

# This script is used to get the URL of the backend-service and pass the configmap
# definition file before creation.
# Define the namespace and service name
namespace="hostspace"
service_name="backend-service"

# Set a timeout for waiting (e.g., 5 minutes)
timeout=300
start_time=$(date +%s)

# Use a while loop to check for the URL
while true; do
  # Get the load balancer hostname
  lb_hostname=$(kubectl get svc $service_name -n $namespace -o json | jq -r ".status.loadBalancer.ingress[0].hostname")
  
  if [ "$lb_hostname" != "null" ]; then
    # Construct the URL
    backendServiceUrl="http://${lb_hostname}:5000/"
    break
  fi

  # Check for timeout
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))
  if [ $elapsed_time -ge $timeout ]; then
    echo "Timeout: Unable to get the URL of the backend service."
    exit 1
  fi

  # Sleep for a few seconds before checking again
  sleep 5
done

# Passing the backendServiceUrl into the configmap file.
cat <<EOF > configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: hostspace-configmap
  namespace: hostspace
data:
  zone_id: 88212a53b6feba598b197f3508f35b52
  cf_api_email: safe@hostspaceng.com
  vue_app_proxy_url: ${backendServiceUrl}

EOF
