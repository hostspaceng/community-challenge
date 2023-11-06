# Stage 1: Build Vue.js application
FROM node:14 as vue-build
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .
ENV VUE_APP_PROXY_URL=http://aacf724f1ada5446cb70e439e677aa09-761205241.us-east-1.elb.amazonaws.com/proxy/
RUN npm run build

# Stage 2: Build Python Flask application
#FROM python:3.8 as flask-build
#WORKDIR /app
#COPY backend/requirements.txt ./
#RUN pip install -r requirements.txt
#COPY backend/ .
#CMD ["python", "main.py"]


# Stage 3: Create Nginx container
FROM nginx as nginx-container
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=vue-build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# Stage 4: Combine Vue.js, Python, and Nginx
#FROM nginx-container
#COPY --from=flask-build /app /app

# Additional configuration

