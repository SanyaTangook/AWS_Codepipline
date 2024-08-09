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
  region     = var.provider_aws.region
  access_key = var.provider_aws.access_key
  secret_key = var.provider_aws.secret_key
}

module "TestPip" {
  source = "../../modules/Pipe"
  pipeline = var.pipeline
  S3     = var.S3
  GitLab = var.GitLab
}