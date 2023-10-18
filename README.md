# Cloudflare Domains Manager

Manage your Cloudflare domains with ease using the Cloudflare Domains Manager. This responsive and efficient application is built with a Vue.js frontend and a Python Flask backend. 

![Screenshot](screenshot.png)


## Prerequisites

The applications are deployed using docker compose locally. Ensure the following prerequisite is installed on your local machine:

### Backend and Frontend
- Docker
- Docker Compose

## Setup & Installation

Follow these instructions to set up the development environment on your local machine.

### 1. Clone the Repository

Clone the repository from https://github.com/Okeybukks/community-challenge.git .

```bash
git clone https://github.com/Okeybukks/community-challenge.git
cd community-challenge
```

### 2. Machine Setup

The test environment I used is Ubuntu 20.04.6 LTS. Whatever machine is used, ensure you have docker and docker compose installed by running this command.

```
docker version
docker compose version
```

#### Set Environment Variables

Replace the placeholders in the `.env` sample file with your actual Cloudflare credentials and configurations or copy from  `.env.sample`. To use the environment file during the deployment with docker, rememeber to rename to `.env`.

```plaintext
ZONE_ID=your_zone_id_here
CF_API_KEY=your_CF_API_KEY_here
CF_API_EMAIL=your_CF_API_EMAIL_here
VUE_APP_PROXY_URL=IP_ADDRESS_OF_MACHINE
```

For my test environment, the IP of the Linux machine is 192.168.56.28

#### Start the Application

```bash
docker compose -f dockercompose.yaml up
```
The command builds the docker images specified in the dockercompose.yaml file and the starts up the application.

If you want to only build the application images only with out starting the applications, run this command.

```bash
docker compose -f dockercompose.yaml build
```

The above command creates two images; the Vue application and Flask application. You can see the created docker images using this command.

```bash
docker images
```
Because the application is served using Nginx, the Flask API server will be running on [http://IP/proxy/](http://IP/proxy/).

In my case, the Flask API is running on [http://192.168.56.28/proxy/](http://192.168.56.28/proxy/). The Falsk application is also running on [http://192.168.56.28:5000](http://192.168.56.28:5000)

The Vue application is runing on [http://IP](http://IP), In my case, the Flask API is running on [http://192.168.56.28](http://192.168.56.28) 

