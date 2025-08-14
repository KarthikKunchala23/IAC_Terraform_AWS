provider "aws" {
  region = "us-east-1"  # Adjust the region as needed
}

provider "kubernetes" {
  config_path = "~/.kube/config"  # Adjust the path to your kubeconfig file
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  
}
