pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    sh """
                        echo "Checking out!!"
                    """
                }
            }
        }

        stage('Build and run Docker Images') {
            steps {
                script {
                    sh """
                        docker build -t python-project -f pyDockerfile .
                        docker build -t vue-project -f vueDockerfile .
                        docker-compose -f docker-compose.yaml up -d
                    """
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    def URL = 'http://localhost:5000'
                    def RESPONSE = sh(script: "curl -s \${URL}", returnStatus: true).trim()

                    if (RESPONSE == 0) {
                        currentBuild.result = 'FAILURE'
                        error('Request failed: The response contains "failed".')
                    } else {
                        echo 'Request was successful.'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh """
                        echo "hello world!"
                    """
                }
            }
        }
    }

    post {
        success {
            script {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws']]) {
                    sh """
                            echo 'hello world'
                    """
                }
            }
        }
        failure {
            // Actions to take when the pipeline fails.

            sh "echo 'hello world'"
        }
        always {
            // Actions to take regardless of the pipeline result.
            sh "echo 'hello world'"
        }
    }
}
