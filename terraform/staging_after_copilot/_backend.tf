terraform {
  backend "s3" {
    region         = "ap-northeast-1"
    dynamodb_table = "hamasuke-terraform-tfstate-lock"
    bucket         = "hamasuke-terraform-tfstate"
    key            = "staging.after-copilot.tfstate"
    encrypt        = true
  }
}
