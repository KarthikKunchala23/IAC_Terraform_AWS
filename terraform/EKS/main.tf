resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = "1.31"

  bootstrap_self_managed_addons = var.bootstrap_addons
  # Enable self-managed add-ons for the cluster

  compute_config {
    enabled       = true
    node_pools    = ["general-purpose"]
    node_role_arn = aws_iam_role.node.arn
  }

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }

  storage_config {
    block_storage {
      enabled = true
    }
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true

    subnet_ids = [
      aws_subnet.az3.id,
      aws_subnet.az4.id,
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSComputePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSBlockStoragePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSLoadBalancingPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSNetworkingPolicy,
  ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.cluster.name
}


resource "aws_eks_access_entry" "admin_access" {
  cluster_name = aws_eks_cluster.cluster.name
  principal_arn = ""
  type = "STANDARD"
  kubernetes_groups = ["system:masters"]
}

resource "aws_eks_access_policy_association" "admin_access_policy" {
  cluster_name = aws_eks_cluster.cluster.name
  principal_arn = aws_eks_access_entry.admin_access.principal_arn
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSAdminPolicy"
  access_scope {
    type = "CLUSTER"
  }
  depends_on = [ aws_eks_access_entry.admin_access ]
}
resource "aws_iam_role" "node" {
  name = "eks-auto-node-example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole"]
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}
resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryPullOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSComputePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSBlockStoragePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSLoadBalancingPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSNetworkingPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
  role       = aws_iam_role.cluster.name
}

# Node group for general purpose workloads

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.cluster.version}/amazon-linux-2023/x86_64/standard/recommended/release_version"
}


resource "aws_security_group" "node_sg" {
  name        = "${var.cluster_name}-node-sg"
  description = "Security group for EKS nodes"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
  }

}


# data "aws_ami" "eks_worker" {
#   most_recent = true
#   owners      = ["897722700244"] # Amazon EKS AMI Account ID
#   filter {
#     name   = "name"
#     values = ["amazon-eks-node-1.31-*"]  # match the correct version
#   }
# }
  
resource "aws_launch_template" "eks_node_lt" {
  name_prefix   = "${var.cluster_name}-node-"
  image_id      = data.aws_ssm_parameter.eks_ami_release_version.value
  instance_type = var.node_instance_type[0]


  network_interfaces {
    security_groups = [aws_security_group.node_sg.id]
    associate_public_ip_address = false
  }

  lifecycle {
    create_before_destroy = true
  }
  
}

resource "aws_eks_node_group" "general_purpose" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.node_group_name}-general-purpose-nodes"
  node_role_arn   = aws_iam_role.node.arn
  version         = aws_eks_cluster.cluster.version
  # release_version = data.aws_ssm_parameter.eks_ami_release_version.value

  launch_template {
    id      = aws_launch_template.eks_node_lt.id
    version = "$Latest"
  }
  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  subnet_ids = [
    aws_subnet.az3.id,
    aws_subnet.az4.id,
  ]

  instance_types = var.node_instance_type

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryPullOnly,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy
  ]
}