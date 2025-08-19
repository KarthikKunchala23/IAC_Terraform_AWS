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
          rolearn  = data.aws_iam_role.node_group_role.arn
          username = "system:node:{{EC2PrivateDNSName}}"
          groups   = ["system:bootstrappers", "system:nodes"]
        },
        {
          rolearn  = data.aws_iam_role.eks_admin_role.arn
          username = "eks-admin"
          groups   = ["system:masters"]
        }
      ])
    }
  }

  lifecycle {
    ignore_changes = [manifest]
  }
  depends_on = [ helm_release.karpenter ]

}
