pipeline{
    agent any

    stages{
        stage("Test Stage"){
            steps{
                sh "echo 'This is test stage'"
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