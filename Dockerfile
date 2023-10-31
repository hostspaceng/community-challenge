# # Pulling a secured python image and using as our base image
FROM python:3.10-alpine as api
LABEL maintainer="Mbanugo mbanugofranklyn678@gmail.com"

# # change to the working directoy 
WORKDIR /app

# # copy only the requirements file to cache dependencies
COPY requirements.txt .

# # installing the required dependencies
RUN pip install -r requirements.txt

# #set the working directory
COPY . .

# # set environmental variable for flask 
ENV FLASK_APP=main.py
ENV FLASK_ENV=development

# # expose the application on port 5000
EXPOSE 5000

CMD [ "flask", "run", "--host=0.0.0.0" ]


# create another base image using node
FROM node:lts-alpine as web

# make the 'app' folder the current working directory
WORKDIR /app


# copy both 'package.json' and 'package-lock.json'
COPY package*.json ./

# install project dependencies
RUN npm install

COPY . .


RUN npm run build


FROM nginx:alpine

WORKDIR /app

COPY --from=web /app/dist /app/dist

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
