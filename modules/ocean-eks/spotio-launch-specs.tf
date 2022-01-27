resource "spotinst_ocean_aws_launch_spec" "launch_spec" {

    count = length(var.launch_specs)

    ocean_id         = spotinst_ocean_aws.this.id
    name             = var.launch_specs[ count.index ].name
    image_id         = var.launch_specs[ count.index ].image_id
    instance_types   = var.launch_specs[ count.index ].instance_types ? var.launch_specs[ count.index ].instance_types : var.instance_types_whitelist_gpu
    root_volume_size = var.launch_specs[ count.index ].root_volume_size

    resource_limits {

        max_instance_count = var.launch_specs[ count.index ].max_instance_count

    }

    strategy {

        spot_percentage = var.launch_specs[ count.index ].spot_percentage

    }

    #
    # https://registry.terraform.io/providers/spotinst/spotinst/latest/docs/resources/ocean_aws_launch_spec#autoscale_headrooms
    #
    autoscale_headrooms {

        num_of_units    = var.launch_specs[ count.index ].autoscale_headrooms.num_of_units
        cpu_per_unit    = var.launch_specs[ count.index ].autoscale_headrooms.cpu_per_unit
        gpu_per_unit    = var.launch_specs[ count.index ].autoscale_headrooms.gpu_per_unit
        memory_per_unit = var.launch_specs[ count.index ].autoscale_headrooms.memory_per_unit

    }

    dynamic "labels" {

        for_each = var.launch_specs[ count.index ].labels

        content {

            key   = labels.key
            value = labels.value

        }

    }

    tags {

        key   = "Name"
        value = "${ var.cluster_name }-ocean-cluster-node-${ var.launch_specs[ count.index ].name }"

    }

    tags {

        key   = "kubernetes.io/cluster/${ var.cluster_name }"
        value = "owned"

    }

    dynamic "tags" {

        for_each = var.launch_specs[ count.index ].tags

        content {

            key   = tags.key
            value = tags.value

        }

    }

}
