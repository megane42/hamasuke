resource "aws_wafv2_web_acl_association" "this" {
  resource_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:368771686176:loadbalancer/app/hamas-Publi-1LDAGUT6255UX/bf501bff7b8de46d" # copilot で作った ALB (stg) の ARN
  web_acl_arn  = data.terraform_remote_state.base.outputs.aws_wafv2_web_acl_this_arn
}
