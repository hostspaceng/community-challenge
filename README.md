# Cloudflare Domains Manager

Manage your Cloudflare domains with ease using the Cloudflare Domains Manager. This responsive and efficient application is built with a Vue.js frontend and a Python Flask backend.

![Screenshot](screenshot.png)


## Prerequisites

Ensure the following prerequisites are installed on your machine:

### Backend

- Python 3.9+
- Flask

### Frontend

- Node.js 14+
- npm or yarn

## Setup & Installation

Follow these instructions to set up the development environment on your local machine.

### 1. Clone the Repository

Clone the repository from [https://github.com/hostspaceng/challenge](https://github.com/hostspaceng/challenge).

```bash
git clone https://github.com/hostspaceng/challenge.git
cd challenge
```

### 2. Backend Setup

Navigate to the backend directory, install the required packages, and start the Flask development server.

#### Install Dependencies

```bash
python3 -m pip install -r requirements.txt
```

#### Set Environment Variables

Replace the placeholders in the `.env` sample file with your actual Cloudflare credentials and configurations or copy from  `.env.sample`

```plaintext
ZONE_ID=your_zone_id_here
CF_API_KEY=your_CF_API_KEY_here
CF_API_EMAIL=your_CF_API_EMAIL_here
```

#### Start the Development Server

```bash
export FLASK_APP=main.py
export FLASK_ENV=development
flask run
```

The Flask API server will be running on [http://localhost:5000](http://localhost:5000).

### 3. Frontend Setup

Navigate to the frontend directory, install the required packages, and start the development server.

#### Install Dependencies

```bash
npm install
```

Or if you're using Yarn:

```bash
yarn install
```

#### Set Environment Variables

Ensure that your `.env` file is populated with the necessary environment variables for development.

```plaintext
VUE_APP_PROXY_URL=http://localhost:5000/
```

#### Start the Development Server

```bash
npm run serve
```

Or for Yarn users:

```bash
yarn serve
```

Access the application on [http://localhost:8080](http://localhost:8080).

## Participation in the Challenge

For details on participating in the challenge, including writing a Dockerfile, setting up a CI/CD pipeline, and implementing Infrastructure as Code (IaC), please refer to the detailed challenge instructions provided.

Make sure to use the provided pull request template when submitting your solutions to facilitate a uniform and organized evaluation process.

For any questions or clarifications, reach out on the dedicated Slack channel. Happy coding!
