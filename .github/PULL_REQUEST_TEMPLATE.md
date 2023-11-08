### Submission Pull Request Template

**Title:** [Submission] - [Victoria Akinyemi]

**Description:**

Provide a detailed summary of the changes included in this submission. Explain the problem you aimed to solve, the solutions you implemented, and the results achieved. Include any challenges faced and how they were overcome.
---

### Solution Details

**Dockerfile & Application Configuration:**
- Briefly describe how the Dockerfile was structured and how the application was configured, including any optimizations or specific configurations used.

The Dockerfile is structured to create a Docker image for the application. It starts with a base image, often a minimal Linux distribution, and follows these general steps:
1. Set the working directory.
2. Copy application source code and configuration files into the image.
3. Install application dependencies.
4. Configure environment variables.
5. Define the command to start the application.

**CI/CD Pipeline:**
- Explain the CI/CD pipeline’s flow, including the build, test, and deployment stages. Specify the tools and services used, and the reasons for choosing them.
- 
1. The CI/CD pipeline follows these stages:
2. Build: Source code is built into executable artifacts.
3. Test: Automated tests are run to validate code quality and functionality.
4. Deployment: Deploy the application to a staging environment.
5. Integration Tests: Further testing in a staging environment.
6. Deployment to Production: Deploy to the production environment.
Github Action was used because it simplifies the automation of your software development processes, enhances collaboration, and streamlines the release of high-quality software.

**Infrastructure as Code (IaC):**
- Provide information on the IaC scripts or tools used for provisioning and deployment. Include details of the deployment platform or cloud service utilized.
- 
IaC Scripts and Tools:In this project, Infrastructure as Code was used to provision and manage cloud resources. Terraform, a popular IaC tool, was utilized to define and deploy the infrastructure.Terraform scripts, written in HashiCorp Configuration Language (HCL), defined the AWS infrastructure components, such as EC2 instances, security groups, subnets, and more.These Terraform scripts were structured to create a Monitoring Server and a Web Application Server on AWS.

**Monitoring Setup (Bonus):**
- If implemented, describe the monitoring tools and configurations used. Include any custom dashboards or alerts set up to track application and infrastructure health.

Monitoring Tools and Configurations:Monitoring was implemented to track the health and performance of the deployed infrastructure and application.Two main monitoring tools were integrated into the environment:

Prometheus and Grafana.
Prometheus:Prometheus was installed and configured on the Monitoring Server using IaC scripts.The Prometheus configuration defined scrape intervals, job configurations, and data storage settings.It collected metrics from multiple targets, including itself, the Node Exporter, and the web application running on the Web Application Server.

Grafana:Grafana, a powerful visualization and dashboard tool, was set up on a separate server.The configuration of Grafana included setting up data sources, with Prometheus as the primary data source.Custom dashboards and panels could be created in Grafana to visualize metrics collected by Prometheus.

**Screenshots/Links (if applicable):**
- Include screenshots or links showcasing the deployed application, CI/CD pipelines, and monitoring dashboards.

---

### Testing the Solution

Provide clear instructions on how the evaluators can test and verify your solution. Include steps to:

1. Clone your forked repository.

clone the forked repository using the git clone command
  
   ```bash
   git clone https://github.com/Victoria-OA/community-challenge.git
   ```
3. Build and run the application using the provided Dockerfile.
  Navigate to the project directory and use the provided Dockerfile to build and run the application. Make sure you have Docker installed.
```
cd community-challenge 
docker build -t my-app .
docker run -p 8080:80 my-app
```

3. Deploy the application using the IaC scripts.
    Use the Infrastructure as Code (IaC) scripts, Terraform to deploy the application.
```
cd Infrastructure 
terraform init
terraform apply
```
4. Access and test the application’s functionality.
Access the deployed application in a web browser by visiting the appropriate URL or IP address. Test the application's functionality to ensure it's working correctly.

5. View and analyze the monitoring dashboards.
Access the monitoring dashboards for the application and infrastructure. Grafana and Prometheus to view and analyze the metrics and monitoring data.

```
http://[PROMETHEUS_SERVER_IP]:3000
```
Analyze the data to ensure your application is running smoothly and make any necessary adjustments to your infrastructure.

---

### Additional Information

Include any other relevant information like:
- Challenges faced during the challenge and how they were overcome.
     *** I couldn't complete my monitoring setup due to deadline.
- Any improvements or features that could be added in the future.
- Feedback or comments on the challenge and your learning experience.

---

**Checklist:**
- [✓ ] The submission follows the format specified in the challenge instructions.
- [ ✓] The Dockerfile builds successfully and is optimized.
- [ ✓] The CI/CD pipeline is complete and functional.
- [✓ ] The IaC scripts are modular and reusable.
- [ ✓] The README file is clear and comprehensive.
- [✓ ] (Bonus) The monitoring setup is functional and comprehensive.

By submitting this pull request, I confirm that my contribution is made under the terms of the challenge’s requirements.
