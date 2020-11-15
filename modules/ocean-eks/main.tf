provider "aws" {

    alias   = "caller"
    region  = var.region
    profile = var.dest_aws_profile_name

}

provider "aws" {

    alias   = "accepter"
    region  = var.peering_receiver_region
    profile = var.peering_receiver_profile

}

provider "spotinst" {

    token   = var.spotinst_token
    account = var.spotinst_account

}

provider "kubernetes" {

    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    load_config_file       = false

}
