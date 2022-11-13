resource "aws_iam_role" "cluster" {

    name = "${ var.cluster_name }-clusterrole"

    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {

    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.cluster.name

}


resource "aws_iam_role" "workers" {

    provider = aws.caller

    name                  = "${ var.cluster_name }-workerrole"
    assume_role_policy    = data.aws_iam_policy_document.workers_assume_role_policy.json
    force_detach_policies = true
    tags                  = var.tags

}

resource "aws_iam_instance_profile" "workers" {

    provider = aws.caller

    name_prefix = var.cluster_name
    role        = aws_iam_role.workers.name

}

resource "aws_iam_role_policy_attachment" "workers_AmazonEKSWorkerNodePolicy" {

    provider = aws.caller

    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.workers.name

}

resource "aws_iam_role_policy_attachment" "workers_AmazonEKS_CNI_Policy" {

    provider = aws.caller

    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.workers.name

}

resource "aws_iam_role_policy_attachment" "workers_AmazonEC2ContainerRegistryReadOnly" {

    provider = aws.caller

    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.workers.name

}
