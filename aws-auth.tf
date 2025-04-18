module "eks_auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "20.35.0"

  depends_on = [module.eks]

  eks_cluster_name = module.eks.cluster_name
  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::XXXXXX:user/User"
      username = "admin"
      groups   = ["system:masters"]
    }
  ]
}
