#resource "kubernetes_service_account" "service-account" {
#
#    depends_on = [ module.eks ]
#
#    metadata {
#
#        name      = "root"
#        namespace = "default"
#
#    }
#
#}
#
#resource "kubernetes_cluster_role_binding" "service-account" {
#
#    depends_on = [ module.eks ]
#
#    metadata {
#
#        name = "root"
#
#    }
#
#    role_ref {
#
#        api_group = "rbac.authorization.k8s.io"
#        kind      = "ClusterRole"
#        name      = "cluster-admin"
#    }
#
#    subject {
#
#        kind      = "ServiceAccount"
#        name      = "root"
#        namespace = "default"
#
#    }
#
#}
#
#data "kubernetes_secret" "this" {
#
#    metadata {
#
#        name = kubernetes_service_account.service-account.default_secret_name
#
#    }
#
#}
