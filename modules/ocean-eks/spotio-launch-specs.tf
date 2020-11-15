
resource "spotinst_ocean_aws_launch_spec" "launch_spec" {

    count = length(var.launch_specs)

    ocean_id         = spotinst_ocean_aws.this.id
    name             = var.launch_specs[ count.index ].name
    image_id         = var.launch_specs[ count.index ].image_id
    instance_types   = var.launch_specs[ count.index ].instance_types
    root_volume_size = var.launch_specs[ count.index ].root_volume_size

    resource_limits {

        max_instance_count = var.launch_specs[ count.index ].max_instance_count

    }

    dynamic "labels" {

        for_each = var.launch_specs[ count.index ].labels

        content {

            key   = labels.value[ "key" ]
            value = labels.value[ "value" ]

        }

    }

    dynamic "tags" {

        for_each = concat([

            {

                key   = "kubernetes.io/cluster/${ var.cluster_name }"
                value = "owned"

            },
            {

                key   = "Name"
                value = "${ var.cluster_name }-ocean-cluster-node-${ var.launch_specs[ count.index ].name }"

            }

        ], var.launch_specs[ count.index ].tags)

        content {

            key   = tags.value[ "key" ]
            value = tags.value[ "value" ]

        }

    }

}
