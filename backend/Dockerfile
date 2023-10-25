#base operating system that is small enough
FROM python:3.9-alpine
#selects a working directory
WORKDIR /app
#copy presents directory to app directory
COPY . /app
#install requirements from specified file
RUN pip install -r requirements.txt
#environmental variables for flask to run
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV FLASK_APP=main.py
ENV FLASK_ENV=development
#enviromental variables for config
ENV ZONE_ID=88212a53b6feba598b197f3508f35b52
ENV CF_API_KEY=ab590d1c5d3139416fef3d173ad4267a75a41
ENV CF_API_EMAIL=safe@hostspaceng.com
#exposes port 500
EXPOSE 5000
#commands to pass
CMD [ "flask", "run","--host","0.0.0.0","--port","5000"]
