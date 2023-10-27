pipeline {
    agent any

    environment {
        // Define global environment variables
        ZONE_ID = credentials('ZONE_ID')
        CF_API_KEY = credentials('CF_API_KEY')
        CF_API_EMAIL = credentials('CF_API_EMAIL')
        VUE_APP_PROXY_URL = credentials('VUE_APP_PROXY_URL')
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    
                        git branch: 'main', url: 'https://github.com/abdulfrfr/community-challenge.git'
                    
                }
            }
        }

        stage('Build and run Docker Images') {
            steps {
                script {
                    sh """

                        export ZONE_ID=$ZONE_ID
                        export CF_API_KEY=$CF_API_KEY
                        export CF_API_EMAIL=$CF_API_EMAIL
                        export VUE_APP_PROXY_URL=$VUE_APP_PROXY_URL


                        docker build --target nginx-stage -t nginx-http-proxy .
                        docker build --target python-stage -t python-project .
                        docker build --target vue-stage -t vue-project  .
                    """
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh """
                        docker compose -f docker-compose.yaml up -d
                    """

                    
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS']]) {
                    sh """
                            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 206080409328.dkr.ecr.us-east-1.amazonaws.com

                    """
                }

                    sh """

                            docker tag nginx-http-proxy:latest 206080409328.dkr.ecr.us-east-1.amazonaws.com/nginx-http-proxy:latest
                            docker push 206080409328.dkr.ecr.us-east-1.amazonaws.com/nginx-http-proxy:latest


                            docker tag python-project:latest 206080409328.dkr.ecr.us-east-1.amazonaws.com/python-project:latest
                            docker push 206080409328.dkr.ecr.us-east-1.amazonaws.com/python-project:latest


                            docker tag vue-project:latest 206080409328.dkr.ecr.us-east-1.amazonaws.com/vue-project:latest
                            docker push 206080409328.dkr.ecr.us-east-1.amazonaws.com/vue-project:latest

                    """
                }
            }
        }
    }

    post {
        success {
            script {
                sh """
                    echo 'hello world'
                """
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
