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
                    sh """
                        python_url="http://localhost:5000"  # Change the port to match your server

                        # Make an HTTP request to the application
                        response=$(curl -s -o /dev/null -w "%{http_code}" "$app_url")

                        # Check the HTTP response status code
                        if [ "$response" !== "000" ]; then
                            echo "Application server is up and running."
                             # Add your actions here
                        else
                            echo "Application server is not responding or returned an error (HTTP $response)."
                            # Add alternative actions or error handling here

                            docker compose -f python.yaml up
                        fi


                        vue_url="http://localhost:8080"  # Change the port to match your server

                        # Make an HTTP request to the application
                        vue_response=$(curl -s -o /dev/null -w "%{http_code}" "$vue_url")

                        # Check the HTTP response status code
                        if [ "$vue_response" !== "000" ]; then
                            echo "Application server is up and running."
                             # Add your actions here
                        else
                            echo "Application server is not responding or returned an error (HTTP $response)."
                            # Add alternative actions or error handling here

                            docker compose -f vue.yaml up
                        fi


                        nginx_url="http://localhost:80"  # Change the port to match your server

                        # Make an HTTP request to the application
                        nginx_response=$(curl -s -o /dev/null -w "%{http_code}" "$app_url")

                        # Check the HTTP response status code
                        if [ "$nginx_response" !== "000" ]; then
                            echo "Application server is up and running."
                             # Add your actions here
                        else
                            echo "Application server is not responding or returned an error (HTTP $response)."
                            # Add alternative actions or error handling here

                            docker compose -f nginx.yaml up
                        fi
                    """
                    
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
