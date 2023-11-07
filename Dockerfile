# # Pulling a secured python image and using as our base image
FROM python:3.10-alpine as api
LABEL maintainer="Mbanugo mbanugofranklyn678@gmail.com"

# # change to the working directory 
WORKDIR /app

# # copy only the requirements file to cache dependencies
COPY requirements.txt .

# # installing the required dependencies
RUN pip install -r requirements.txt

# #set the working directory
COPY . .

# # set environmental variable for flask 
ENV FLASK_APP=main.py


# # expose the application on port 5000
EXPOSE 5000

CMD [ "flask", "run", "--host=0.0.0.0" ]




# create another base image for frontend application
FROM node:lts-alpine as web

# make the 'app' folder the current working directory
WORKDIR /app


# copy both 'package.json' and 'package-lock.json'
COPY package*.json ./

# install project dependencies
RUN npm install

# copy the all files and folders to the current directory
COPY . .


# run the application development
RUN npm run build


# another base image to route traffic to both the frontend and backend application
FROM nginx:alpine

# change to the working directoy
WORKDIR /app

# copy the frontend build to /app/dist
COPY --from=web /app/dist /app/dist

# remove the default nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# copy new nginx.conf to the nginx directory
COPY nginx.conf /etc/nginx/conf.d/

# expose application on port 80
EXPOSE 80

# run the nginx application
CMD ["nginx", "-g", "daemon off;"]
