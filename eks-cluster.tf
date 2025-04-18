module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.35.0"
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version
  subnet_ids      = module.vpc.private_subnets

  enable_irsa = true

  tags = {
    cluster = "demo"
    environment = "dev"
    owner       = "haneesh"
  }



  vpc_id = module.vpc.vpc_id

  cluster_endpoint_public_access  = true

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {

    node_group = {
      min_size     = 1
      max_size     = 4
      desired_size = 2
    }
  }
}

