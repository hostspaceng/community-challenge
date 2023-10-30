def call(String command){
    // Update kube-config file with the name of created cluster.
    sh 'aws eks update-kubeconfig --name eks-cluster-eksCluster-7c22835 --region "us-east-1"'

    // Creating the namespace resource
    sh "kubectl ${command} -f namespace.yaml"

    // Creating the secret resource
    sh "kubectl ${command} -f secrets.yaml"

    // // Creating the backend-service resource
    sh "kubectl ${command} -f backend-service.yaml"

    // // Running the custom script to pass the created backend-service url to the configmap file.
    sh 'sh script.sh'

    // // Creating the configmap resource
    sh "kubectl ${command} -f configmap.yaml"

    // // Creating the backend-deployment resource
    sh "kubectl ${command} -f backend-deployment.yaml"

    // // Creating the frontend-deployment resource
    sh "kubectl ${command} -f frontend-deployment.yaml"

    // Creating the frontend-service resource
    sh "kubectl ${command} -f frontend-service.yaml"
}