data "terraform_remote_state" "base" {
  backend = "s3"

  config = {
    region         = "ap-northeast-1"
    dynamodb_table = "hamasuke-terraform-tfstate-lock"
    bucket         = "hamasuke-terraform-tfstate"
    key            = "staging.tfstate"
    encrypt        = true
  }
}
