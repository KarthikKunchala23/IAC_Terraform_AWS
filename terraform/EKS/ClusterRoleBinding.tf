resource "kubernetes_cluster_role" "admin" {
  metadata {
    name = "eks-admin-cluster-role"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services", "nodes", "deployments", "namespaces"]
    verbs      = ["get", "list", "watch", "create", "update", "delete"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "statefulsets", "daemonsets"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "admin" {
  metadata {
    name = "eks-admin-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.admin.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "eks-admin" # This should match the username mapped in aws-auth
    api_group = "rbac.authorization.k8s.io"
  }
}
