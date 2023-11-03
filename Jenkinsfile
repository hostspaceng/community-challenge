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


                        docker build -t vue-app .
                        docker build -t python-proxy -f pythonDockerfile .


                        docker compose -f docker-compose.yaml up -d


                    """
                }
            }
        }

        stage('Testing frontend application') {
            steps {
                script {
                    sh """

                        # Make API requests using cURL
                        curl -X GET http://localhost:8080/


                        # Check the HTTP status code (response code)
                        if [ $? -eq 0 ]; then
                            # If the exit status is 0, the cURL request was successful, and the HTTP status code is accessible in the response headers.
                            HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8080/")

                            if [ "$HTTP_STATUS" -eq 200 ]; then
                                echo "HTTP Status Code: $HTTP_STATUS (OK)"
                            else
                                echo "HTTP Status Code: $HTTP_STATUS (Not OK)"
                                exit 1
                            fi
                        else
                            echo "HTTP Request Failed"
                            exit 1
                        fi

                    """

                    
                }
            }
        }
        stage('Testing python-proxy application') {
            steps {
                script {
                    sh """

                        # Make API requests using cURL
                        curl -X GET http://localhost:5000/


                        # Check the HTTP status code (response code)
                        if [ $? -eq 0 ]; then
                            # If the exit status is 0, the cURL request was successful, and the HTTP status code is accessible in the response headers.
                            HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:5000/")

                            if [ "$HTTP_STATUS" -eq 200 ]; then
                                echo "HTTP Status Code: $HTTP_STATUS (OK)"
                            else
                                echo "HTTP Status Code: $HTTP_STATUS (Not OK)"
                                exit 1
                            fi
                        else
                            echo "HTTP Request Failed"
                            exit 1
                        fi

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
                    echo 'Pipeline Cmpleted'
                """
            }
        }
        failure {
            // Actions to take when the pipeline fails.

            sh "echo 'Pipeline Failed"
        }
        always {
            // Actions to take regardless of the pipeline result.
            def buildNumber = env.BUILD_NUMBER.toInteger()
            echo "This is pipeline run number: ${buildNumber}"
        }
    }
}
