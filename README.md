### Submission Pull Request Template

**Title:** [Submission] - [Abdulsalam Abdulrazaq]

**Description:**

- Prividing a solution to this challenge, i have integrated best practices to my level of undertsanding on CI/CD pipleine and best practices to automate the the development and deployment of this application, and also creating of docker images to make images as small in seze as possible and as efficient as possible, also making use of IaC to automate the provisioning of my infrastructures on the cloud for deployments.

---

### Solution Details

**Dockerfile & Application Configuration:**
- Using Multi-staging, i made a Dockerfile to build my vuejs application having Nginx serve as a reverse proxy server for my vuejs application, and i also created a seperate docker image using another Dockerfile for my python proxy application.

- I Implemented caching best practice by having the processes which will not be having frequent changing like copying the `package*.json` file and installing the dependencies be at the top of the Dockerfile so that my updates during building the docker image would be faster because docker would cache those stages without changes for me, and the copying of other application files is below becuase of the updates taking place in the application configuration files. And i also implement a volume for updates on my image using the `docker-compose.yaml` file, for local development and testing, which i know isn't necessary but i was just flexing my abilities...

- For the security part, i implemented security best practice by making our environmental variables very well secured, using them as credentials on my jenkins environnment to be integrated inside my application when building my docker image on jenkins environment, and also added them to the `ENV` command in the Dockerfile but not passing the values directly but instaed getting the values from environ mental variables locally and also my my CO/CD pipeline during build process, so that these environmental variables are going to be within the application and would not be accessed externally. And also to access aws CLI i integrated my AWS access keys as credentials to be able to use aws CLI commands. and i also made use of the .env file for the python application to pass the required variables inot the application.

**CI/CD Pipeline:**
- Here i made use of Jenkins, with my jenkins file and integrating my jenkins to my repro using the github webhook to automate the pulling of updates i make to the reprository, i built multiple stages which comprises of, bulding the docker image, testing and running the image and deploying the image to amazon ECR, and also deployng my image to my eks cluster using the kubernetes configuration file that's located inside the `/k8s` directory if the piple is a success.

- The first stage is a checkout stage which just basically checks the branch of the reprository my pipeline is working with.

- Next, i built and images and using a docker compose file, i ran my docker images out of the application code provided to us, passing the backend endpoint as an environmental variable, because the backend endpoint for my development environment is different from the one on my deployment environment.

- The next stage, i testing my running containers locally, sending a get request and getting the status code of the responds to see if my applications are running perfectly fine and good for deployments.

- After testing my application locally, the next stage i built the images again passing throught the variable needed for my deployment environment because this next stage my docker image was being pushed to my Amazon ECR reprository, passing my AWS credentails as a credential variable in my jenkins credentials for safe and secure usage of my aws credentials, for further development and testing.

- The next step only takes place if the whole pipeline is a sucess, which is a POST stage, which is, deploying my images to my Amazon EKS cluster which is already running and i have provisioned it using an IaC tool from AWS called CloudFormation. here i will pass the current version of my image into my kubernetes deployment vonfiguration file to know the right image to deploy

**Infrastructure as Code (IaC):**
- Upon deploying my images to my ECR repros, i then moved on to deploy my cloudformation stack `hostober_challenge_cloudformation.yaml`, `vpc_stack.yaml` and  `ingress-service.yaml`  which creates an EKS cluster and all networking configuration under the VPC automatically. I made configuration files for my EKS deployment and also for nginx ingress crontroler whih help me create an Elastic Load Balancer to help route traffic to my application and deployed my application to my EKS cluster. And also for my k8s Addons for Prometheus and Grafana, which is an EBS CSI Controller.

**Monitoring Setup (Bonus):**
- I have implemented my monitoring using Premetheus and Grafana, configured together to bring metrics from the pods running on my EKS cluster. using the `grafana.yaml` configuration inside of the `/k8s` directory, i have also configured grafana to run for monitoring the running containers.

**Screenshots/Links (if applicable):**
- Front-End PNG
![frontend-application](<Screenshot from 2023-11-06 22-10-09.png>)

- Back-End PNG

![backend-application](<Screenshot from 2023-11-06 22-10-29.png>)

- Prometheus

![Prometheus](<Screenshot from 2023-11-06 22-10-02.png>)

- Grafana 

![Grafana](<Screenshot from 2023-11-06 22-09-53.png>)


`https://www.loom.com/share/9b62235061bf4f75950af2ea6ec5f439?sid=2e41f249-cb75-473e-a38d-baf6b5feb432`

`https://www.loom.com/share/32f7a886ddc940a9ba13e0bb8a481275?sid=671120ac-c4a2-4471-b206-e49b41f60437`


---

### Testing the Solution

Provide clear instructions on how the evaluators can test and verify your solution. Include steps to:

1. Clone your forked repository.
2. Build and run the application using the provided Dockerfile.
3. Deploy the application using the IaC scripts.
4. Access and test the application’s functionality.
5. View and analyze the monitoring dashboards.

---

### Additional Information

Include any other relevant information like:
- I ahve faced some challenges with the multi-stage docker image creating, which i have learnt from and also learnt how i can make effective use of amazon eks, prometheus and Grafana in real world aplications...
- I would love to have added a lot of features on the monitoring aspect of this challenge, but time hasn't permited me, but i will continue working on it even after submitting this.
- This was a great experience! i would love to say, i was tired when i had issues, but i never let that pulled me back, i ws burnt out of the stress of trying to work with things i ahve not worked with before, whivh made me do a lot of documention reading and spending time with chatGPT. Thank you! ones again...

---

**Checklist:**
- [x] The submission follows the format specified in the challenge instructions.
- [x] The Dockerfile builds successfully and is optimized.
- [x] The CI/CD pipeline is complete and functional.
- [x] The IaC scripts are modular and reusable.
- [x] The README file is clear and comprehensive.
- [x] (Bonus) The monitoring setup is functional and comprehensive.

By submitting this pull request, I confirm that my contribution is made under the terms of the challenge’s requirements.
