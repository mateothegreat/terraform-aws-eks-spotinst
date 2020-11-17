terraform {

    required_providers {

        aws = {

            source = "hashicorp/aws"

        }

        kubernetes = {

            source = "hashicorp/kubernetes"

        }

        spotinst = {

            source = "terraform-providers/spotinst"

        }

    }

    required_version = ">= 0.13"

}
