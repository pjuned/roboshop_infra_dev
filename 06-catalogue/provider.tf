terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.14.1"
    }
  }

  
  backend "s3" {
    bucket = "76s-dev-state"
    key    = "catalogue"
    region = "us-east-1"
    dynamodb_table = "76s-dev-lock"
  }


}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}