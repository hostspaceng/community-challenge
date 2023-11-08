### Submission Pull Request Template

**Title:** [Submission] - [Kennedy Uche]

**Description:**

Provide a detailed summary of the changes included in this submission. Explain the problem you aimed to solve, the solutions you implemented, and the results achieved. Include any challenges faced and how they were overcome.  
  
I separated the application into API and Wed components. The source code of the API component is in the `~/components/api` directory while that of the web component is in the `~/components/web` directory. I included the a `kubernetes` directory, where all the kubernetes manifests for the application and monitoring tools are stored. I also included a `terraform` directory for storing the terraform scripts for the IaC part of the project. I also included a `docker-images` directory for storing the Dockerfiles for this project. All these separations were done to make the project to be easily manageable across the various components. The directory tree for the project is given below.  
  
```
│   .gitignore
│   Makefile
│   README.md
│   skaffold.yaml
│
├───.github
│   └───workflows
│           pipeline.yaml        
│
├───components
│   ├───api
│   │   │   pyproject.toml       
│   │   │
│   │   ├───src
│   │   │       main.py
│   │   │       __init__.py
│   │   │
│   │   └───__pycache__
│   │           main.cpython-310.pyc
│   │
│   └───web
│       │   .dockerignore
│       │   babel.config.js
│       │   jsconfig.json
│       │   nginx.conf.template
│       │   package-lock.json
│       │   package.json
│       │   screenshot.png
│       │   vue.config.js
│       │
│       ├───public
│       │       favicon.ico
│       │       index.html
│       │
│       └───src
│           │   App.vue
│           │   main.js
│           │
│           ├───assets
│           │       logo.png
│           │
│           └───components
│                   DomainsTable.vue
│
├───docker-images
│       Dockerfile.api
│       Dockerfile.web
│       
├───kubernetes
│   ├───application
│   │   ├───base
│   │   │       api-deployment.yaml
│   │   │       api-service.yaml
│   │   │       kustomization.yaml
│   │   │       web-configmap.yaml
│   │   │       web-deployment.yaml
│   │   │       web-service.yaml
│   │   │
│   │   └───overlays
│   │       ├───dev
│   │       │       api_deployment_patch.yaml
│   │       │       kustomization.yaml
│   │       │       web_config_patch.yaml
│   │       │       web_deployment_patch.yaml
│   │       │
│   │       ├───prod
│   │       │       api_deployment_patch.yaml
│   │       │       kustomization.yaml
│   │       │       web_config_patch.yaml
│   │       │       web_deployment_patch.yaml
│   │       │
│   │       └───stg
│   │               api_deployment_patch.yaml
│   │               kustomization.yaml
│   │               web_config_patch.yaml
│   │               web_deployment_patch.yaml
│   │
│   └───monitoring
│       │   kustomization.yaml
│       │
│       ├───base
│       │   │   kustomization.yaml
│       │   │
│       │   ├───crds
│       │   │       0alertmanagerConfigCustomResourceDefinition.yaml
│       │   │       0alertmanagerCustomResourceDefinition.yaml
│       │   │       0podmonitorCustomResourceDefinition.yaml
│       │   │       0probeCustomResourceDefinition.yaml
│       │   │       0prometheusagentCustomResourceDefinition.yaml
│       │   │       0prometheusCustomResourceDefinition.yaml
│       │   │       0prometheusruleCustomResourceDefinition.yaml
│       │   │       0scrapeconfigCustomResourceDefinition.yaml
│       │   │       0servicemonitorCustomResourceDefinition.yaml
│       │   │       0thanosrulerCustomResourceDefinition.yaml
│       │   │       kustomization.yaml
│       │   │
│       │   ├───manifests
│       │   │       alertmanager-alertmanager.yaml
│       │   │       alertmanager-networkPolicy.yaml
│       │   │       alertmanager-podDisruptionBudget.yaml
│       │   │       alertmanager-prometheusRule.yaml
│       │   │       alertmanager-secret.yaml
│       │   │       alertmanager-service.yaml
│       │   │       alertmanager-serviceAccount.yaml
│       │   │       alertmanager-serviceMonitor.yaml
│       │   │       app-service-monitor.yaml
│       │   │       grafana-config.yaml
│       │   │       grafana-dashboardDatasources.yaml
│       │   │       grafana-dashboardDefinitions.yaml
│       │   │       grafana-dashboardSources.yaml
│       │   │       grafana-deployment.yaml
│       │   │       grafana-networkPolicy.yaml
│       │   │       grafana-prometheusRule.yaml
│       │   │       grafana-service.yaml
│       │   │       grafana-serviceAccount.yaml
│       │   │       grafana-serviceMonitor.yaml
│       │   │       kubePrometheus-prometheusRule.yaml
│       │   │       kubernetesControlPlane-prometheusRule.yaml
│       │   │       kubernetesControlPlane-serviceMonitorApiserver.yaml
│       │   │       kubernetesControlPlane-serviceMonitorCoreDNS.yaml
│       │   │       kubernetesControlPlane-serviceMonitorKubeControllerManager.yaml
│       │   │       kubernetesControlPlane-serviceMonitorKubelet.yaml
│       │   │       kubernetesControlPlane-serviceMonitorKubeScheduler.yaml
│       │   │       kubeStateMetrics-clusterRole.yaml
│       │   │       kubeStateMetrics-clusterRoleBinding.yaml
│       │   │       kubeStateMetrics-deployment.yaml
│       │   │       kubeStateMetrics-networkPolicy.yaml
│       │   │       kubeStateMetrics-prometheusRule.yaml
│       │   │       kubeStateMetrics-service.yaml
│       │   │       kubeStateMetrics-serviceAccount.yaml
│       │   │       kubeStateMetrics-serviceMonitor.yaml
│       │   │       kustomization.yaml
│       │   │       prometheus-clusterRole.yaml
│       │   │       prometheus-clusterRoleBinding.yaml
│       │   │       prometheus-config.yaml
│       │   │       prometheus-networkPolicy.yaml
│       │   │       prometheus-podDisruptionBudget.yaml
│       │   │       prometheus-prometheus.yaml
│       │   │       prometheus-prometheusRule.yaml
│       │   │       prometheus-roleBindingConfig.yaml
│       │   │       prometheus-roleBindingSpecificNamespaces.yaml
│       │   │       prometheus-roleConfig.yaml
│       │   │       prometheus-roleSpecificNamespaces.yaml
│       │   │       prometheus-service.yaml
│       │   │       prometheus-serviceAccount.yaml
│       │   │       prometheus-serviceMonitor.yaml
│       │   │
│       │   └───operator
│       │           kustomization.yaml
│       │           prometheusAdapter-apiService.yaml
│       │           prometheusAdapter-clusterRole.yaml
│       │           prometheusAdapter-clusterRoleAggregatedMetricsReader.yaml
│       │           prometheusAdapter-clusterRoleBinding.yaml
│       │           prometheusAdapter-clusterRoleBindingDelegator.yaml
│       │           prometheusAdapter-clusterRoleServerResources.yaml
│       │           prometheusAdapter-configMap.yaml
│       │           prometheusAdapter-deployment.yaml
│       │           prometheusAdapter-networkPolicy.yaml
│       │           prometheusAdapter-podDisruptionBudget.yaml
│       │           prometheusAdapter-roleBindingAuthReader.yaml
│       │           prometheusAdapter-service.yaml
│       │           prometheusAdapter-serviceAccount.yaml
│       │           prometheusAdapter-serviceMonitor.yaml
│       │           prometheusOperator-clusterRole.yaml
│       │           prometheusOperator-clusterRoleBinding.yaml
│       │           prometheusOperator-deployment.yaml
│       │           prometheusOperator-networkPolicy.yaml
│       │           prometheusOperator-prometheusRule.yaml
│       │           prometheusOperator-service.yaml
│       │           prometheusOperator-serviceAccount.yaml
│       │           prometheusOperator-serviceMonitor.yaml
│       │
│       └───overlays
│               api-service-monitor-patch.yaml
│               kustomization.yaml
│
├───screenshots
│       grafana-flask-requests.PNG
│       grafana-process-cpu-seconds.PNG
│       grafana-process-start-time.PNG
│       prometheus-monitor.PNG
│
└───terraform
    ├───dev
    │       main.tf
    │       provider.tf
    │       variables.tf
    │       vars.tfvars
    │
    ├───prod
    │       main.tf
    │       provider.tf
    │       variables.tf
    │       vars.tfvars
    │
    └───stg
            main.tf
            provider.tf
            variables.tf
            vars.tfvars
```  
  
