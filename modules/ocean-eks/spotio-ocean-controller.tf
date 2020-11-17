#
# Deploy the ocean controller pod.
#
module "ocean-controller" {

    depends_on = [

        module.vpc,

        aws_route.peering_forward,
        aws_route.peering_backward,
        aws_route.peering_backward_private_subnets,
        aws_route.peering_backward_public_subnets

    ]

    source = "../ocean-controller"

    spotinst_token     = var.spotinst_token
    spotinst_account   = var.spotinst_account
    cluster_identifier = var.cluster_name

}
