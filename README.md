# Cloudflare Domains Manager

Manage your Cloudflare domains with ease using the Cloudflare Domains Manager. This responsive and efficient application is built with a Vue.js frontend and a Python Flask backend. 

![Screenshot](screenshot.png)

## Setup & Installation(Local Machine)

### Prerequisites

The applications are deployed using docker compose locally. Ensure the following prerequisite is installed on your local machine:

### Backend and Frontend
- Docker
- Docker Compose

Follow these instructions to set up the development environment on your local machine.

### 1. Clone the Repository

Clone the repository from https://github.com/Okeybukks/community-challenge.git .

```bash
git clone https://github.com/Okeybukks/community-challenge.git
cd community-challenge
```

### 2. Machine Setup

The test environment I used is Ubuntu 20.04.6 LTS. Whatever machine is used, ensure you have docker and docker compose installed by running this command.

```
docker version
docker compose version
```

#### Set Environment Variables

Replace the placeholders in the `.env` sample file with your actual Cloudflare credentials and configurations or copy from  `.env.sample`. To use the environment file during the deployment with docker, rememeber to rename to `.env`.

```plaintext
ZONE_ID=your_zone_id_here
CF_API_KEY=your_CF_API_KEY_here
CF_API_EMAIL=your_CF_API_EMAIL_here
VUE_APP_PROXY_URL=IP_ADDRESS_OF_MACHINE
```

For my test environment, the IP of the Linux machine is 192.168.56.28

#### Start the Application

```bash
docker compose -f dockercompose.yaml up
```
The command builds the docker images specified in the dockercompose.yaml file and the starts up the application.

If you want to only build the application images only with out starting the applications, run this command.

```bash
docker compose -f dockercompose.yaml build
```

The above command creates two images; the Vue application and Flask application. You can see the created docker images using this command.

```bash
docker images
```
Because the application is served using Nginx, the Flask API server will be running on [http://IP/proxy/](http://IP/proxy/).

In my case, the Flask API is running on [http://192.168.56.28/proxy/](http://192.168.56.28/proxy/). The Falsk application is also running on [http://192.168.56.28:5000](http://192.168.56.28:5000)

The Vue application is runing on [http://IP](http://IP), In my case, the Flask API is running on [http://192.168.56.28](http://192.168.56.28) 

## Setup & Installation(Deploying to the Cloud)
### Prerequisites

The applications deployment is down in the cloud. The following prerequisite are needed to completely deploy to the cloud.

#### CICD Tool
- Jenkins

### IAC Tool
- Pulumi

#### Cloud Infrastructure
- AWS Account

## Infrastructure creation using Pulumi
For this project, we employed Pulumi to build the infrastructure. Pulumi is an Infrastructure as Code (IaC) tool that empowers the utilization of widely-used programming languages to orchestrate cloud resources. In this project, I am utilizing Python as our programming language for resource provisioning. The specific resource I am creating is an Amazon Elastic Kubernetes Service (EKS) cluster.

To get started with Pulumi, check out this [link](https://www.pulumi.com/docs/clouds/aws/get-started/).

### Setting AWS Credentials
Programmatic access is need by Pulumi to create resources in your cloud platform. This access is granted using Access keys. If you don't have one you can check out this [article](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user_manage_add-key.html) no how to create one.

Pulumi checks the `.aws/credentials` file for the access key. This should be how your `.aws/credentials` look like.
```
[default]
aws_access_key_id = YOUR ACCESS KEY ID
aws_secret_access_key = YOUR ACCESS KEY ID
region = YOUR REGION
```



