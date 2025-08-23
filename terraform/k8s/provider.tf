terraform {
  required_version = ">= 1.9.6"
  backend "s3" {
    bucket         = "my-terraform-state-bucket-example-for-k8s-230798"
    key            = "k8s/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}




provider "kubernetes-alpha" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = ephemeral.aws_eks_cluster_auth.cluster_auth.token
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = ephemeral.aws_eks_cluster_auth.cluster_auth.token
}


provider "aws" {
  region = "us-east-1"  # Adjust the region as needed
  
}

provider "aws" {
  alias  = "public"
  region = "us-east-1"  # Adjust the region as needed
  
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = ephemeral.aws_eks_cluster_auth.cluster_auth.token
  }
}

ephemeral "aws_eks_cluster_auth" "cluster_auth" {
  name = data.aws_eks_cluster.cluster.name
}