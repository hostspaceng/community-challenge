# Pull Python image

FROM python:3.11.6-alpine3.18

# Set work directory
WORKDIR /app

# Copy requirements file to the image
COPY requirements.txt requirements.txt

# Install the packages from the file
RUN pip3 install -r requirements.txt

# Copy the code to the container
COPY main.py .

EXPOSE 5000

# Start python application
CMD ["python", "main.py"] 