module "eks" {

  source               = "../modules/eks"
  PROJECT_NAME         = var.PROJECT_NAME
  PUB_SUB1_ID          = module.vpc.PUB_SUB1_ID
  PUB_SUB2_ID          = module.vpc.PUB_SUB2_ID
  PRI_SUB3_ID          = module.vpc.PRI_SUB3_ID
  PRI_SUB4_ID          = module.vpc.PRI_SUB4_ID
  EKS_CLUSTER_ROLE_ARN = module.iam.EKS_CLUSTER_ROLE_ARN

}



module "iam" {
  source       = "../modules/iam"
  PROJECT_NAME = var.PROJECT_NAME
}


module "nat" {
  source       = "../modules/nat"
  PROJECT_NAME = var.PROJECT_NAME
  REGION       = var.REGION
  VPC_ID       = module.vpc.VPC_ID
  PUB_SUB1_ID  = module.vpc.PUB_SUB1_ID
  PUB_SUB2_ID  = module.vpc.PUB_SUB2_ID
  PRI_SUB3_ID  = module.vpc.PRI_SUB3_ID
  PRI_SUB4_ID  = module.vpc.PRI_SUB4_ID
  IGW_ID       = module.vpc.IGW_ID

}

module "nodegroup" {
  source              = "../modules/nodegroup"
  EKS_CLUSTER_NAME    = module.eks.EKS_CLUSTER_NAME
  NODE_GROUP_ROLE_ARN = module.iam.NODE_GROUP_ROLE_ARN
  PRI_SUB3_ID         = module.vpc.PRI_SUB3_ID
  PRI_SUB4_ID         = module.vpc.PRI_SUB4_ID

}



module "vpc" {
  source        = "../modules/vpc"
  PROJECT_NAME  = var.PROJECT_NAME
  REGION        = var.REGION
  VPC_CIDR      = var.VPC_CIDR
  PUB_SUB1_CIDR = var.PUB_SUB1_CIDR
  PUB_SUB2_CIDR = var.PUB_SUB2_CIDR
  PRI_SUB3_CIDR = var.PRI_SUB3_CIDR
  PRI_SUB4_CIDR = var.PRI_SUB4_CIDR

}