pipeline {
    agent any

    environment {
        def buildNumber = env.BUILD_NUMBER.toInteger()
        def version = "1.0.${buildNumber}"
        echo "Setting application version to: ${version}"
        // Set the version as an environment variable for your application
        env.APP_VERSION = version
    }

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

                        docker build -t vue-app .

                        cd backend
                        docker build -t python .

                        cd ..

                        docker run -d -p 8080:80 --name vue-app vue-app

                        docker run -d -p 5000:5000 --name python-proxy

                    """
                }
            }
        }

        stage('Deploy to Amazon ECR...') {
            steps {
                script {


                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS']]) {
                    sh """
                            aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/l1z2o5a3
                    """
                }

                    sh """

                            docker tag python-proxy public.ecr.aws/l1z2o5a3/python-proxy:$version
                            docker push public.ecr.aws/l1z2o5a3/python-proxy:latest:$version


                            docker tag python-proxy public.ecr.aws/l1z2o5a3/python-proxy:$version
                            docker push public.ecr.aws/l1z2o5a3/vue-app:latest:$version

                    """
                }
            }
        }

        stage('Testing frontend application locally') {
            steps {
                script {
                    sh """

                        # Make API requests using cURL
                        curl -X GET http://localhost:8080


                        # Check the HTTP status code (response code)
                        if [ $? -eq 0 ]; then
                            # If the exit status is 0, the cURL request was successful, and the HTTP status code is accessible in the response headers.
                            HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8080")

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

        
        stage('Testing python-proxy application locally') {
            steps {
                script {
                    sh """

                        # Make API requests using cURL
                        curl -X GET http://localhost:5000


                        # Check the HTTP status code (response code)
                        if [ $? -eq 0 ]; then
                            # If the exit status is 0, the cURL request was successful, and the HTTP status code is accessible in the response headers.
                            HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:5000")

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
    }

    

        

    post {
        success {
            script {

                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS']]) {
                    sh """
                            aws eks update-kubeconfig --name my-eks-cluster --region us-east-1

                            helm upgrade --install ingress-nginx ingress-nginx   --repo https://kubernetes.github.io/ingress-nginx

                    """
                }

                    sh """

                            export version=$version

                            kubectl apply -f /k8s/eks_deployments.yaml

                            kubectl apply -f ingress-service.yaml

                    """

                    sh """

                        # Make API requests using cURL
                        curl -X GET http://aacf724f1ada5446cb70e439e677aa09-761205241.us-east-1.elb.amazonaws.com/


                        # Check the HTTP status code (response code)
                        if [ $? -eq 0 ]; then
                            # If the exit status is 0, the cURL request was successful, and the HTTP status code is accessible in the response headers.
                            HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://aacf724f1ada5446cb70e439e677aa09-761205241.us-east-1.elb.amazonaws.com/")

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

                    sh """

                        # Make API requests using cURL
                        curl -X GET http://aacf724f1ada5446cb70e439e677aa09-761205241.us-east-1.elb.amazonaws.com/proxy/


                        # Check the HTTP status code (response code)
                        if [ $? -eq 0 ]; then
                            # If the exit status is 0, the cURL request was successful, and the HTTP status code is accessible in the response headers.
                            HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://aacf724f1ada5446cb70e439e677aa09-761205241.us-east-1.elb.amazonaws.com/")

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
