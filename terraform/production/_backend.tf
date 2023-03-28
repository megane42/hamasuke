terraform {
  backend "s3" {
    region         = "ap-northeast-1"
    dynamodb_table = "fukusuke-terraform-tfstate-lock"
    bucket         = "fukusuke-terraform-tfstate"
    key            = "production.tfstate"
    encrypt        = true
  }
}
