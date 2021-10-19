resource "kubernetes_daemonset" "gpu-plugin" {

    metadata {

        name      = "nvidia-device-plugin-daemonset"
        namespace = "kube-system"

    }

    spec {

        selector {

            match_labels = {

                name = "nvidia-device-plugin-ds"

            }

        }

        template {

            metadata {

                annotations = {

                    "scheduler.alpha.kubernetes.io/critical-pod" = ""

                }

                labels = {

                    name = "nvidia-device-plugin-ds"

                }

            }

            spec {

                toleration {

                    key      = "CriticalAddonsOnly"
                    operator = "Exists"

                }

                toleration {

                    key      = "nvidia.com/gpu"
                    operator = "Exists"
                    effect   = "NoSchedule"

                }

                container {

                    name  = "nvidia-device-plugin-ds"
                    image = "nvidia/k8s-device-plugin:v0.7.0"

                    args = [ "--fail-on-init-error=false" ]

                    security_context {

                        allow_privilege_escalation = false

                        capabilities {

                            drop = [ "ALL" ]

                        }

                    }

                    volume_mount {

                        name       = "device-plugin"
                        mount_path = "/var/lib/kubelet/device-plugins"

                    }

                }

                volume {

                    name = "device-plugin"

                    host_path {

                        path = "/var/lib/kubelet/device-plugins"
                    }

                }

                affinity {

                    node_affinity {

                        required_during_scheduling_ignored_during_execution {

                            node_selector_term {

                                match_expressions {

                                    key      = "beta.kubernetes.io/instance-type"
                                    operator = "In"

                                    values = [

                                        "p3.2xlarge",
                                        "p3.8xlarge",
                                        "p3.16xlarge",
                                        "p3dn.24xlarge",
                                        "g4dn.xlarge",
                                        "g4dn.2xlarge",
                                        "g4dn.4xlarge",
                                        "g4dn.8xlarge",
                                        "g4dn.16xlarge",
                                        "g4dn.12xlarge",
                                        "g3.2xlarge",
                                        "g3.4xlarge",
                                        "g3.8xlarge",
                                        "g3.16xlarge",
                                        "p2.xlarge",
                                        "p2.8xlarge",
                                        "p2.16xlarge"

                                    ]

                                }

                            }

                        }

                    }

                }

            }

        }

    }

}
