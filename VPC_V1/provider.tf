terraform {
  required_version = "~>1.8.2"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.30"
    }
  }
}

provider "aws" {
  region = var.aws_region
}