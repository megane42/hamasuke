module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "vpc_${local.service}_${local.env}"
  cidr   = "10.0.0.0/16"

  private_subnets    = ["10.0.15.0/24", "10.0.55.0/24"]
  public_subnets     = ["10.0.11.0/24", "10.0.51.0/24"]
  azs                = ["ap-northeast-1a", "ap-northeast-1c"]

  single_nat_gateway = true
  enable_nat_gateway = true

  # 意図しない default security group の利用を未然に防ぐために、default security group のルールを「全拒否」にする
  manage_default_security_group  = true
  default_security_group_egress  = []
  default_security_group_ingress = []
}
