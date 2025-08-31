terraform {
  required_version = "=1.12.2"
  backend "s3" {
    bucket         = "my-terraform-state-bucket-example-for-eks-230798"
    key            = "eks-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
