### Dockerfiles

`pyDockerfile` for the python proxy application
`vueDockerfile` for the vuejs application
`nginxDockerfile` for the nginx server

### 1. Dockerizing the Application and integrating the python application with the nginx server

Here i made an Image out of the application codes which was given to us without making changes to them, using a Dockerfile.
And as for the nginx server, i also makde an image out of the parent nginx image from DockerHub but replaced the the content of the file under the `/etc/nginx/conf.d` directory with the `nginx.conf` file that was given to us. Did that using the `COPY` command in the Dockerfile for the nginx server.

I Implemented caching best practice by having the processes which will not be having frequent changing like copying the `package*.json` file and installing the dependencies be at the top of the Dockerfile so that my updates during building the docker image would be faster because docker would cache those stages without changes for me, and the copying of other application files is below becuase of the updates taking place in the application configuration files. And i also implement a volume for updates on my image using the `docker-compose.yaml` file, for local development and testing, which i know isn't necessary but i was just flexing my abilities...

After building the application a docker-compose.yaml configuration file was created to run our application. And for the nginx container to be able to listen send request to our pythin flask proxy application, i had to change the `network_mode: host` from default to host in the docker-compose.yaml used in running the application after build

The vuejs application was configured to listen to the default port `8080`, the python application was configured to listen to the port `5000`, while the nginx server was also configured to listen to the default port `80`

For the security part, i implemented security best practice by making our environmental variables very well secured, using them as credentials on my jenkins environnment so be integrated inside my application when building my docker image on jenkins environment, and also using configMap while and encoding the variable values into base64, so that my EKS CLuster environment is going to see and make use of it and i can also update it anything locally.


### 2. Implementing the CI/CD stage

Here i made use of Jenkins and Amazon CodePipepline, with my jenkins file and integrating my jenkins to my repro using webhook to automate the oulling of updates i make to the reprository, i built multiple stages which comprises of, bulding the docker image, testing and running the image and deploying the image to amazon ECR. After that, amazon codePipeline is going to pull the image from amazon ECR and deploy it to a cloudFormation stck with will assist me in implement the next stage of this project.

here is a link to the screen recorded video on loon `https://www.loom.com/share/e0f90feac52144919fbb90de22ca40e4`


### IaC using AWS CloudFormation

Upon deploying my images to a cloudformation stack which is having configuration to deploy an EKS CLuster, i then moved on to deploy my cloudformation stck which craetes an EKS cluster for me running my images inside of it.