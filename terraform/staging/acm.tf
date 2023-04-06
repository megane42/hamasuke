resource "aws_acm_certificate" "this" {
  domain_name       = "stg.fukusuke.giftee.biz"
  validation_method = "DNS"

  # https://giftee-inc.slack.com/archives/CCWRVFG4R/p1591072506419600
  lifecycle {
    create_before_destroy = true
  }
}
