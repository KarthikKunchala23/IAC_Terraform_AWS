provider "kubernetes" {
  host                   = aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = aws_eks_cluster_auth.eks.token
  
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
    data = {
        "mapRoles" = jsonencode([
        {
            rolearn  = aws_iam_role.node.arn
            username = "system:node:{{EC2PrivateDNSName}}"
            groups   = ["system:bootstrappers", "system:nodes"]
        },
        {
            rolearn  = aws_iam_role.cluster.arn
            username = "system:masters"
            groups   = ["system:masters"]
        }
        ])

        mapUsers = yamlencode([
        {
            userarn  = "arn:aws:iam::897722700244:user/karthik" 
            username = "karthik"
            groups   = ["system:masters"]
    }
        ])
    }
    depends_on = [
        aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryPullOnly,
        aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
        aws_eks_cluster.cluster

    ]
}
