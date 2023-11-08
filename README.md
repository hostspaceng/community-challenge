# Instructions to Deploy the Community Challenge App

This project deploys the community challenge on AWS, using Elastic Container Service to deploy the containers using FARGATE as the compute. This readme guides on how you an deploy the application on your specified AWS Account. It uses terraform to spin up the whole resources. The table below, lists the core resources that will be created by terraform

| Name | Shortcode |
| --- | --- | 
| VPC | :heavy_check_mark: |
| 2 private Subnets | :heavy_check_mark:|
| 2 Public Subnets  | :heavy_check_mark:|
| Internet Gateway  | :heavy_check_mark:|
| NAT Gateway       | :heavy_check_mark:|
| ECS Service       | :heavy_check_mark:|
| ECS Cluster       | :heavy_check_mark:|
| Task Definition   | :heavy_check_mark:|
| Load Balancer     | :heavy_check_mark:|
| IAM Roles         | :heavy_check_mark:|
| ECR               | :heavy_check_mark:|
| EC2 (Grafana)     | :heavy_check_mark:|
| Cloud watch log group | :heavy_check_mark:|



![architeture](./img/download.png)


## Prerequisites

Ensure that you have the below listed in the github actions secrets/environment variables. Consider an exmaple of it in the example section. Ensure you have an AWS Account.
Head over to your AWS account and create an s3 Bucket. This bucket name is what is going to be passed in the secrets. The bucket will be used to store terraform state files. 

### Environment Variables

| Environment Variable | Example |
| --- | --- |
| AWS_REGION | us-west-2 |
| PROJECT_NAME | community-challenge |

Ensure that the project_name you specify in the environemnt variable is the same with the variable in `terraform.tfvars` file named `project_name`

### Actions Secrets

| Secret_Name | Example |
| --- | --- |
| AWS_ACCESS_KEY_ID | AKIAIOSFODNN7EXAMPLE  |
| AWS_SECRET_ACCESS_KEY | wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY  |
| AWS_BUCKET_NAME | community-challenge-state-bucket-00995544 |
| AWS_BUCKET_KEY_NAME | terraform/tfstate |

## Setup & Installation

Follow these instructions to set up the development environment on your AWS Account.

### 1. Deploy Terraform

Before you deploy the terraform infra, look in `var.tf` and `terraform.tfvars` you'll find a variable named `key_pair_name` edit the key name there to the name of a specific key pair name in your AWS Account. You can create one in the management console.

After you change the variable, create a new branch locally add and commit your changes. Push to the new branch and then create a pull request to the main branch. The pull request will trigger a pipeline in that will validate the configuration and generate a terraform plan.

You should have a response in the pull requests page similar to the image below

![Pull_Request](./img/pull_req.png)

If the above generates a successful plan, them merge the pull request to the main branch (you can delete the branch). After the merge, it will generate another pipeline in that will apply the terraform configuration to your AWS account.

### 2. Set Secrets

If the apply pipeline is successful, head over to your management console. You should find 3 secrets there. Go into the secrets and set the value of each of them. Check in the `/backend` directory, you'll find a file `.env.local` copy only the values of each of them and paste them into the specified secrets. Paste them as plain texts

### 3. Application Setup

Head over to the `/backend` directory and trigger a change there. Maybe just add some empty line of code in the dockerfile to generate a change. Do same in the `/frontend` directory

Push the changes. It will trigger two pipelines that will deploy the app in the ECR repository,place the tags and deploy to the cluster.

### 4 Check application

If the pipelines run successfully, head over to your management console, check load balancers, you'll find a loadbalancer named `community-challenge-lb` copy the DNS name and access the application from the load balancer.

### 5 Grafana

An instance is created with the key pair you specified in step 1. Head over to the console and connect to the machine. Read [this](https://medium.com/all-things-devops/how-to-install-grafana-on-aws-ec2-cefc01d5ff08) article to install grafana on the machine. 

Select Cloudwatch as the data source and test the connections, it should work without access keys.

## Images

ECS Cluster
![Cluster](./img/aws-1.png)

ECS Service
![Service](./img/aws-2.png)

ECS Deployments
![Deployments](./img/deployments.png)

Tasks
![Tasks](./img/tasks.png)

Running Application
![App](./img/app.png)

## Participation in the Challenge

For details on participating in the challenge, including writing a Dockerfile, setting up a CI/CD pipeline, and implementing Infrastructure as Code (IaC), please refer to the detailed challenge instructions provided.

Make sure to use the provided pull request template when submitting your solutions to facilitate a uniform and organized evaluation process.

For any questions or clarifications, reach out on the dedicated Slack channel. Happy coding!
