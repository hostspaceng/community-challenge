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

                        export ZONE_ID=$ZONE_ID
                        export CF_API_KEY=$CF_API_KEY
                        export CF_API_EMAIL=$CF_API_EMAILVUE_APP_PROXY_URL 
                        export VUE_APP_PROXY_URL=$VUE_APP_PROXY_URL


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

                        # Make an HTTP request to the Python application
                        

                        # Check the HTTP response status code
                        if [ \$(curl -s -o /dev/null -w "%{http_code}" "\$python_url") -ne "000" ]; then
                            echo "Python application server is up and running."
                            # Add your actions here
                        else
                            echo "Python application server is not responding or returned an error (HTTP \$response)."
                            # Add alternative actions or error handling here

                            docker compose -f python.yaml up -d
                        fi

                        vue_url="http://localhost:8080"  # Change the port to match your server

                        # Make an HTTP request to the Vue application

                        # Check the HTTP response status code
                        if [ \$(curl -s -o /dev/null -w "%{http_code}" "\$vue_url") -ne "000" ]; then
                            echo "Vue application server is up and running."
                            # Add your actions here
                        else
                            echo "Vue application server is not responding or returned an error (HTTP \$vue_response)."
                            # Add alternative actions or error handling here

                            docker compose -f vue.yaml up -d
                        fi

                        nginx_url="http://localhost:80/proxy/"  # Change the port to match your server

                        # Make an HTTP request to the Nginx application

                        # Check the HTTP response status code
                        if [ \$(curl -s -o /dev/null -w "%{http_code}" "\$nginx_url") -ne "000" ]; then
                            echo "Nginx application server is up and running."
                            # Add your actions here
                        else
                            echo "Nginx application server is not responding or returned an error (HTTP \$nginx_response)."
                            # Add alternative actions or error handling here

                            docker compose -f nginx.yaml up -d
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
