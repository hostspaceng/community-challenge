
---

# Multi-Stage Dockerfile Documentation

This documentation describes a Dockerfile with multiple stages that allows you to build and deploy a web application with a Vue.js frontend, a Python Flask backend, and serve it using Nginx. This approach is beneficial for keeping the resulting Docker image lightweight and efficient.

## Stage 1: Vue.js Frontend Builder

### Base Image

The Docker build process begins with a Node.js 14 base image. It provides the necessary environment to build a Vue.js frontend.

Dockerfile
FROM node:14 as vue-builder


### Working Directory

We set the working directory in the Docker container to `/app`, which is where the Vue.js application will be built and placed.

Dockerfile
WORKDIR /app


### Copy Package Files

Next, we copy the `package.json` and `package-lock.json` files from the local directory to the container. This is a common practice to separate dependency installation from source code.

```Dockerfile
COPY ./package*.json ./
COPY ./package-lock.json ./
```

### Install Dependencies

We run `npm install` to install the frontend application's dependencies based on the `package.json` files.

```Dockerfile
RUN npm install
```

### Copy Application Code

We then copy the entire application source code to the container. This includes Vue.js source files, components, and assets.

```Dockerfile
COPY . /app
```

### Build the Vue.js Application

The `npm run build` command is executed to build the Vue.js application. This generates optimized static files for the frontend.

```Dockerfile
RUN npm run build
```

The "RUN npm run serve" line is commented out as serving the application is not required in the build stage.

## Stage 2: Python Flask Backend Builder

### Base Image

In the next stage, we start with a Python 3.8 slim-buster base image, which is suitable for running Flask applications.

```Dockerfile
FROM python:3.8-slim-buster as flask-builder
```

### Working Directory

The working directory for this stage is set to `/backend`, where the Python Flask application will be built.

```Dockerfile
WORKDIR /backend
```

### Copy Requirements File

We copy the `requirements.txt` file from the local directory to the container. This file contains the Python packages required by the Flask application.

```Dockerfile
COPY ./requirements.txt /backend/
```

### Install Python Dependencies

We use `pip install` to install the Python dependencies specified in the `requirements.txt` file.

```Dockerfile
RUN pip install -r /backend/requirements.txt
```

### Environment Variables

This section sets environment variables that can be used by the Flask application. They are used to configure the application to interact with external services.

```Dockerfile
ENV ZONE_ID=88212a53b6feba598b197f3508f35b52 \
    CF_API_KEY=ab590d1c5d3139416fef3d173ad4267a75a41 \
    CF_API_EMAIL=safe@hostspaceng.com \
    VUE_APP_PROXY_URL=http://127.0.0.1:5000/
```

## Stage 3: Nginx for Serving

### Base Image

In the final stage, we use the official Nginx Alpine Linux base image to serve the built web application.

```Dockerfile
FROM nginx:alpine
```

### Remove Default Nginx Files (Optional)

If needed, you can remove the default files from the Nginx directory to make space for your application. The following lines are commented out but can be used if required.

```Dockerfile
# RUN rm -rf /usr/share/nginx/html/*
# RUN mv /app/dist /usr/share/nginx/html
```

### Copy Vue.js Frontend

We copy the built Vue.js frontend from the `vue-builder` stage to the Nginx container. This is the part of the application that Nginx will serve.

```Dockerfile
COPY --from=vue-builder /app/dist /app/dist
```

### Copy Python Flask Backend

We copy the Flask application built in the `flask-builder` stage to the Nginx container. This allows Nginx to proxy requests to the Flask application.

```Dockerfile
COPY --from=flask-builder /backend /app
```

### Nginx Configuration

We copy an Nginx configuration file (`nginx.conf`) from the local directory to the container. This configuration file specifies how Nginx should serve the application and proxy requests to the Flask backend.

```Dockerfile
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
```

### Expose Port

We expose port 80 in the Docker container, as Nginx typically listens on this port.

```Dockerfile
EXPOSE 80
```

### Start Nginx

The final command starts Nginx in the container, making it ready to serve the web application.

```Dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

## Conclusion

This multi-stage Dockerfile efficiently builds and deploys a web application with Vue.js and Python Flask, serving it using Nginx. The use of multiple stages keeps the resulting Docker image lightweight and production-ready.

---
