module "eks" {

    providers = {

        aws = aws.caller

    }

    depends_on = [

        aws_route.peering_forward,
        aws_route.peering_backward,
        aws_route.peering_backward_private_subnets,
        aws_route.peering_backward_public_subnets,

        aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
        aws_iam_role_policy_attachment.workers_AmazonEC2ContainerRegistryReadOnly,
        aws_iam_role_policy_attachment.workers_AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.workers_AmazonEKSWorkerNodePolicy

    ]

    source                               = "terraform-aws-modules/eks/aws"
    version                              = "17.24.0"
    write_kubeconfig                     = false
    cluster_name                         = var.cluster_name
    cluster_version                      = var.cluster_version
    subnets                              = module.vpc.private_subnets
    tags                                 = var.tags
    vpc_id                               = module.vpc.vpc_id
    manage_cluster_iam_resources         = true
    #    cluster_iam_role_name                = aws_iam_role.cluster.name
    worker_additional_security_group_ids = [ aws_security_group.all_worker_mgmt.id, var.additional_security_group ]
    cluster_endpoint_private_access      = var.cluster_endpoint_private_access
    cluster_endpoint_public_access       = var.cluster_endpoint_public_access
    cluster_enabled_log_types            = [ "api", "audit", "authenticator", "controllerManager", "scheduler" ]

    map_roles = [

        {

            rolearn  = aws_iam_role.workers.arn
            username = "system:node:{{EC2PrivateDNSName}}"
            groups   = [ "system:nodes" ]

        }

    ]

    map_users = var.map_users

}
