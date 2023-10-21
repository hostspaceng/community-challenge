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