resource "kubernetes_manifest" "karpenter_nodeclass" {
  manifest = {
    apiVersion = "karpenter.k8s.aws/v1"
    kind       = "EC2NodeClass"
    metadata = {
      name = "default"
    }
    spec = {
      amiFamily = "AL2"

      # REQUIRED: must provide amiSelectorTerms
      amiSelectorTerms = [{
        # Use AWS-provided EKS optimized AMIs
        tags = {
          "aws::eks::optimized" = "true"
        }
      }]

      subnetSelectorTerms = [{
        tags = {
          format("kubernetes.io/discovery/%s", data.aws_eks_cluster.cluster.name) = "owned"
        }
      }]

      securityGroupSelectorTerms = [{
        tags = {
          format("kubernetes.io/cluster/%s", data.aws_eks_cluster.cluster.name) = "owned"
        }
      }]

      instanceProfile = "KarpenterNodeInstanceProfile-${data.aws_eks_cluster.cluster.name}"
    }
  }
}
