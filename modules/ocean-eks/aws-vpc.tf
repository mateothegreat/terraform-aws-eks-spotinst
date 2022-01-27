module "vpc" {

    providers = {

        aws = aws.caller

    }

    source  = "terraform-aws-modules/vpc/aws"
    version = "3.10.0"

    name               = var.cluster_name
    cidr               = var.vpc_cidr
    azs                = [ data.aws_availability_zones.available.names[ 0 ], data.aws_availability_zones.available.names[ 1 ], data.aws_availability_zones.available.names[ 2 ] ]
    private_subnets    = var.private_subnets
    public_subnets     = var.public_subnets
    enable_nat_gateway = true
    single_nat_gateway = true

    tags = merge(var.tags, {

        "kubernetes.io/cluster/${var.cluster_name}" = "shared"

    })

}
