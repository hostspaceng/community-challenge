# build stage
FROM node:lts-alpine as build-stage
RUN mkdir /app
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


#using nginx
FROM nginx:stable-alpine as production-stage

COPY --from=build-stage /app/dist /app/dist

# Removing the default nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



