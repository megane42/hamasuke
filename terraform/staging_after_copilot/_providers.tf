provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      terraform = true
      service   = local.service
      env       = local.env
    }
  }
}
