data "aws_ami" "ubuntu-18" {
  most_recent = true
  owners      = [var.ubuntu_account_number]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_vpc" "get_my_vpc_info" {
  filter {
    name = "tag:Name"
    values = ["prod-vpc"]
  }
}

data "aws_security_group" "get_my_first_sg_info" {
  filter {
    name = "tag:Name"
    values = ["my-first-security-group"]
  }
}

data "aws_subnet" "get_my_first_public_subnet_info" {
  filter {
    name = "tag:Name"
    values = ["subnet-pub"]
  }
}