@Library('shared-library') _
pipeline{
    agent any
    environment{
        DOCKERHUB_CREDENTIAL = credentials("DOCKER_ID")
    }
    stages{
        stage("Test Stage"){
            steps{
                sh "echo 'This is test stage'"
            }
        }
        stage("Login to Dockerhub"){
            steps{
                sh 'echo $DOCKERHUB_CREDENTIAL_PSW | docker login -u $DOCKERHUB_CREDENTIAL_USR --password-stdin'
            }
        }
        stage("Build and Push Frontend Application Image"){
            // Build and Push only when in the "main" branch
            when {
                expression {
                    return "$GIT_BRANCH == main"; 
                 }
            }
            steps{
                dir('./frontend'){
                   buildPushImage("frontend")
                }
            }

        }
        stage("Build and Push Backend Application Image"){
            // Build and Push only when in the "main" branch
            when {
                expression {
                    return "$GIT_BRANCH == main"; 
                 }
            }
            steps{
                dir('./backend'){
                    buildPushImage("backend")
                }
            }

        }
        stage("Image Build Stage"){
            steps{
                sh "echo 'This is image build stage'"
            }
        }

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