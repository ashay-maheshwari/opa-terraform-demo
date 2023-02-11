terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.50.0"
    }
  }
}

provider "aws" {
  # Configuration options
  shared_credentials_files = ["~/.aws/credentials"]
  region = "us-east-1"
}

