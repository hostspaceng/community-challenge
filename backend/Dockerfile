# Setting base image
FROM python:3.9.18-slim-bullseye

# Create application work dir
WORKDIR /app

# Copy dependencies
COPY requirements.txt ./

# Install application requirements
RUN pip3 install -r requirements.txt

# Copy appliication file
COPY . /app/

# Setting flask startup file
ENV FLASK_APP=main.py

# Setting the flask debug variable
ENV FLASK_DEBUG=1

# Executable Command
CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0" ]

# Expose application port
EXPOSE 5000