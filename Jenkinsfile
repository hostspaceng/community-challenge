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
                        docker build -t nginx-http-proxy -f nginxDockerfile .
                    """
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker compose -f docker-compose.yaml up
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
                            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 206080409328.dkr.ecr.us-east-1.amazonaws.com
                            docker tag nginx-http-proxy:latest 206080409328.dkr.ecr.us-east-1.amazonaws.com/nginx-http-proxy:latest
                            docker push 206080409328.dkr.ecr.us-east-1.amazonaws.com/nginx-http-proxy:latest


                            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 206080409328.dkr.ecr.us-east-1.amazonaws.com
                            docker tag python-project:latest 206080409328.dkr.ecr.us-east-1.amazonaws.com/python-project:latest
                            docker push 206080409328.dkr.ecr.us-east-1.amazonaws.com/python-project:latest


                            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 206080409328.dkr.ecr.us-east-1.amazonaws.com
                            docker tag vue-project:latest 206080409328.dkr.ecr.us-east-1.amazonaws.com/vue-project:latest
                            docker push 206080409328.dkr.ecr.us-east-1.amazonaws.com/vue-project:latest

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
