terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.14.0"
    }

    git = {
      source = "innovationnorway/git"
      version = "0.1.3"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "git" {}

# https://cloud.google.com/free/docs/gcp-free-tier#free-tier-usage-limits
# gcloud auth application-default login ???
provider "google" {
  project = "poutineer"
  region  = "us-west1"
  zone    = "us-west1-a"
}
