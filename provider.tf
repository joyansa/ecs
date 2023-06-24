terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
  # backend "s3" {
  #   bucket  = "gcs-ecs-terraform-remote-state-s3"
  #   key     = "vpc.tfstate"
  #   region  = "us-east-1"
  #   encrypt = "true"
  # }
}

provider "aws" {
  profile = "ecs_user"
  region  = "us-east-1"
}

