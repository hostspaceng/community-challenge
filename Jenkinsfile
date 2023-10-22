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

                        nginx_url="http://localhost:80"  # Change the port to match your server

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
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws']]) {
                    sh """
                            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 206080409328.dkr.ecr.us-east-1.amazonaws.com
                            docker tag nginx-http-proxy 206080409328.dkr.ecr.us-east-1.amazonaws.com/nginx-http-proxy:latest
                            docker push 206080409328.dkr.ecr.us-east-1.amazonaws.com/nginx-http-proxy:latest


                            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 206080409328.dkr.ecr.us-east-1.amazonaws.com
                            docker tag python-project 206080409328.dkr.ecr.us-east-1.amazonaws.com/python-project:latest
                            docker push 206080409328.dkr.ecr.us-east-1.amazonaws.com/python-project:latest


                            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 206080409328.dkr.ecr.us-east-1.amazonaws.com
                            docker tag vue-project 206080409328.dkr.ecr.us-east-1.amazonaws.com/vue-project:latest
                            docker push 206080409328.dkr.ecr.us-east-1.amazonaws.com/vue-project:latest

                    """
                }
            }
        }
    }

    // post {
    //     success {
            
    //              sh "echo 'hello world'"
                
    //         }
        
    //     failure {
    //         // Actions to take when the pipeline fails.

    //         sh "echo 'hello world'"
    //     }
    //     always {
    //         // Actions to take regardless of the pipeline result.
    //         sh "echo 'hello world'"
    //     }
    // }
}