In addition to the directory structuring, I included `Makefile` for organizing the project commands, `skaffold` for building the docker images and pushing them to the container registry, `Poetry` for managing the API dependencies.

---

### Solution Details

**Dockerfile & Application Configuration:**
- Briefly describe how the Dockerfile was structured and how the application was configured, including any optimizations or specific configurations used.  
  
I used seperate Dockerfiles for the API and Web components. Both Dockerfiles are multi-staged, to optimize the size.  
  
For the `Dockerfile.api` a build stage is used to package the project dependencies with poetry. The packaged dependencies are copied over to the runtime stage that starts the API server.  
  
For the `Dockerfile.web` a build stage is used to install the project dependencies and build the application. The built artifact is copied over to an Nginx runtime stage which serves the web application.  
  
Both Dockerfiles are built and pushed to the container registry using skaffold.  
  
The `skaffold.yaml` file is given below:  
  
```YAML
apiVersion: skaffold/v3alpha1
kind: Config
metadata:
  name: skaffold-deployment
build:
  artifacts:
  - image: flask-api
    context: components/api
    sync:
      infer:
      - '**/*'
    docker:
      dockerfile: docker-images/Dockerfile.api
  - image: vue-web
    context: components/web
    sync:
      infer:
      - '**/*'
    docker:
      dockerfile: docker-images/Dockerfile.web
  tagPolicy:
    gitCommit: {}
```

