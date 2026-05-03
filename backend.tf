terraform {
  backend "s3" {
    bucket         = "tf-state-github-bkt"
    key            = "static-site/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state-lock"
    encrypt        = true
  }
}