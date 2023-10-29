#!/bin/bash

aws eks update-kubeconfig --name my-eks-cluster --region us-east-1


helm upgrade --install ingress-nginx ingress-nginx   --repo https://kubernetes.github.io/ingress-nginx

kubectl apply -f eks_configmap.yaml

kubectl apply -f eks_deployments.yaml

kubectl apply -f ingress-service.yaml