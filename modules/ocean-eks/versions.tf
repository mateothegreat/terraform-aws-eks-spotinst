terraform {

    required_providers {

        aws = {

            source = "hashicorp/aws"

        }

        kubernetes = {

            source = "hashicorp/kubernetes"

        }

        spotinst = {

            source = "spotinst/spotinst"

        }

    }

    required_version = ">= 0.13"

}
