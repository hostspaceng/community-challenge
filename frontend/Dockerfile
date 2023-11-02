# Pull base image from node alpine

FROM node:18-alpine3.18 AS builder

# set work dir
WORKDIR /app

# Copying json files
COPY *.json  .

# installing the packages from the json file
RUN npm install

# copying the whole source code
COPY . .

# build to package the frontend code
RUN npm run build

# production stage
FROM nginx:alpine3.18

WORKDIR /app/dist

# overwrite the default nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the build folder from the build stage to serve in ngnx
COPY --from=builder /app/dist .

# expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

