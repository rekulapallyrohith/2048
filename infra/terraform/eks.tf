resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.29"

  vpc_config {
    subnet_ids = aws_subnet.private[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]
}

resource "aws_eks_node_group" "nodegroup" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "2048-ng"
  node_role_arn   = aws_iam_role.node_role.arn

  subnet_ids = aws_subnet.private[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.small"]

  depends_on = [
    aws_iam_role_policy_attachment.worker_policies
  ]
}

resource "null_resource" "cli" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ap-south-1 --name ${var.cluster_name}"
  }
  depends_on = [aws_eks_cluster.eks]

}