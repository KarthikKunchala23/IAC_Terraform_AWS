terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-example-for-k8s-230798"
    key            = "karpenter1/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = ephemeral.aws_eks_cluster_auth.cluster_auth.token
}


provider "kubernetes-alpha" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = ephemeral.aws_eks_cluster_auth.cluster_auth.token
}



provider "aws" {
  region = "us-east-1"  # Adjust the region as needed
  
}

ephemeral "aws_eks_cluster_auth" "cluster_auth" {
  name = data.aws_eks_cluster.cluster.name
}