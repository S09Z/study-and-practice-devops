# Specify the Terraform version and GCP provider
terraform {
  required_version = ">= 0.12"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.5"
    }
  }
}

# Configure the Google Cloud provider
provider "google" {
  credentials = file("my-credential.json")
  project     = ""   # Replace with your GCP project ID
  region      = ""       # Replace with your desired region
}

# Define a resource for a Google Cloud Storage bucket
resource "google_storage_bucket" "my_bucket" {
  name          = "my-terraform-bucket" # Replace with a unique bucket name
  location      = "US"
  force_destroy = true  # Allows the bucket to be destroyed even if it contains objects

  # Bucket versioning configuration (optional)
  versioning {
    enabled = true
  }

  # Bucket lifecycle rules (optional)
  lifecycle_rule {
    condition {
      age = "30"  # Automatically delete objects older than 30 days
    }
    action {
      type = "Delete"
    }
  }
}

# Output the bucket's URL
output "bucket_url" {
  value = "gs://${google_storage_bucket.my_bucket.name}"
}
