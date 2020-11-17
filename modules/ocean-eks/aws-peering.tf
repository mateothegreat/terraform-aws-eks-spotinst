resource "aws_vpc_peering_connection" "this" {

    provider = aws.caller

    peer_owner_id = var.peering_owner_id
    peer_vpc_id   = var.peering_receiver_vpc_id
    vpc_id        = module.vpc.vpc_id
    auto_accept   = false
    tags          = var.tags

}

resource "aws_vpc_peering_connection_accepter" "peer" {

    provider = aws.accepter

    vpc_peering_connection_id = aws_vpc_peering_connection.this.id
    auto_accept               = true
    tags                      = var.tags

}

resource "aws_route" "peering_forward" {

    provider = aws.accepter

    route_table_id            = var.peering_orginator_route_table_id
    destination_cidr_block    = var.vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.this.id

}

resource "aws_route" "peering_backward" {

    provider = aws.caller

    route_table_id            = module.vpc.vpc_main_route_table_id
    destination_cidr_block    = var.peering_originator_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.this.id

}

resource "aws_route" "peering_backward_private_subnets" {

    provider = aws.caller

    count                     = length(module.vpc.private_route_table_ids)
    route_table_id            = module.vpc.private_route_table_ids[ count.index ]
    destination_cidr_block    = var.peering_originator_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.this.id

}
resource "aws_route" "peering_backward_public_subnets" {

    provider = aws.caller

    count                     = length(module.vpc.public_route_table_ids)
    route_table_id            = module.vpc.public_route_table_ids[ count.index ]
    destination_cidr_block    = var.peering_originator_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.this.id

}

resource "aws_security_group_rule" "management" {

    provider = aws.caller

    depends_on = [

        aws_route.peering_forward,
        aws_route.peering_backward,
        aws_route.peering_backward_private_subnets,
        aws_route.peering_backward_public_subnets

    ]

    type              = "ingress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = [ var.peering_originator_cidr ]
    security_group_id = module.eks.cluster_security_group_id

}

resource "aws_security_group" "all_worker_mgmt" {

    provider = aws.caller

    name_prefix = "${ var.cluster_name }-management"
    vpc_id      = module.vpc.vpc_id
    tags        = var.tags

    ingress {

        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [ var.peering_originator_cidr ]

    }

}
