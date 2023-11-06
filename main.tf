provider "google" {
  project     = "hostspace-challenge"
  region      = "us-central1"
  credentials = file("/cred.json")
}


resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-central1"
  repository_id = "repo1"
  description   = "example docker repository for challenge"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
  
}
resource "google_cloud_run_service" "hostspace-challenge" {
  name     = "tback"
  location = "us-central1"
 

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

}

resource "google_cloud_run_service" "test" {
  name     = "test2"
  location = "us-central1"
 

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  } 
}

