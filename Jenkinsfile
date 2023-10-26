// This pipeline uses share library to reduce the amount of repetitive codes.
@Library('shared-library') _
pipeline{
    agent any
    environment{
        DOCKERHUB_CREDENTIAL = credentials("DOCKER_ID")
    }
    stages{
        // stage("Test Stage: Testing Vue application before image build."){
        //     agent {
        //         docker {
        //             image 'node:lts-alpine'
        //             args '-u root:root'
        //         }
        //     }
        //     steps{
        //         dir('./frontend'){
        //             script{
        //                 // Install dependencies
        //                 sh 'npm install --legacy-peer-deps'

        //                 // Run Vue.js tests
        //                 sh 'npm run test:unit'
        //             }
        //         }
        //     }
        // }
        // stage("Test Stage: Testing Flask application before image build."){
        //     agent {
        //         docker {
        //             image 'python'
        //             args '-u root:root'
        //         }
        //     }
        //     steps{
        //         dir('./backend'){
        //             script{
        //                 // Install dependencies
        //                 sh 'pip install -r requirements.txt'

        //                 // Run Vue.js tests
        //                 sh 'python3 test_main.py'
        //             }
        //         }
        //     }
        // }
        // stage("Login to Dockerhub"){
        //     steps{
        //         sh 'echo $DOCKERHUB_CREDENTIAL_PSW | docker login -u $DOCKERHUB_CREDENTIAL_USR --password-stdin'
        //     }
        // }
        // stage("Build and Push Frontend Application Image"){
        //     // Build and Push only when in the "main" branch
        //     when {
        //         expression {
        //             return "$GIT_BRANCH == main"; 
        //          }
        //     }
        //     steps{
        //         dir('./frontend'){
                      // The buildPushImage is defined in the shared-library folder. The argument it allows is a string that is appended to the tag of the image.
        //            buildPushImage("frontend")
        //         }
        //     }

        // }
        // stage("Build and Push Backend Application Image"){
        //     // Build and Push only when in the "main" branch
        //     when {
        //         expression {
        //             return "$GIT_BRANCH == main"; 
        //          }
        //     }
        //     steps{
        //         dir('./backend'){
        //             buildPushImage("backend")
        //         }
        //     }

        // }
        stage("Image Deploy Application to EKS Cluster"){
            steps{
                dir("./kube_files"){
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: "AWS_ID",
                        accessKeyVariable: "AWS_ACCESS_KEY_ID",
                        secretKeyVariable: "AWS_SECRET_ACCESS_KEY"
                    ]]){
                        script{
                  
                            // Update kube-config file with the name of created cluster.
                            sh 'aws eks update-kubeconfig --name eks-cluster-eksCluster-b446572 --region "us-east-1"'
                            // Creating the namespace resource
                            sh 'kubectl create -f namespace.yaml'

                            // // Creating the secret resource
                            // sh 'kubectl create -f secrets.yaml'

                            // // Creating the backend-service resource
                            sh 'kubectl create -f backend-service.yaml'

                            // // Running the custom script to pass the created backend-service url to the configmap file.
                            sh 'sh script.sh'

                        //     // // Creating the configmap resource
                        //     sh 'kubectl create -f configmap.yaml'

                        //     // // Creating the backend-deployment resource
                        //     sh 'kubectl create -f backend-deployment.yaml'

                        //     // // Creating the frontend-deployment resource
                        //     sh 'kubectl create -f frontend-deployment.yaml'

                        //     // Creating the frontend-service resource
                        //     sh 'kubectl create -f frontend-service.yaml'
                        }
                    }

                }   
            }
        }

        stage("Application Deploy Stage"){
            steps{
                sh "echo 'This is application stage'"
            }
        }
    }
}