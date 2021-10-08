resource "aws_eks_node_group" "cluster" {
  
    cluster_name    = aws_eks_cluster.eks_cluster.name
    node_group_name = format("%s", aws_eks_cluster.eks_cluster.name)
    node_role_arn   = aws_iam_role.eks_nodes_roles.arn

    subnet_ids = [
        aws_subnet.private_subnet_1a.id,
        aws_subnet.private_subnet_1b.id,
        aws_subnet.private_subnet_1c.id
    ]

    ami_type            = var.ami_type

    instance_types      = var.nodes_instances_sizes

    scaling_config {
        desired_size    = lookup(var.auto_scale_options, "desired")
        max_size        = lookup(var.auto_scale_options, "max")
        min_size        = lookup(var.auto_scale_options, "min")
    }

    labels = {
        "ingress/ready" = "true"
    }

    tags = {
        "kubernetes.io/cluster/${var.cluster_name}" = "owned",
        "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned",
        "k8s.io/cluster-autoscaler/enabled" = true
    }

    lifecycle {
        ignore_changes = [
            scaling_config[0].desired_size
        ]
    }

    depends_on = [
        kubernetes_config_map.aws-auth
    ]
}

resource "aws_security_group" "cluster_nodes_sg" {
    name = format("%s-nodes-sg", var.cluster_name)
    vpc_id = aws_vpc.cluster_vpc.id

    egress {
        from_port   = 0
        to_port     = 0

        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = format("%s-nodes-sg", var.cluster_name)
    }

}

resource "aws_security_group_rule" "nodeport" {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 30000
    to_port     = 32768
    description = "nodeport"
    protocol    = "tcp"

    security_group_id = aws_security_group.cluster_nodes_sg.id
    type = "ingress"
}

resource "aws_launch_template" "main" {
  name = format("%s-node-group", aws_eks_cluster.eks_cluster.name)

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
        encrypted = true
        volume_size = var.volume_size
        kms_key_id  = aws_kms_key.eks.arn
        volume_type = var.volume_type
    }
  }

}