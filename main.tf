module "eks-spot" {

    source = "./modules/ocean-eks"

    dest_aws_profile_name            = var.dest_aws_profile_name
    spotinst_token                   = var.spotinst_token
    spotinst_account                 = var.spotinst_account
    cluster_identifier               = var.cluster_identifier
    cluster_name                     = var.cluster_name
    cluster_version                  = var.cluster_version
    region                           = var.region
    ami_id                           = var.ami_id
    min_size                         = var.min_size
    max_size                         = var.max_size
    desired_capacity                 = var.desired_capacity
    max_scale_down_percentage        = var.max_scale_down_percentage
    key_name                         = var.key_name
    associate_public_ip_address      = var.associate_public_ip_address
    vpc_cidr                         = var.vpc_cidr
    private_subnets                  = var.private_subnets
    public_subnets                   = var.public_subnets
    tags                             = var.tags
    peering_receiver_profile         = var.peering_receiver_profile
    peering_receiver_region          = var.peering_receiver_region
    peering_name                     = var.peering_name
    peering_owner_id                 = var.peering_owner_id
    peering_receiver_vpc_id          = var.peering_receiver_vpc_id
    peering_orginator_route_table_id = var.peering_orginator_route_table_id
    peering_originator_cidr          = var.peering_originator_cidr
    spot_subscription_events         = var.spot_subscription_events
    notification_sqs_arn             = var.notification_sqs_arn
    launch_specs                     = var.launch_specs
    cluster_endpoint_private_access  = var.cluster_endpoint_private_access
    cluster_endpoint_public_access   = var.cluster_endpoint_public_access
    additional_security_group        = var.additional_security_group
    controller_node_selector         = var.controller_node_selector
    instance_types_blacklist_gpu     = var.instance_types_blacklist_gpu
    map_users                        = var.map_users
    roll_all_nodes_on_change         = var.roll_all_nodes_on_change

}