**CI/CD Pipeline:**
- Explain the CI/CD pipeline’s flow, including the build, test, and deployment stages. Specify the tools and services used, and the reasons for choosing them.  
  
GitHub Action is used for the CI/CD part. The workflow is designed to serve the dev, stg and prod environments. The sensible parameters are added as secrets.
  
The pipeline has the following jobs:  
1. setup-project-environment: This job sets the target environment (dev, stg, prod) from the active branch. It also extracts the github short SHA to be used for docker image tag in the subsequent job.  
  
2. build-and-push-containers: This job builds and pushes the docker images to the container registry.  
  
3. build-project-infrastructure: This job uses terraform to provison the AWS EKS for the deployment part.  
  
4. deploy-project-applications: This job connects to the provisioned AWS EKS in the active environment and deploys the kubernetes resources to the cluster.  
  
5. cleanup-project-infrastructure: This job is used to tear down the AWS resources.

**Infrastructure as Code (IaC):**
- Provide information on the IaC scripts or tools used for provisioning and deployment. Include details of the deployment platform or cloud service utilized.  
  
Terraform was used as the IaC tool. The AWS EKS resource was provisioned using terraform. The terraform script was separated for the different environments (dev, stg, prod). The scripts are modularized in a separate Github repo and bootsrapped in the project codebase.  
  
The `main.tf` file is given below.
  
```
module "eks_config" {
  source = "github.com/KennedyUC/eks-terraform-module.git"

  vpc_cidr              = var.vpc_cidr
  enable_vpc_dns        = var.enable_vpc_dns
  subnet_count          = var.subnet_count
  subnet_bits           = var.subnet_bits
  project_name          = var.project_name
  env                   = var.env
  k8s_cluster_name      = "${var.project_name}-${var.env}"
  k8s_version           = var.k8s_version
  instance_type         = var.instance_type
  desired_node_count    = var.desired_node_count
  min_node_count        = var.min_node_count
  max_node_count        = var.max_node_count
  node_disk_size        = var.node_disk_size
  ami_type              = var.ami_type
  capacity_type         = var.capacity_type
  cluster_role          = "${var.project_name}-${var.env}-cluster"
  nodes_role            = "${var.project_name}-${var.env}-node"
}
```  
  
The `provider.tf` file for the dev environment is given below.  
  
```
terraform {
  backend "s3" {
    bucket = "app-terraform-state-1470"
    key    = "tf-state/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.user_access_key
  secret_key = var.user_secret_key
}
```  
  
AWS S3 bucket is used as the backend for the tfstate file. This makes it possible to manage the resource using the CI/CD pipeline.


**Monitoring Setup (Bonus):**
- If implemented, describe the monitoring tools and configurations used. Include any custom dashboards or alerts set up to track application and infrastructure health.  
  
Used Prometheus, Grafana and Alert Manager for the monitoring aspect. I used the prometheus operator and added the configuration files, such as Service Monitor, to allow prometheus scrap metrics from the application.  
  
Updated the API script to make it possible for prometheus to scrape metrics from it.  
  
```python
app = Flask(__name__)
metrics = PrometheusMetrics(app)
```

**Screenshots/Links (if applicable):**
- Include screenshots or links showcasing the deployed application, CI/CD pipelines, and monitoring dashboards.

---

### Testing the Solution

Provide clear instructions on how the evaluators can test and verify your solution. Include steps to:

1. Clone your forked repository.
2. Build and run the application using the provided Dockerfile.
3. Deploy the application using the IaC scripts.
4. Access and test the application’s functionality.
5. View and analyze the monitoring dashboards.  
  
To test the application, the following steps shoud be taken:  
1. Install the necessary tools  
  
    Install make:
  
    ```BASH
    sudo apt update && sudo apt install make
    ```  
    
    Install kustomize:  
    
    ```BASH
    make install-kustomize
    ```  
    
    Install docker:  
    
    ```BASH
    make install-docker
    ```  
  
2. Build and run the application locally using docker
  
    ```BASH
    make skaffold-build-local ENV=dev TAG=v1.0.0
    ``` 
    
    ```BASH
    make run_app ENV=dev TAG=v1.0.0
    ```  
      
    You can use any other ENV and TAG values, but it needs to be consistent for both the build and run commands.  
    
3. 

---

### Additional Information

Include any other relevant information like:
- Challenges faced during the challenge and how they were overcome.
- Any improvements or features that could be added in the future.
- Feedback or comments on the challenge and your learning experience.

---

**Checklist:**
- [ ] The submission follows the format specified in the challenge instructions.
- [ ] The Dockerfile builds successfully and is optimized.
- [ ] The CI/CD pipeline is complete and functional.
- [ ] The IaC scripts are modular and reusable.
- [ ] The README file is clear and comprehensive.
- [ ] (Bonus) The monitoring setup is functional and comprehensive.

By submitting this pull request, I confirm that my contribution is made under the terms of the challenge’s requirements.
