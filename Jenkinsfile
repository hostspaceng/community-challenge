pipeline {
    agent any  // You can specify the Jenkins agent here (e.g., 'docker', 'node', etc.)

    stages {
        stage('Checkout') {
            steps {
                // This step checks out your source code from a version control system (e.g., Git).
                // You can specify your VCS and credentials here.
                script{
                    sh """
                        echo "hello world!"
                    """
                }
            }
        }
        
        stage('Build') {
            steps {
                // Add build commands here (e.g., compiling code, running tests, etc.).
                 script{
                    sh """
                        echo "hello world!"
                    """
                }
            }
        }
        
        stage('Test') {
            steps {
                // Add testing commands here.
                 script{
                    sh """
                        echo "hello world!"
                    """
                }
            }
        }
        
        stage('Deploy') {
            steps {
                // Add deployment commands here (e.g., deploying to a server or cloud service).
                 script{
                    sh """
                        echo "hello world!"
                    """
                }
            }
        }
    }

    // post {
    //     success {
    //         // Actions to take when the pipeline is successful.
    //     }
    //     failure {
    //         // Actions to take when the pipeline fails.
    //     }
    //     always {
    //         // Actions to take regardless of the pipeline result.
    //     }
    // }
}
