data "aws_iam_policy_document" "workers_assume_role_policy" {

    provider = aws.caller

    statement {

        sid     = "EKSWorkerAssumeRole"
        actions = [ "sts:AssumeRole" ]

        principals {

            type        = "Service"
            identifiers = [ "ec2.amazonaws.com" ]

        }

    }

}

data "aws_eks_cluster" "cluster" {

    provider = aws.caller

    name = module.eks.cluster_id

}

data "aws_eks_cluster_auth" "cluster" {

    provider = aws.caller

    name = module.eks.cluster_id

}

data "aws_availability_zones" "available" {

    provider = aws.caller

}
