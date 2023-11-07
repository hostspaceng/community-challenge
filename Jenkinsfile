pipeline {
    agent any

    environment {
        // Define global environment variables
        ZONE_ID = credentials('ZONE_ID')
        CF_API_KEY = credentials('CF_API_KEY')
        CF_API_EMAIL = credentials('CF_API_EMAIL')

        // Define this environmental variable to version to my application's docker image
        def buildNumber = env.BUILD_NUMBER.toInteger()
        def version = '1.0.${buildNumber}'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    
                        git branch: 'main', url: 'https://github.com/abdulfrfr/community-challenge.git'
                    
                }
            }
        }

        stage('Build and run Docker Images locally') {
            steps {
                script {
                // here i will build my docker images and run them locally for testing...
                sh """

                        export backend_endpoint=http://localhost:5000

                        docker build --build-arg  backend_endpoint=http://localhost:5000 -t vue-app .

                        cd backend
                        docker build -t python .

                        cd ..

                        docker compose -f docker-compose.yaml up 

                    """
                }
            }
        }

        stage('Testing frontend application locally') {
            steps {
                script {

                    //here i will test and send requests to my running fontend docker container of my 
                    //applciation to test if they are configured properly and if they are up and running
                    sh """
                        curl -X GET http://localhost:8080

                        if [ \$? -eq 0 ]; then
                            HTTP_STATUS=\$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8080")

                            if [ "\$HTTP_STATUS" -eq 200 ]; then
                                echo 'HTTP Status Code: \$HTTP_STATUS (OK)'
                            else
                                echo 'HTTP Status Code: \$HTTP_STATUS (Not OK)'
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

                    //here i will test and send requests to my running backend docker container of my 
                    //applciation to test if they are configured properly and if they are up and running
                    sh """

                        # Make API requests using cURL
                        curl -X GET http://localhost:5000


                        # Check the HTTP status code (response code)
                        if [ \$? -eq 0 ]; then
                            # If the exit status is 0, the cURL request was successful, and the HTTP status code is accessible in the response headers.
                            HTTP_STATUS=\$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:5000")

                            if [ "\$HTTP_STATUS" -eq 200 ]; then
                                echo 'HTTP Status Code: \$HTTP_STATUS (OK)'
                            else
                                echo 'HTTP Status Code: \$HTTP_STATUS (Not OK)'
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

        stage('Build Docker Images for deployment') {
            steps {
                script {
                // here i will build my docker images and run them locally for testing...
                sh """

                        docker build --build-arg backend_endpoint=http://aacf724f1ada5446cb70e439e677aa09-761205241.us-east-1.elb.amazonaws.com/proxy/ -t vue-app .

                        cd backend
                        docker build -t python .

                        cd ..

                    """
                }
            }
        }

        stage('Deploy to Amazon ECR...') {
            steps {
                script {

                    //after building my docker images, i will then tag and push them to my Amazon ECR repro
                    //with the help of my aws credententials


                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS']]) {
                    sh """
                            aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/l1z2o5a3
                    """
                }

                    sh """

                            docker tag python public.ecr.aws/l1z2o5a3/python-proxy:v1.0.2
                            docker push public.ecr.aws/l1z2o5a3/python-proxy:v1.0.2


                            docker tag vue-app public.ecr.aws/l1z2o5a3/vue-app:v1.0.2
                            docker push public.ecr.aws/l1z2o5a3/vue-app:v1.0.2

                    """
                }
            }
        }


    }

    post {
        success {
            script {

                //using my aws credentials...
                //if this stage is a success i want to then deploy my docker images passing my version variable into
                //my k8s deployment configuration .yaml file and applying these configuration files to my Amazon EKS cluster which i have already
                //to deploy my application
                //configured and running..., also installing nginx-ingress controller to my eks cluster
                //and also send request to the ingress contoler's load balancers endpoint

                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS']]) {
                    sh """
                            aws eks update-kubeconfig --name my-eks-cluster --region us-east-1

                            helm upgrade --install ingress-nginx ingress-nginx   --repo https://kubernetes.github.io/ingress-nginx

                    """
                }

                    sh """

                            kubectl apply -f /k8s/eks_deployments.yaml

                            kubectl apply -f /k8s/ingress-service.yaml

                    """

                    sh """

                        # Make API requests using cURL
                        curl -X GET http://aacf724f1ada5446cb70e439e677aa09-761205241.us-east-1.elb.amazonaws.com/


                        # Check the HTTP status code (response code)
                        if [ \$? -eq 0 ]; then
                            # If the exit status is 0, the cURL request was successful, and the HTTP status code is accessible in the response headers.
                            HTTP_STATUS=\$(curl -s -o /dev/null -w "%{http_code}" "http://aacf724f1ada5446cb70e439e677aa09-761205241.us-east-1.elb.amazonaws.com/")

                            if [ "\$HTTP_STATUS" -eq 200 ]; then
                                echo 'HTTP Status Code: \$HTTP_STATUS (OK)'
                            else
                                echo 'HTTP Status Code: \$HTTP_STATUS (Not OK)'
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
                        if [ \$? -eq 0 ]; then
                            # If the exit status is 0, the cURL request was successful, and the HTTP status code is accessible in the response headers.
                            HTTP_STATUS=\$(curl -s -o /dev/null -w "%{http_code}" "http://aacf724f1ada5446cb70e439e677aa09-761205241.us-east-1.elb.amazonaws.com/")

                            if [ "\$HTTP_STATUS" -eq 200 ]; then
                                echo 'HTTP Status Code: \$HTTP_STATUS (OK)'
                            else
                                echo 'HTTP Status Code: \$HTTP_STATUS (Not OK)'
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
        failure {
            // Actions to take when the pipeline fails.

            sh "echo 'Pipeline Failed"
        }
        always {
            // Actions to take regardless of the pipeline result.
            def buildNumber = env.BUILD_NUMBER.toInteger()
            echo "This is pipeline run number: ${buildNumber}"
        }

