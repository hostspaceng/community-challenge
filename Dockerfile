# Stage 1: Build Vue.js application
FROM node:14 as vue-build
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .
ENV VUE_APP_PROXY_URL=$backend_endpoint
RUN npm run build


# Stage 2: Create Nginx container
FROM nginx as nginx-container
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=vue-build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


