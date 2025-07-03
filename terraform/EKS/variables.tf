variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

variable "kubernetes_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "enable_cluster_autoscaler" {
  description = "Whether to enable the cluster autoscaler"
  type        = bool
  default     = false
}

variable "bootstrap_addons" {
  description = "Whether to bootstrap self-managed addons"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be created"
  type        = string

  validation {
    condition     = can(regex("^vpc-[a-f0-9]+$", var.vpc_id))
    error_message = "The vpc_id must be a valid VPC ID (e.g., vpc-xxxxxxxx)."
  }
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
  default     = "eks-node-group"
}

variable "node_instance_type" {
  description = "The instance type for the EKS nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_group_min_size" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "az1_cidr_block" {
  description = "CIDR block for the first availability zone subnet"
  type        = string
  default     = "10.0.1.0/24"
  
}

variable "az1_availability_zone" {
  description = "The availability zone for the first subnet"
  type        = string
  default     = "us-east-1a"
}

variable "az2_cidr_block" {
  description = "CIDR block for the second availability zone subnet"
  type        = string
  default     = "10.0.2.0/24"
  
}

variable "az2_availability_zone" {
  description = "The availability zone for the second subnet"
  type        = string
  default     = "us-east-1b"
}

variable "az3_cidr_block" {
  description = "CIDR block for the third availability zone subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "az3_availability_zone" {
  description = "The availability zone for the third subnet"
  type        = string
  default     = "us-east-1c"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  
}