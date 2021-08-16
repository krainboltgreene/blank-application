# data "google_project" "project" {
#   provider = google-beta
# }

resource "google_container_registry" "container_registry" {
  location = "US"
}

resource "docker_registry_image" "resource_api" {
  name = "resource_api:${substr(data.git_repository.current_repository.commit_sha, 0, 7)}"

  build {
    context  = "."
    # tag  = ["resource_api:latest"]
    # build_arg = {
    #   foo : "zoo"
    # }
    # label = {
    #   author : "zoo"
    # }
    auth_config {
      host_name = google_container_registry.container_registry.bucket_self_link
    }
  }
}

# resource "google_sql_database_instance" "example_cloud_sql_database_instance" {
#   name             = "example_cloud_sql_database_instance"
#   database_version = "POSTGRES_13"

#   settings {
#     tier = "db-f1-micro"

#     database_flags {
#       name  = "cloudsql.iam_authentication"
#       value = "on"
#     }
#   }

#   # deletion_protection  = "true"
# }

# resource "google_sql_database" "example_cloud_sql_database" {
#   name     = "example_cloud_sql_database"
#   instance = google_sql_database_instance.example_cloud_sql_database_instance.name
# }

# resource "google_sql_user" "users" {
#   name     = "krainboltgreene"
#   instance = google_sql_database_instance.example_cloud_sql_database_instance.name
#   type     = "CLOUD_IAM_USER"
# }

# resource "google_storage_bucket" "example_storage_bucket" {
#   name          = "poutineer.club"
#   location      = "US"
#   force_destroy = true

#   uniform_bucket_level_access = true

#   website {
#     main_page_suffix = "index.html"
#     not_found_page   = "404.html"
#   }

#   cors {
#     origin          = ["http://www.poutineer.club"]
#     method          = ["GET", "HEAD"]
#     response_header = ["*"]
#     max_age_seconds = 3600
#   }
# }

# resource "google_secret_manager_secret" "secret" {
#   provider = google-beta
#
#   secret_id = "secret"
#   replication {
#     automatic = true
#   }
# }

# resource "google_secret_manager_secret_iam_member" "secret-access" {
#   provider = google-beta
#
#   secret_id = google_secret_manager_secret.secret.id
#   role      = "roles/secretmanager.secretAccessor"
#   member    = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
#   depends_on = [google_secret_manager_secret.secret]
# }

# resource "google_cloud_run_service" "example_run_service" {
#   name                       = "example_run_service"
#   autogenerate_revision_name = true
#   location                   = "us-west1"

#   template {
#     spec {
#       containers {
#         # TODO: Change to real docker url
#         image = "us-docker.pkg.dev/cloudrun/container/hello"
#         # env {
#         #   name = "SOURCE"
#         #   value = "remote"
#         # }
#         # env {
#         #   name = "TARGET"
#         #   value = "home"
#         # }
#         # env {
#         #   name = "SECRET_ENV_VAR"
#         #   value_from {
#         #     secret_key_ref {
#         #       name = google_secret_manager_secret.secret.secret_id
#         #       key  = "1"
#         #     }
#         #   }
#         # }
#       }
#     }
#   }

#   metadata {
#     # namespace = "poutineer-name"
#     annotations = {
#       "autoscaling.knative.dev/maxScale" = "100"
#       # "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.example_cloud_sql_database_instance.connection_name
#       "run.googleapis.com/client-name" = "terraform"
#       # "run.googleapis.com/launch-stage" = "BETA"
#     }
#   }

#   traffic {
#     percent         = 100
#     latest_revision = true
#   }

#   # NOTE: Splitting traffic
#   # traffic {
#   #   percent       = 25
#   #   revision_name = "cloudrun-srv-green"
#   # }

#   # traffic {
#   #   percent = 75
#   #   # This revision needs to already exist
#   #   revision_name = "cloudrun-srv-blue"
#   # }
#   # depends_on = [google_secret_manager_secret_version.secret-version-data]
# }

# resource "google_cloud_run_domain_mapping" "example_domain_mapping" {
#   # location = "us-central1"
#   name = "poutineer.club"

#   metadata {
#     # namespace = "poutineer-name"
#   }

#   spec {
#     route_name = google_cloud_run_service.example_run_service.name
#   }
# }
