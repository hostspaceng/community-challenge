def call(String applicationImage){
    // Build the Docker Image
    sh "docker build -t achebeh/community-challenge-${applicationImage}:${BUILD_NUMBER}  ."

    // Tag the built image as "latest"
    sh "docker tag achebeh/community-challenge-${applicationImage}:${BUILD_NUMBER} achebeh/community-challenge-${applicationImage}:latest"

    // Push built image to docker public achebeh repo
    sh "docker image push achebeh/community-challenge-${applicationImage}:${BUILD_NUMBER}"
    sh "docker image push achebeh/community-challenge-${applicationImage}:latest"
}