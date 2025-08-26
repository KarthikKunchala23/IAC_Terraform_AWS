resource "kubernetes_config_map_v1_data" "aws_auth_patch" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = data.aws_iam_role.karpenter_controller_role.arn
        username = "karpenter"
        groups   = ["system:masters"]
      },
      {
        rolearn  = data.aws_iam_role.node_group_role.arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
        }
    ])
  }

  force = true
}
