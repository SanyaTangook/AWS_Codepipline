terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.56.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.provider.region
  access_key = var.provider.access_key
  secret_key = var.provider.secret_key
}
