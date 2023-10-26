#!/bin/bash

# This script is used to get the URL of the backend-service and pass the configmap
# definition file before creation.
backendServiceUrl="http://$(kubectl get svc backend-service -n hostspace -o json \
| jq ".status.loadBalancer.ingress[0].hostname" | sed 's/"//g'):5000/"

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