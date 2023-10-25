#this is a multistage build
FROM node:lts-alpine as builder

# make the 'app' folder the current working directory
WORKDIR /app

# copy both 'package.json' and 'package-lock.json' 
COPY package*.json ./

# install project dependencies
RUN npm install
ENV VUE_APP_PROXY_URL=http://127.0.0.1:5000/
# copy project files and folders to the current working directory 
COPY . /app/
# builds app for production
RUN npm run build
# the second stage of the multibuild
FROM nginx:latest
#copies the distributables built by nodejs intonginx
COPY --from=builder /app/dist /usr/share/nginx/html
# copies the cginx configuration file to configure nginx
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/nginx.conf
#exposes port 80
EXPOSE 80
#this starts up nginx and also tells it to run in the foreground
CMD ["nginx", "-g", "daemon off;"]

