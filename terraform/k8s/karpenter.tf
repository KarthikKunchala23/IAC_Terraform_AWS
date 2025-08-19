# karpenter.tf

# Apply Karpenter NodeClass
resource "null_resource" "karpenter_nodeclass" {
  provisioner "local-exec" {
    command = <<EOT
      kubectl apply -f ${path.module}/manifests/karpenter-nodeclass.yaml
    EOT
  }

  triggers = {
    always_run = timestamp()
  }
}

# Apply Karpenter NodePool
resource "null_resource" "karpenter_nodepool" {
  provisioner "local-exec" {
    command = <<EOT
      kubectl apply -f ${path.module}/manifests/karpenter-nodepool.yaml
    EOT
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [null_resource.karpenter_nodeclass]
}
