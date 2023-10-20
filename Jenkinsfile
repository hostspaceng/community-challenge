pipeline {
    agent any  // You can specify the Jenkins agent here (e.g., 'docker', 'node', etc.)

    stages {
        stage('Checkout') {
            steps {
                // This step checks out your source code from a version control system (e.g., Git).
                // You can specify your VCS and credentials here.
                script{
                    sh """
                        echo "Checking out!!"
                        
                    """
                }
            }
        }
        
        stage('Build and run Docker Images') {
            steps {
                // Add build commands here (e.g., compiling code, running tests, etc.).
                 script{
                    sh """
                        docker build -t python-project -f pyDockerfile .

                        docker build -t vue-project -f vueDockerfile .

                        docker compose -f docker-compose.yaml up

                    """
                }
            }
        }
        
        stage('Test') {
            steps {
                // Add testing commands here.
                 script{
                    sh """
                            npm run jest

                            # Define the URL you want to send a GET request to
                            URL="http://localhost:5000"

                            # Send a GET request using curl and store the response in a variable
                            RESPONSE=$(curl -s $URL)

                            # Check if the response contains the word "failed"
                            if echo $RESPONSE | grep -q "failed"; then
                            echo "Request failed: The response contains 'failed'."
                            exit 1
                            else
                            echo "Request was successful."
                            exit 0
                            fi

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

    post {
        success {
            // Actions to take when the pipeline is successful.

            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws']]) {
                    sh """
                     aws sns publish --topic-arn arn:aws:sns:us-east-1:879092596042:new_topic --subject "pipeline success" --message "pipeline failed!" --region us-east-1
                    """
                }
        }
        failure {
            // Actions to take when the pipeline fails.
        }
        always {
            // Actions to take regardless of the pipeline result.
        }
    }
}
