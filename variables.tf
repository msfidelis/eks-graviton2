variable "cluster_name" {
  default = "eks-do-hype"
}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "k8s_version" {
  description = "Default Kubernetes Version"
  default     = "1.24"
}

variable "nodes_instances_sizes" {
  description = "List of family instance sizes. Fixed in **.g.instance"
  default = [
    "c6g.large"
  ]
}

variable "auto_scale_options" {
  description = "Auto Scaling Options"
  default = {
    min     = 4
    max     = 10
    desired = 6
  }
}

variable "nlb_ingress_internal" {
  description = "Flag to create internal or external NLB"
  type        = bool
  default     = false
}

variable "nlb_ingress_type" {
  description = "Network Load Balancer"
  type        = string
  default     = "network"
}

variable "proxy_protocol_v2" {
  description = "Proxy Protocol v2 Enable"
  type        = bool
  default     = false
}

variable "volume_size" {
  description = "EBS size for EC2 nodes instances"
  type        = number
  default     = 50
}

variable "volume_type" {
  description = "EBS volume type"
  type        = string
  default     = "gp3"
}

// Graviton2
variable "ami_type" {
  description = "AMI Type. Need's to be ARM_64"
  type        = string
  default     = "AL2_ARM_64"
}

variable "addon_cni_version" {
  type        = string
  description = "VPC CNI Version"
  default     = "v1.12.6-eksbuild.1"
}

variable "addon_coredns_version" {
  type        = string
  description = "CoreDNS Version"
  default     = "v1.8.7-eksbuild.4"
}

variable "addon_kubeproxy_version" {
  type        = string
  description = "Kubeproxy Version"
  default     = "v1.22.17-eksbuild.2"
}

variable "addon_csi_version" {
  type        = string
  description = "CSI Version"
  default     = "v1.17.0-eksbuild.1"
}

variable "nlb_ingress_enable_termination_protection" {
  type    = bool
  default = false
}

variable "enable_cross_zone_load_balancing" {
  type    = bool
  default = true
}

// Grafana

variable "grafana_virtual_service_host" {
  type    = string
  default = "grafana.k8s.raj.ninja"
}

// Kiali
variable "kiali_virtual_service_host" {
  type    = string
  default = "kiali.k8s.raj.ninja"
}

variable "grafana_kiali_virtual_service_host" {
  type    = string
  default = "grafana.kiali.k8s.raj.ninja"
}

// Jaeger
variable "jaeger_virtual_service_host" {
  type    = string
  default = "jaeger.k8s.raj.ninja"
}

variable "default_tags" {
  default = {
    Environment = "prod"
    Foo         = "Bar"
    Ping        = "Pong"
  }
}
