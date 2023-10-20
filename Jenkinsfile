@Library('shared-library') _
pipeline{
    agent any
    environment{
        DOCKERHUB_CREDENTIAL = credentials("DOCKER_ID")
    }
    stages{
        stage("Test Stage: Testing Vue Application"){
            agent {
                docker {
                    image 'node:lts-alpine'
                    args '-u root:root'
                }
            }
            steps{
                dir('./frontend'){
                    script{
                        // Install dependencies
                        sh 'npm install --legacy-peer-deps'

                        // Run Vue.js tests
                        sh 'npm run test:unit'
                    }
                }
            }
        }
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
        stage("Image Deploy Stage"){
            steps{
                sh "echo 'This is image deploy stage'"
            }
        }

        stage("Application Deploy Stage"){
            steps{
                sh "echo 'This is application stage'"
            }
        }
    }
}