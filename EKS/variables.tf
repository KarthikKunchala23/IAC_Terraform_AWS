variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

variable "bootstrap_addons" {
  description = "Whether to bootstrap self-managed addons"
  type        = bool
  default     = false
}