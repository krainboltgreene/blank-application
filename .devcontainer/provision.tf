terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "github" {

}

provider "tls" {

}

resource "tls_private_key" "codespaces_key_pair_configuration" {
  algorithm = "ECDSA"
}

resource "local_file" "codespaces_development_private_key_file" {
  content              = tls_private_key.codespaces_key_pair_configuration.private_key_pem
  filename             = pathexpand("~/.ssh/codespaces")
  file_permission      = "600"
  directory_permission = "700"
}

resource "local_file" "codespaces_development_public_key_file" {
  content              = tls_private_key.codespaces_key_pair_configuration.public_key_pem
  filename             = pathexpand("~/.ssh/codespaces.pub")
  file_permission      = "644"
  directory_permission = "700"
}

resource "github_user_ssh_key" "codespaces_development_key" {
  title = "Codespaces Development key"
  key   = tls_private_key.codespaces_key_pair_configuration.public_key_pem
}
