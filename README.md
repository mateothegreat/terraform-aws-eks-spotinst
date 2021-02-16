# AWS EKS + Spot.io

* Provisions an EKS cluster in 15 minutes flat.
* Provisions a new VPC with all dependencies.
* Automagically sets up peering (i.e.: private network connectivity through pfsense in a different vpc.)
* Installs GPU plugin (optional).
* Creates a "root" service account and outputs token.

## Usage

```hcl
module "eks" {

    source  = "mateothegreat/eks-spotinst/aws"
    version = "<version goes here>"

    dest_aws_profile_name            = "<aws profile to provision resources under>"
    spotinst_account                 = "<spot.io account id>"
    spotinst_token                   = "<spot.io account token>"
    cluster_name                     = "awesome-1"
    cluster_version                  = "1.18"
    region                           = "us-east-1"
    min_size                         = 1
    max_size                         = 10
    desired_capacity                 = 2
    vpc_cidr                         = "192.1.0.0/16"
    private_subnets                  = [ "192.1.1.0/24", "192.1.2.0/24" ]
    public_subnets                   = [ "192.1.3.0/24", "192.1.3.0/24" ]
    peering_name                     = "mycluster-to-devops-vpn"
    peering_owner_id                 = "<origin aws account id>"
    peering_receiver_region          = "us-east-1"
    peering_receiver_profile         = "<my other aws profile>"
    peering_receiver_vpc_id          = "<destination peering vpc id>"
    peering_orginator_route_table_id = "<destination peering to route table id>"
    peering_originator_cidr          = "<cidr of destination peering network>"
    notification_sqs_arn             = null
    cluster_endpoint_private_access  = true
    cluster_endpoint_public_access   = false
    tags                             = local.tags

    launch_specs = [

        {

            name               = "services"
            root_volume_size   = 100
            max_instance_count = 3
            image_id           = "ami-0fae38e27c6113140"
            instance_types     = null
            tags               = local.tags

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
```
