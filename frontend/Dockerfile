# Setting base image 
FROM node:18.18.2-buster-slim as build

# Setting the work dir for the application
WORKDIR /app

# Copying node packages to working directory
COPY package*.json ./

# Installing the dependencies for the application
RUN npm install

# Copying other application files to work directoty
COPY . .

# Building production build
RUN npm run build

# Setting nginx image for serving frontend application 
FROM nginx:alpine

# Copying build folder to /app/dist root directory of the nginx configuration
COPY --from=build /app/dist /app/dist

# Removing the default nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copying nginx configuration file to nginx configuration directory
COPY nginx.conf.template /etc/nginx/conf.d/

# Copying nginx start up script to the binary folder
COPY nginx.sh /usr/local/bin/

# Setting nginx start up script to be executable
RUN chmod +x /usr/local/bin/nginx.sh

# Exposing application port
EXPOSE 80

# Setting the start up command
CMD [ "nginx.sh" ]