# Stage 1: Node.js for Vue.js
FROM node as vue-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


# Stage 2: nginx
FROM nginx as nginx-stage
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=vue-stage /app/dist /usr/share/nginx/html
ENV VUE_APP_PROXY_URL=http://localhost:80/proxy/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



