resource "aws_iam_role" "workers" {

    provider = aws.caller

    name_prefix           = var.cluster_name
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
