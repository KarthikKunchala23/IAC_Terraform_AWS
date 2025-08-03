# Helm release to install Karpenter
resource "helm_release" "karpenter" {
  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  version    = "v0.16.3"
  namespace  = "karpenter"
  create_namespace = true

  values = [yamlencode({
    settings = {
      clusterName           = var.cluster_name
      clusterEndpoint       = data.aws_eks_cluster.cluster.endpoint
      interruptionQueueName = aws_sqs_queue.karpenter.name
    }
    serviceAccount = {
      create = true
      name   = "karpenter"
      annotations = {
        "eks.amazonaws.com/role-arn" = aws_iam_role.karpenter_controller.arn
      }
    }
  })]
}