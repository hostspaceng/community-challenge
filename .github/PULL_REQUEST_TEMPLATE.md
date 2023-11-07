### Submission Pull Request Template

**Title:** [Submission] - Mbanugo franklyn

**Description:**

This pull request presents my solution for the HostSpace community challenge, outlining the end-to-end deployment of the Cloudflare Domain Manager Application using Docker, Terraform, Kubernetes and Github Actions for continuous integration for building the Docker image.

### The changes included in this submission encompass several key components:
  
- Containerization tool with DOCKERFILE for the Applications: I have provided the Dockerfile for the Cloudflare Domain Manager Application, allowing for containerization, and efficient deployment.

- Infrastructure as Code (IaC) with Terraform: I have created a IaC directory that includes Infrastructure as Code (IaC) scripts. These scripts define the infrastructure necessary resources for automating the kubernetes cluster where we are going to deploy our application on.

- GitHub Action CI/CD Workflow: I've included a directory dedicated to GitHub Action CI/CD workflows. This setup automates the continuous integration processes for the dockerfile , building the application images and pushing it to a container registry.


### The problem i aimed at solving includes:

- Testing and running the application locally. This tackled the challenge of knowing how to go about building the docker image of the application 

- Automating the deployment process using github actions for continous integration of the docker image and using IaC for the deployment of the Kubernetes cluster using Terraform.

- Implementating a monitoring system for the application using a package manager like helm for easy monitoring. This tacke the need for real-time monitoring, alerting, and enhancing visibility into the application's performance, availability, and usage.

With the help of the README.md file you can be able to deploy the application locally or using the cloud.


---

### Solution Details

**Dockerfile & Application Configuration:**
- The Dockerfile is structured to build and configure a multi-stage Docker image  and using one Dockerfile for the application. The solution is as follows: 

### Building the backend image 
- The first stage uses the python:3.10-alpine and a api as the build stage 
- A Label to identify the author or creator of the dockerfile using the LABEL maintainer="Mbanugo mbanugofranklyn678@gmail.com"

- Changing the working directory to /app

- Copying the required text into the current directory

- install the requirement file

- copying the current directory 

- exporting the main.py file

- exposing the port on port 5000

- run the python flask application

### Building the frontend image 
- The second stage uses the node:lts-alpine and a web as the build stage

- Changing the working directory to /app

- copying both 'package.json' and 'package-lock.json' to the working directory

- installing project dependencies

- copying the all files and folders to the current directory

- running the application development

### Building the nginx image
- The third stage uses the nginx:alpine

- change to the working directoy to /app

- copying the frontend build and using the --from as a reference of the frontend image to /app/dist

- removing the default nginx configuration file

- copying new nginx.conf to the nginx directory

- expose application on port 80

- run the nginx application

**CI/CD Pipeline:**
- Explain the CI/CD pipeline’s flow, including the build, test, and deployment stages. Specify the tools and services used, and the reasons for choosing them.

- The CI/CD system employed for this project is Github Actions. Github Actions is an event-driven automation platform that allows you to run a series of commands after a specified event has occurred. 

- I created a environmental variable to store my container registry using the github action secrets 

- I built and push the docker image using the --target arg to target the backend build stage 


**Infrastructure as Code (IaC):**
- Provide information on the IaC scripts or tools used for provisioning and deployment. Include details of the deployment platform or cloud service utilized.

For this task, i implemented terraform to provisioned a civo kubernetes to be able to deploy the application in a kubernetes cluster

- I created a provider.tf file to store the provider information

- I created a civo.tf file to build and provision the kubernetes cluster 

**Monitoring Setup (Bonus):**
- If implemented, describe the monitoring tools and configurations used. Include any custom dashboards or alerts set up to track application and infrastructure health.

For monitoring the K8s cluster and applications deployed on it, Prometheus and Grafana are deployed for the purpose using helm package. The following dashboard were implemented:

- Monitor Pod CPU and Memory usage: These dashboards monitor the CPU and Memory usage, Network IOPs etc of the pods in the cluster.

**Screenshots/Links (if applicable):**
- Include screenshots or links showcasing the deployed application, CI/CD pipelines, and monitoring dashboards.

All images of applications running, pipeline successful run, services running on the cluster, grafana dashboard and prometheus webpage are in the repo of the Pull Requests.
---

### Testing the Solution

Provide clear instructions on how the evaluators can test and verify your solution. Include steps to:

The application is built, ran and deployed locally and in cloud using civo provider as the cloud provider.

All instructions on how to build,run and deploy successfully can be found in the [README.md](/README.md) file


---

### Additional Information

Include any other relevant information like:
**Challenges faced during the challenge and how they were overcome.** :
- Containerization of the docker images: Building and dockerizing a multi stage application is quite difficult when you are new to the tools, so i had a hard time trying to figure out how i can be able to build the application using a multi stage processes. 

- Solution: I visited [docker website](https://docs.docker.com/build/guide/multi-stage/) for more information on muilti stage processes
**Any improvements or features that could be added in the future** :

- I am completely satisfied with the entire process because the community has genuinely motivated me to perform better by consistently holding meetings and responding to questions and challenges we encountered on Slack.

**Feedback or comments on the challenge and your learning experience** :

- I would greatly appreciate it if this community could continue to offer this challenge and organize regular meetups for community members to foster their professional growth.

---

**Checklist:**
- [ ] The submission follows the format specified in the challenge instructions.
- [ ] The Dockerfile builds successfully and is optimized.
- [ ] The CI/CD pipeline is complete and functional.
- [ ] The IaC scripts are modular and reusable.
- [ ] The README file is clear and comprehensive.
- [ ] (Bonus) The monitoring setup is functional and comprehensive.

By submitting this pull request, I confirm that my contribution is made under the terms of the challenge’s requirements.
