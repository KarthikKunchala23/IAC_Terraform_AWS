# backend.tf or storage.tf

resource "aws_s3_bucket" "tf_state" {
  bucket = "my-terraform-state-bucket-example-for-eks-230798" # Must be globally unique
  versioning {
    enabled = true
  }
    lifecycle {
        prevent_destroy = true
    }
  tags = {
    Name = "Terraform State"
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name           = "terraform-lock-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "Terraform Lock Table"
  }
}
