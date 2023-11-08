# LINKS FOR THE RECORDED VIDEOS WILL BE SEEN AT THE END OF THIS DOCUMENTATION


Frontend - Vue.js 
Backend - Python-Flask
Reverse Proxy server - Nginx

### Dockerfiles

`/Dockerfile` for the vuejs front-end application
`/backend/Dockerfile` for the vuejs application

### 1. Dockerizing all Application and setting Nginx Configuration

Using Multi-staging, i made a Dockerfile to build my vuejs application having Nginx serve as a reverse proxy server for my vuejs application, and i also created a seperate docker image using another Dockerfile for my python proxy application.

I Implemented caching best practice by having the processes which will not be having frequent changing like copying the `package*.json` file and installing the dependencies be at the top of the Dockerfile so that my updates during building the docker image would be faster because docker would cache those stages without changes for me, and the copying of other application files is below becuase of the updates taking place in the application configuration files. And i also implement a volume for updates on my image using the `docker-compose.yaml` file, for local development and testing, which i know isn't necessary but i was just flexing my abilities...


For the security part, i implemented security best practice by making our environmental variables very well secured, using them as credentials on my jenkins environnment to be integrated inside my application when building my docker image on jenkins environment, and also added them to the `ENV` command in the Dockerfile so that these environmental variables are going to be within the application and would not be accessed externally. And also to access aws CLI i integrated my AWS access keys as credentials to be able to use aws CLI commands.


### 2. Implementing the CI/CD stage

Here i made use of Jenkins, with my jenkins file and integrating my jenkins to my repro using the github webhook to automate the pulling of updates i make to the reprository, i built multiple stages which comprises of, bulding the docker image, testing and running the image and deploying the image to amazon ECR, and also deployng my image to my eks cluster using the kubernetes configuration file that's located inside the `/k8s` directory if the piple is a success.


### IaC using AWS CloudFormation

Upon deploying my images to my ECR repros, i then moved on to deploy my cloudformation stack `hostober_challenge_cloudformation.yaml` and `vpc_stack.yaml` which creates an EKS cluster and all networking configuration under the VPC automatically. I made configuration files for my EKS deployment and also for nginx ingress crontroler whih help me create an Elastic Load Balancer to help route traffic to my application and deployed my application to my EKS cluster.



# VIDEO LINK FOR MAIN CHALLENGE
`https://www.loom.com/share/9b62235061bf4f75950af2ea6ec5f439?sid=2e41f249-cb75-473e-a38d-baf6b5feb432`


Front-End PNG
![frontend-application](<Screenshot from 2023-11-06 22-10-09.png>)

Back-End PNG

![backend-application](<Screenshot from 2023-11-06 22-10-29.png>)




# Monitoring Implementation

I have implemented my monitoring using Premetheus and Grafana, configured together to bring metrics from the pods running on my EKS cluster... below is a link to the recorded video showing the monitoring i implemented...

`https://www.loom.com/share/32f7a886ddc940a9ba13e0bb8a481275?sid=671120ac-c4a2-4471-b206-e49b41f60437`

Prometheus

![Prometheus](<Screenshot from 2023-11-06 22-10-02.png>)


Grafana 

![Grafana](<Screenshot from 2023-11-06 22-09-53.png>)


## STEPS TO BUILD AND RUN THE IMAGES

To run and test this application locally, you will need to build this application usiing the `docker build` command.
For the front-end abblication, you should run 
`docker build --build-arg  backend_endpoint=http://localhost:5000 -t <preferred image name> .` 
and the image will be built, then to run the image and have your running container, you the should the following command 
`docker run -d -p 8080:80 --name <choose a container name> <image name>`.
then you can visit `http://localhost:8080` to access the application, but before that, you should build and run the backend application first.
To do that use the following command
`cd backend`
`docker build -t <preferred image name> .`
then, the image would be built, it run the image, run;
`docker run -d -p 5000:5000 --name <choose a container name> <image name>`.


