output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "node_group_role_arn" {
  value = aws_iam_role.eks_node_group.arn
}
