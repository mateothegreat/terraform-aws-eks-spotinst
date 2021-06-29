terraform {
    backend "s3" {}
    required_providers {
        kubernetes-alpha = {
            source  = "hashicorp/kubernetes-alpha"
            version = "0.2.1"
        }
        kubernetes       = {
            source  = "hashicorp/kubernetes"
            version = "2.0.0"
        }
        aws              = {
            source  = "hashicorp/aws"
            version = "3.30.0"
        }
    }
}
variable "aws_profile" {}
variable "vpc_cidr" {}
variable "spotinst_account" {}
variable "spotinst_token" {}
variable "cluster_name" {}
variable "aws_region" {}
variable "peering_owner_id" {}
variable "peering_receiver_region" {}
variable "peering_receiver_profile" {}
variable "peering_receiver_vpc_id" {}
variable "peering_orginator_route_table_id" {}
variable "peering_originator_cidr" {}
variable "image_id" {
    description = "ami for nodes to use (defaults to eu-west-2)"
    default     = "ami-0d43b13043c284dbb" // eu-west-2
    #    default = "ami-0fae38e27c6113140" // us-east-1
}
locals {
    vpc_cidr = var.vpc_cidr
    subnets  = cidrsubnets(local.vpc_cidr, 5, 5, 5, 5)
}
module "eks" {
    source  = "mateothegreat/eks-spotinst/aws"
    version = "2.0.9"
    dest_aws_profile_name            = var.aws_profile
    spotinst_account                 = var.spotinst_account
    spotinst_token                   = var.spotinst_token
    cluster_name                     = var.cluster_name
    cluster_version                  = "1.18"
    region                           = var.aws_region
    min_size                         = 4
    max_size                         = 20
    desired_capacity                 = 8
    vpc_cidr                         = local.vpc_cidr
    private_subnets                  = [local.subnets[0], local.subnets[1]]
    public_subnets                   = [local.subnets[2], local.subnets[3]]
    peering_name                     = "${ var.cluster_name }-to-devops-vpn"
    peering_owner_id                 = var.peering_owner_id
    peering_receiver_region          = var.peering_receiver_region
    peering_receiver_profile         = var.peering_receiver_profile
    peering_receiver_vpc_id          = var.peering_receiver_vpc_id
    peering_orginator_route_table_id = var.peering_orginator_route_table_id
    peering_originator_cidr          = var.peering_originator_cidr
    notification_sqs_arn             = null
    cluster_endpoint_private_access  = false
    cluster_endpoint_public_access   = true
    controller_node_selector = null
    tags = {
        environment = "prod"
    }
    launch_specs = [
        {
            name               = "services"
            spot_percentage    = 100
            root_volume_size   = 100
            max_instance_count = 15
            image_id           = var.image_id
            instance_types     = null
            labels = {
                role = "services"
            }
            tags = {
                role = "service"
            }
        },
        {
            name               = "infra"
            spot_percentage    = 100
            root_volume_size   = 100
            max_instance_count = 5
            image_id           = var.image_id
            instance_types     = null
            labels             = {
                role = "infra"
            }
            tags = {
                role = "infra"
            }
        }
    ]
}
output "cluster" {
    value = module.eks
}
