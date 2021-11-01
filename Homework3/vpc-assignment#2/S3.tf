data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-state-prod"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

module "s3_access_log" {
  source = "../modules/"
  name   = "s3-access-log"
}
