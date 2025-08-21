data "aws_eks_cluster" "cluster" {
    name = "demo-eks-cluster"
}

data "aws_iam_role" "node_group_role" {
  name = "eks-node-group-role"
}

data "aws_iam_role" "eks_admin_role" {
  name = "eks-admin-role"
}

data "aws_sqs_queue" "queue_name" {
    name = "demo-eks-cluster-karpenter-interruption"
}

data "aws_iam_role" "karpenter_controller_role" {
  name = "karpenter-controller-role-demo-eks-cluster"
}

data "aws_iam_role" "karpenter_node_role" {
  name = "KarpenterNodeRole-demo-eks-cluster"
  
}