variable "dest_aws_profile_name" {

    type        = string
    description = "callers (destination) aws profile name"

}

variable "spotinst_token" {
    type        = string
    description = "Spotinst Personal Access token"
}

variable "spotinst_account" {
    type        = string
    description = "Spotinst account ID"
}

variable "cluster_identifier" {
    type        = string
    description = "Cluster identifier"
    default     = null
}

variable "cluster_name" {
    type        = string
    description = "Cluster name"
}

variable "cluster_version" {
    type        = string
    description = "Kubernetes supported version"
    default     = "1.18"
}

variable "region" {
    type        = string
    description = "The region the EKS cluster will be located"
}

variable "ami_id" {
    type        = string
    description = "The image ID for the EKS worker nodes. If none is provided, Terraform will search for the latest version of their EKS optimized worker AMI based on platform"
    default     = null
}

variable "min_size" {
    type        = number
    description = "The lower limit of worker nodes the Ocean cluster can scale down to"
}

variable "max_size" {
    type        = number
    description = "The upper limit of worker nodes the Ocean cluster can scale up to"
}

variable "desired_capacity" {
    type        = number
    description = "The number of worker nodes to launch and maintain in the Ocean cluster"
}

variable "key_name" {
    type        = string
    description = "The key pair to attach to the worker nodes launched by Ocean"
    default     = null
}

variable "associate_public_ip_address" {
    type        = bool
    description = "Associate a public IP address to worker nodes"
    default     = false
}

variable "vpc_cidr" {
    type        = string
    description = "The cidr blocks for the vpc"
    default     = "10.0.0.0/16"
}

variable "private_subnets" {
    type        = list
    description = "cidr ranges for the private subnets"
    default     = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}

variable "public_subnets" {
    type        = list
    description = "cidr ranges for the public subnets"
    default     = [ "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24" ]
}

variable "tags" {

    description = "ec2 tags"

}

variable "peering_name" {

    type        = string
    description = "peering connection name"

}

variable "peering_owner_id" {

    type        = string
    description = "account id of peering connection owner"

}

variable "peering_receiver_profile" {

    type        = string
    description = "aws profile recieving peering connection"

}

variable "peering_receiver_region" {

    type        = string
    description = "aws profile recieving peering connection"

}

variable "peering_receiver_vpc_id" {

    type        = string
    description = "vpc id of recieving peering connection"

}

variable "peering_orginator_route_table_id" {

    type        = string
    description = "route table id for originating route table to add route to"

}

variable "peering_originator_cidr" {

    type        = string
    description = "cidr for receiving route table to add route to"

}

variable "spot_subscription_events" {

    type    = list(string)
    default = [

        "AWS_EC2_INSTANCE_TERMINATE",
        "AWS_EC2_INSTANCE_TERMINATED",
        "AWS_EC2_INSTANCE_LAUNCH",
        "AWS_EC2_INSTANCE_READY_SIGNAL_TIMEOUT",
        "AWS_EC2_CANT_SPIN_OD",
        "AWS_EC2_INSTANCE_UNHEALTHY_IN_ELB",
        "GROUP_ROLL_FAILED",
        "GROUP_ROLL_FINISHED",
        "CANT_SCALE_UP_GROUP_MAX_CAPACITY",
        "GROUP_UPDATED",
        "CLUSTER_ROLL_FINISHED",
        "GROUP_ROLL_FAILED"

    ]

}

variable "notification_sqs_arn" {

    type        = string
    description = "aws sqs arn for event subscriptions"

}

variable "launch_specs" {

    description = "launch specs for node groups"

    type = list(object({

        name               = string
        image_id           = string
        // amazon-eks-gpu-node-1.16-v20200921
        root_volume_size   = number
        max_instance_count = number
        instance_types     = list(string)
        tags               = list(map(string))

        labels = list(object({

            key   = string
            value = string

        }))

    }))

}

variable "install_gpu_plugin" {

    type = bool
    description = "if true the nvidia gpu plugin daemonset will be installed"
    default = false

}
