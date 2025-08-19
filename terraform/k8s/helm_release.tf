# helm_release.tf
resource "helm_release" "karpenter" {
  name       = "karpenter"
  # repository = "oci://public.ecr.aws/karpenter/karpenter"
  chart      = "${path.module}/charts/karpenter"
  # version    = "1.6.1"
  namespace  = "karpenter"

  create_namespace = true

values = [
  yamlencode({
    settings = {
      clusterName           = data.aws_eks_cluster.cluster.name
      clusterEndpoint       = data.aws_eks_cluster.cluster.endpoint
      interruptionQueueName = data.aws_sqs_queue.queue_name.name
    }
    serviceAccount = {
      create      = true
      name        = "karpenter"
      annotations = {
        "eks.amazonaws.com/role-arn" = data.aws_iam_role.karpenter_controller_role.arn
      }
    }
  })
 ]
}
