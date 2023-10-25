FROM node:14 as vue-builder
WORKDIR /app
COPY ./package*.json ./
COPY ./package-lock.json ./
RUN npm install
COPY . /app
RUN npm run build
#RUN npm run serve

# Python Flask build stage
FROM python:3.8-slim-buster as flask-builder
WORKDIR /backend
COPY ./requirements.txt /backend/
RUN pip install -r /backend/requirements.txt
ENV ZONE_ID=88212a53b6feba598b197f3508f35b52 \
    CF_API_KEY=ab590d1c5d3139416fef3d173ad4267a75a41 \
    CF_API_EMAIL=safe@hostspaceng.com \
    VUE_APP_PROXY_URL=http://127.0.0.1:5000/

# Nginx stage
FROM nginx:alpine
# RUN rm -rf /usr/share/nginx/html/*
# RUN mv /app/dist /usr/share/nginx/html
COPY --from=vue-builder /app/dist /app/dist
COPY ./dist /usr/share/nginx/html
COPY --from=flask-builder /backend /app
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
