resource "helm_release" "kube_state_metrics" {

    count               = 0
    name                = "kube-state-metrics"
    repository          = "https://prometheus-community.github.io/helm-charts" 
    chart               = "kube-state-metrics"
    namespace           = "kube-system"
    create_namespace    = true

    set {
        name            = "apiService.create"
        value           = "true"
    }

    depends_on = [
        aws_eks_cluster.eks_cluster,
        aws_eks_node_group.cluster,
        kubernetes_config_map.aws-auth
    ]
}