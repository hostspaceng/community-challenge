
## Workflow Name and Trigger

The workflow is named "Deploy Docker Image to AWS EC2" and is triggered to run on every push event to the "main" branch.

```yaml
name: Deploy Docker Image to AWS EC2
on:
  push:
    branches:
      - main
```

## Workflow Steps

### Step 1: Check Out Code

This step checks out the code from your repository using the `actions/checkout` action.

```yaml
- name: Checkout code
  uses: actions/checkout@v2

```

### Step 2: Configure AWS Credentials

In this step, you configure AWS credentials to enable interaction with AWS services. You use secrets to store the AWS access key, secret access key, and region.

```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v1
  with:
    aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    aws-region: ${{ secrets.AWS_REGION }}
```

### Step 3: Install Docker on GitHub Runner (Linux)

This step installs Docker on the GitHub runner. It runs when the GitHub runner OS is Linux.

```yaml
- name: Install Docker
  run: |
    # Install Docker on the runner
    sudo apt-get update -y
    sudo apt-get remove containerd.io
    sudo apt-get install -y docker.io
  if: runner.os == 'Linux'
```

### Step 4: Build Docker Image

Here, you build the Docker image based on your application code. The `docker build` command is used to create the image.

```yaml
- name: Build Docker Image
  run: |
    # Build your Docker image (change the build command accordingly)
    docker build -t myapp1:latest .
  working-directory: ./
```

### Step 5: Tag the Docker Image

This step tags the Docker image to prepare it for pushing to Docker Hub.

```yaml
- name: Tag the Docker image
  run: |
    docker tag myapp1:latest ${{ secrets.DOCKERHUB_USERNAME }}/myapp1:latest
  working-directory: ./
```

### Step 6: Push Docker Image to Docker Hub

This step logs in to Docker Hub using your Docker Hub username and password and pushes the Docker image to Docker Hub.

```yaml
- name: Push Docker Image to Docker Hub
  run: |
    # Login to Docker Hub and push the Docker image
    ## Set up Docker configuration to perform a non-interactive login
    echo "${{ secrets.DOCKERHUB_PASSWORD }}" | docker login -u ${{ secrets.DOCKERHUB_USERNAME }} --password-stdin
    docker push ${{ secrets.DOCKERHUB_USERNAME }}/myapp1:latest
  env:
    DOCKERHUB_USERNAME: ${{ secrets.DOCKERHUB_USERNAME }}
    DOCKERHUB_PASSWORD: ${{ secrets.DOCKERHUB_PASSWORD }}
```

### Step 7: Copy SSH Private Key and Set Permissions

In this step, you copy the SSH private key used for connecting to the EC2 instance and set the key file's permissions.

```yaml
- name: Copy SSH private key
  run: echo "${{ secrets.SSH_PRIVATE_KEY }}" > key.pem
- name: Set key file permissions
  run: chmod 600 key.pem
```

### Step 8: Install Docker on EC2

This step connects to the EC2 instance using SSH, installs Docker on the EC2 instance, and starts the Docker service.

```yaml
- name: Install Docker on EC2
  run: |
    echo ${{ secrets.SSH_PRIVATE_KEY }}" > key.pem
    chmod 600 key.pem
    ssh -i key.pem -o StrictHostKeyChecking=no ${{ secrets.SSH_USER }}@${{ secrets.SSH_HOST }} '
      # Install Docker on the EC2 instance
      sudo apt-get update -y
      sudo apt-get install -y docker.io
      sudo systemctl start docker
      sudo systemctl enable docker
    '
  env:
    AWS_REGION: ${{ secrets.AWS_REGION }}
    SSH_USER: ${{ secrets.SSH_USER }}
    EC2_INSTANCE_IP: ${{ secrets.EC2_INSTANCE_IP }}

```
### Step 9: Deploy Apps

This step deploys the Docker image to the EC2 instance. It logs in to Docker Hub, pulls the Docker image, and runs it on the EC2 instance.

```yaml
- name: Deploy Apps
  run: |
    echo "${{ secrets.SSH_PRIVATE_KEY }}" > key.pem
    chmod 600 key.pem
    ssh -i key.pem -o StrictHostKeyChecking=no ${{ secrets.SSH_USER }}@${{ secrets.SSH_HOST }} '
      sudo docker login -u ${{ secrets.DOCKERHUB