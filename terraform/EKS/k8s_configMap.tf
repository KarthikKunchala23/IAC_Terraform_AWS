resource "kubernetes_manifest" "aws_auth" {
  manifest = {
    apiVersion = "v1"
    kind       = "ConfigMap"
    metadata = {
      name      = "aws-auth"
      namespace = "kube-system"
    }
    data = {
      mapRoles = yamlencode([
        {
          rolearn  = aws_iam_role.eks_node_group.arn
          username = "system:node:{{EC2PrivateDNSName}}"
          groups   = ["system:bootstrappers", "system:nodes"]
        },
        {
          rolearn  = aws_iam_role.eks_admin_role.arn
          username = "eks-admin"
          groups   = ["system:masters"]
        }
      ])
    }
  }

  lifecycle {
    ignore_changes = [manifest]
  }

  depends_on = [
    aws_eks_cluster.eks,
    aws_iam_role.eks_node_group,
    aws_iam_role.eks_admin_role
  ]
}
