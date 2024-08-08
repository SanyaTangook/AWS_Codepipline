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


module "codebuild" {
  source = "../../modules/CodeBuile"
  codebuile = var.codebuile
  GitLab = var.GitLab
  s3 = var.s3
}

# module "pipeline" {
#   source = "../../modules/Pipe"
#   S3 = "codepipeline-ap-southeast-1-537388811766"
#   Name-pipeline = "Test"
#   Repository = {
#     RepositoryName = "360truck/tst.cdp"
#     BranchName = "feature/add_poc_staging"
#   }
#   CodeBuild = "Test"
#   Deploy = {
#     Cluster = "ECS-SG-nonProd-Back-End"
#     Service = "sg-tst_cdp"
#   }
#   GitLab = "GitLab-360Truck"
# }

