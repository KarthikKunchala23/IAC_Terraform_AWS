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

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be created"
  type        = string
  
}

variable "az1_cidr_block" {
  description = "CIDR block for the first availability zone subnet"
  type        = string
  default     = "10.0.0.0/24"
  
}

variable "az1_availability_zone" {
  description = "The availability zone for the first subnet"
  type        = string
  default     = "us-east-1a"
}

variable "az2_cidr_block" {
  description = "CIDR block for the second availability zone subnet"
  type        = string
  default     = "10.0.1.0/24"
  
}

variable "az2_availability_zone" {
  description = "The availability zone for the second subnet"
  type        = string
  default     = "us-east-1a"
}

variable "az3_cidr_block" {
  description = "CIDR block for the third availability zone subnet"
  type        = string
  default     = "10.1.0.0/24"
}

variable "az3_availability_zone" {
  description = "The availability zone for the third subnet"
  type        = string
  default     = "us-east-1a"
}