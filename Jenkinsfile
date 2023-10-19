pipeline {
    agent any  // You can specify the Jenkins agent here (e.g., 'docker', 'node', etc.)

    stages {
        stage('Checkout') {
            steps {
                // This step checks out your source code from a version control system (e.g., Git).
                // You can specify your VCS and credentials here.
                script{
                    sh """
                        #!/bin/bash

                        # Check if Nginx is installed
                        if ! command -v nginx &> /dev/null; then
                            echo "Nginx is not installed. Installing Nginx..."
                            sudo apt update
                            sudo apt install -y nginx
                        else
                            echo "Nginx is already installed."
f                       i

                        # Check if Nginx is running
                        if sudo systemctl is-active --quiet nginx; then
                            echo "Nginx is running."
                        else
                            echo "Nginx is not running. Starting Nginx..."
                            sudo systemctl start nginx
                        fi

                        # Check if Nginx is enabled to start at boot
                        if sudo systemctl is-enabled --quiet nginx; then
                            echo "Nginx is enabled to start at boot."
                        else
                            echo "Nginx is not enabled to start at boot. Enabling Nginx..."
                            sudo systemctl enable nginx
                        fi

                        echo "Nginx status:"
                        sudo systemctl status nginx

                    """
                }
            }
        }
        
        stage('Build') {
            steps {
                // Add build commands here (e.g., compiling code, running tests, etc.).
                 script{
                    sh """
                        echo "hello world!"
                    """
                }
            }
        }
        
        stage('Test') {
            steps {
                // Add testing commands here.
                 script{
                    sh """
                        echo "hello world!"
                    """
                }
            }
        }
        
        stage('Deploy') {
            steps {
                // Add deployment commands here (e.g., deploying to a server or cloud service).
                 script{
                    sh """
                        echo "hello world!"
                    """
                }
            }
        }
    }

    // post {
    //     success {
    //         // Actions to take when the pipeline is successful.
    //     }
    //     failure {
    //         // Actions to take when the pipeline fails.
    //     }
    //     always {
    //         // Actions to take regardless of the pipeline result.
    //     }
    // }
}
