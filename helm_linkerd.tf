# resource "helm_release" "partials" {
#     name                = "partials"
#     chart               = "./helm/linkerd/partials"
#     namespace           = "linkerd"
#     create_namespace    = true

#     depends_on = [
#         aws_eks_cluster.eks_cluster,
#         aws_eks_node_group.cluster,
#         kubernetes_config_map.aws-auth,
#         helm_release.alb_ingress_controller
#     ]
# }

resource "helm_release" "base" {
    name                = "linkerd"
    chart               = "./helm/linkerd/linkerd2"
    namespace           = "linkerd"
    create_namespace    = true

    depends_on = [
        aws_eks_cluster.eks_cluster,
        aws_eks_node_group.cluster,
        kubernetes_config_map.aws-auth,
        helm_release.alb_ingress_controller,
        # helm_release.partials
    ]
}