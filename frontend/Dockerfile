# Setting base image for the build stage
FROM node:18.18.2-buster-slim as build

# Setting the work dir for the application
WORKDIR /app

# Copying node packages to working directory
COPY package*.json ./

# Install curl for health check 
RUN apt-get update && apt-get install -y curl

# Installing the dependencies for the application
RUN npm install

# Copying other application files to work directory
COPY . .

# Building production build
RUN npm run build

# Setting nginx image for serving frontend application in the final stage
FROM nginx:alpine

# Copy the build folder from the build stage to the nginx configuration
COPY --from=build /app/dist /app/dist

RUN ls -l /app/dist

# Removing the default nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copying nginx configuration file to nginx configuration directory
COPY nginx.conf.template /etc/nginx/conf.d/

# Copying nginx start-up script to the binary folder
COPY nginx.sh /usr/local/bin/

# Setting nginx start-up script to be executable
RUN chmod +x /usr/local/bin/nginx.sh

# Expose application port
EXPOSE 80

# Setting the start-up command
CMD [ "nginx.sh" ]

# Define a healthcheck
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -I http://localhost:80 || exit 1