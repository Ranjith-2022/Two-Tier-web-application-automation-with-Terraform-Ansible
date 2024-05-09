terraform {
  backend "s3" {
    bucket = "staging-state-acs730-shadowy-inspiration"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}