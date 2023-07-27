resource "aws_wafv2_web_acl_association" "this" {
  resource_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:368771686176:loadbalancer/app/hamas-Publi-1QDZCMVIQADBE/a9e7b3d9469e64bf" # copilot で作った ALB (prd) の ARN
  web_acl_arn  = data.terraform_remote_state.base.outputs.aws_wafv2_web_acl_this_arn
}
