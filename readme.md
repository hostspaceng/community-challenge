# LINKS FOR THE RECORDED VIDEOS WILL BE SEEN AT THE END OF THIS DOCUMENTATION


### Dockerfiles

`/Dockerfile` for the vuejs front-end application
`/backend/Dockerfile` for the vuejs application

### 1. Dockerizing all Application and setting Nginx Configuration

Here i made an Image out of the application codes which was given to us without making changes to them, using a Dockerfile.
And as for the nginx server, i also makde an image out of the parent nginx image from DockerHub but replaced the the content of the file under the `/etc/nginx/conf.d` directory with the `nginx.conf` file that was given to us. Did that using the `COPY` command in the Dockerfile for the nginx server.

I Implemented caching best practice by having the processes which will not be having frequent changing like copying the `package*.json` file and installing the dependencies be at the top of the Dockerfile so that my updates during building the docker image would be faster because docker would cache those stages without changes for me, and the copying of other application files is below becuase of the updates taking place in the application configuration files. And i also implement a volume for updates on my image using the `docker-compose.yaml` file, for local development and testing, which i know isn't necessary but i was just flexing my abilities...


For the security part, i implemented security best practice by making our environmental variables very well secured, using them as credentials on my jenkins environnment so be integrated inside my application when building my docker image on jenkins environment, and also aded them to the `ENV` command in the Dockerfile to that these environmental variables are going to be within the application and would not be accessed externally.


### 2. Implementing the CI/CD stage

Here i made use of Jenkins, with my jenkins file and integrating my jenkins to my repro using webhook to automate the pulling of updates i make to the reprository, i built multiple stages which comprises of, bulding the docker image, testing and running the image and deploying the image to amazon ECR, and also deployng my image to my eks cluster using the kubernetes configuration file that's located inside the `/k8s` directory if the piple is a success.


### IaC using AWS CloudFormation

Upon deploying my images to my ECR repros, i then moved on to deploy my cloudformation stack `hostober_challenge_cloudformation.yaml` and `vpc_stack.yaml` which creates an EKS cluster and all networking configuration under the VPC automatically. I made configuration files for my EKS deployment and also for nginx ingress crontroler whih help me create an Elastic Load Balancer to help route traffic to my application and deployed my application to my EKS cluster.



### VIDEO LINK FOR MAIN CHALLENGE
`https://www.loom.com/share/9b62235061bf4f75950af2ea6ec5f439?sid=2e41f249-cb75-473e-a38d-baf6b5feb432`