locals {

    cluster_name = "mlfabric-sandbox-testing-1"
    tags         = {}

}

variable "spotinst_token" {}

module "test" {

    source = "../"

    dest_aws_profile_name            = "mlfabric-sandbox"
    spotinst_account                 = "act-44600505"
    spotinst_token                   = var.spotinst_token
    cluster_name                     = "matthew-1"
    cluster_version                  = "1.20"
    region                           = "us-east-1"
    min_size                         = 1
    max_size                         = 10
    desired_capacity                 = 2
    vpc_cidr                         = "172.200.4.0/23"
    private_subnets                  = [ "172.200.4.0/25", "172.200.4.128/25" ]
    public_subnets                   = [ "172.200.5.0/25", "172.200.5.128/25" ]
    peering_name                     = "${local.cluster_name }-to-devops-vpn"
    peering_owner_id                 = "881029454603"
    peering_orginator_route_table_id = "rtb-0c3f673158e4eeec0"
    peering_originator_cidr          = "8.0.0.224/32"
    peering_receiver_vpc_id          = "vpc-09dca0f5229137c2b"
    peering_receiver_profile         = "mlfabric"
    peering_receiver_region          = "us-east-1"
    notification_sqs_arn             = null
    cluster_endpoint_private_access  = true
    cluster_endpoint_public_access   = false
    controller_node_selector         = null
    ami_id                           = "ami-0d6c8b2a8562eba37"

    tags = local.tags

    launch_specs = [

        {

            name               = "services"
            root_volume_size   = 100
            max_instance_count = 3
            image_id           = "ami-0d6c8b2a8562eba37"
            instance_types     = null
            tags               = local.tags
            spot_percentage    = 100

            labels = {

                role = "services"

            }

            autoscale_headrooms = {

                num_of_units    = 5
                cpu_per_unit    = 1000
                gpu_per_unit    = 0
                memory_per_unit = 2048

            }

        }

    ]

}
