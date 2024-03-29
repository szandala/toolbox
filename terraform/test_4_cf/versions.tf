terraform {
  required_version = ">=0.14"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "> 4.0.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "> 4.0.0"
    }

    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4.1"
    }
  }
}
