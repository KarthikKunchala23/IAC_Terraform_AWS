resource "aws_eks_cluster" "eks" {
  name     = "demo-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = concat(
      aws_subnet.public[*].id,
      aws_subnet.private[*].id
    )
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy]
}

resource "aws_eks_node_group" "managed" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "managed-nodes"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = aws_subnet.private[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = "$Latest"
  }

  depends_on = [
    aws_eks_cluster.eks,
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy
  ]
}


#start of launch template
data "aws_ssm_parameter" "eks_ami" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2/recommended/image_id"
}

data "aws_ami" "eks_worker" {
  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID

  filter {
    name   = "image-id"
    values = [data.aws_ssm_parameter.eks_ami.value]
  }
}

resource "aws_launch_template" "eks_nodes" {
  name_prefix   = "eks-nodes-"
  image_id      = data.aws_ami.eks_worker.id
  instance_type = var.node_instance_type

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "eks-managed-node"
    }
  }

  user_data = base64encode(<<-EOT
              #!/bin/bash
              yum install -y amazon-ssm-agent
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent
              /etc/eks/bootstrap.sh ${aws_eks_cluster.eks.name} \
                --kubelet-extra-args '--node-labels=eks-nodegroup=managed'
              EOT
            )
}


#End of launch template


# SQS Queue for interruption handling
resource "aws_sqs_queue" "karpenter" {
  name = "${var.cluster_name}-karpenter-interruption"
}