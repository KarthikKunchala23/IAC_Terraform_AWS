terraform {
  required_version = "~>1.8.2"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.30"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }   
  }
}

provider "aws" {
  region = var.aws_region
}

# Create Random Pet Resource
resource "random_pet" "this" {
  length = 2
}