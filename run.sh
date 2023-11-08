#!/bin/bash

 aws cloudformation create-stack   --region us-east-1   --stack-name my-eks-vpc   --template-body file://vpc_stack.yaml 
 aws cloudformation create-stack   --region us-east-1   --stack-name my-eks-cluster   --capabilities CAPABILITY_NAMED_IAM   --template-body file://hostober_challenge_cloudformation.yaml

aws eks update-kubeconfig --name my-eks-cluster --region us-east-1


helm upgrade --install ingress-nginx ingress-nginx   --repo https://kubernetes.github.io/ingress-nginx


kubectl apply -f eks_deployments.yaml

kubectl apply -f ingress-service.yaml