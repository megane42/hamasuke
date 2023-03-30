resource "aws_wafv2_ip_set" "office_ips" {
  name               = "office-ips-${local.service}-${local.env}"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses = [
    # 五反田オフィス & VPN の IP のみ許可
    "18.178.71.86/32",
    "52.69.136.154/32",
    "220.151.101.122/32",
  ]
}

resource "aws_wafv2_web_acl" "this" {
  name        = "wafv2-web-acl-${local.service}-${local.env}"
  description = "AWS WAF v2"
  scope       = "REGIONAL"

  visibility_config {
    sampled_requests_enabled   = true
    cloudwatch_metrics_enabled = true
    metric_name                = "wafv2-web-acl-${local.service}-${local.env}"
  }

  default_action {
    block {}
  }

  rule {
    name     = "allow-from-office-ip-${local.service}-${local.env}"
    priority = 0

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.office_ips.arn
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "allow-from-office-ip-${local.service}-${local.env}"
    }
  }
}

resource "aws_wafv2_web_acl_association" "this" {
  resource_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:368771686176:loadbalancer/app/fukus-Publi-1O8NJR9CJIHMZ/1ca25f86c0709fd4" # copilot で作った ALB (stg) の ARN
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}

resource "aws_wafv2_web_acl_logging_configuration" "this" {
  log_destination_configs = [aws_cloudwatch_log_group.aws_waf_logs.arn]
  resource_arn            = aws_wafv2_web_acl.this.arn
}

resource "aws_cloudwatch_log_group" "aws_waf_logs" {
  name = "aws-waf-logs-${local.service}-${local.env}"
  retention_in_days = 365
}
