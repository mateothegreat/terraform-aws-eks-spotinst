output "kubeconfig" {

    description = "kubectl config file contents for this EKS cluster"
    value       = module.eks-spot.kubeconfig

}

output "cluster_endpoint" {

    description = "The endpoint for your EKS Kubernetes API"
    value       = module.eks-spot.cluster_endpoint

}

output "service_account_token" {

    description = "service account token for root"
    value       = module.eks-spot.service_account_token

}

output "vpc_id" {

    description = "newly created vpc id"
    value       = module.eks-spot.vpc_id

}

output "public_subnet_id" {

    description = "newly created vpc id"
    value       = module.eks-spot.public_subnet_id

}

output "cluster_security_group_id" {

    description = "Security group ID attached to the EKS cluster"
    value       = module.eks-spot.cluster_security_group_id

}
