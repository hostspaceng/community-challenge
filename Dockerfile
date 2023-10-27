# Stage 1: Nginx
FROM python:latest as python-stage
WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY . /app
EXPOSE 5000
CMD ["python", "main.py"]

# Stage 2: Python
FROM nginx as nginx-stage
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

# Stage 3: Node.js for Vue.js
FROM node as vue-stage
RUN npm install -g http-server
WORKDIR /app
COPY package*.json ./
RUN npm install
ENV VUE_APP_PROXY_URL=http://localhost:5000/
COPY . .
RUN npm run build
EXPOSE 8080
CMD ["http-server", "dist"]
