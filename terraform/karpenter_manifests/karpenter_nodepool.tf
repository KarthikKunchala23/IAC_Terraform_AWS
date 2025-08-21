resource "kubernetes_manifest" "karpenter_nodepool" {
  manifest = {
    apiVersion = "karpenter.sh/v1"
    kind       = "NodePool"
    metadata = {
      name = "default"
    }
    spec = {
      template = {
        spec = {
          nodeClassRef = {
            group = "karpenter.k8s.aws"
            kind  = "EC2NodeClass"
            name  = kubernetes_manifest.karpenter_nodeclass.manifest["metadata"]["name"]
          }
          requirements = [
            {
              key      = "kubernetes.io/arch"
              operator = "In"
              values   = ["amd64", "arm64"]
            },
            {
              key      = "karpenter.sh/capacity-type"
              operator = "In"
              values   = ["on-demand", "spot"]
            },
            {
              key      = "topology.kubernetes.io/zone"
              operator = "In"
              values   = ["us-east-1a", "us-east-1b", "us-east-1c"] # <-- adjust to your cluster AZs
            }
          ]
        }
      }
      disruption = {
        consolidationPolicy = "WhenEmptyOrUnderutilized"
        consolidateAfter    = "30s"
      }
      limits = {
        cpu    = "1000"
        memory = "1000Gi"
      }
    }
  }

  depends_on = [kubernetes_manifest.karpenter_nodeclass]
}
