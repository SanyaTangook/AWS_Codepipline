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
  region = var.provider_aws.region
  access_key = var.provider_aws.access_key
  secret_key = var.provider_aws.secret_key
}

module "role" {
  source = "../../modules/Policies"
  role = var.name_role
  policy = var.policy_name
}