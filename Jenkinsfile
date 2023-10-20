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
                    def URL = 'http://localhost:5000'
                    def RESPONSE = sh(script: "curl -s \${URL}", returnStatus: true).trim()

                    if (RESPONSE.contains('failed')) {
                        currentBuild.result = 'FAILURE'
                        error('Request failed: The response contains "failed".')
                    } else {
                        echo 'Request was successful.'

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
                        echo "hello world!"
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
}
