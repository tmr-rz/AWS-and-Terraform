terraform {
  required_version = ">= 0.15.5"
  required_providers {
    aws = {
      version = "3.313.0"
    }
    tls = {
      version = "3.0.0"
    }
  }
}

provider "aws" {
  profile = "Administrator"
  region  = var.aws_region

  default_tags {
    tags = {
      Owner = var.owner_tag
      Purpose = var.purpose_tag
    }
  }
}
