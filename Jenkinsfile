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
        //     steps{
        //         dir('./backend'){
        //             script{
        //                 // setting test values for environment variables needed by the flask app
        //                 env.ZONE_ID = '88212a53b6feba598b197f3508f35b52'
        //                 env.CF_API_KEY = 'ab590d1c5d3139416fef3d173ad4267a75a41'
        //                 env.CF_API_EMAIL= 'safe@hostspaceng.com'

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
        //               // The buildPushImage is defined in the shared-library folder. 
        //               // The argument it allows is a string that is appended to the tag of the image.
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
                            try{
                                // This function has been defined in the shared-library/var folder.
                                // The function takes in either the 'create' or 'apply' kubernetes command
                                // to append to the command for creating resources. 
                                deployApplication("create")
                            }
                            catch(error){
                                deployApplication("apply")
                            }
                        }
                    }

                }   
            }
        }
    }
}