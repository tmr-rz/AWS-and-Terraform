variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "instance_type" {
  description = "The type of the ec2, for example - t2.medium"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  default     = "my-keypair-opsschool"
  description = "The key name of the Key Pair to use for the instance"
  type        = string
}

variable "ubuntu_account_number" {
  default = "099720109477"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "private_subnet" {
  type    = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "route_tables_names" {
  type    = list(string)
  default = ["public", "private-a", "private-b"]
}

variable "nginx_instances_count" {
  default = 2
}

variable "DB_instances_count" {
  default = 2
}

variable "nginx_root_disk_size" {
  description = "The size of the root disk"
  default = "10"
}

variable "nginx_encrypted_disk_size" {
  description = "The size of the secondary encrypted disk"
  default = "10"
}

variable "nginx_encrypted_disk_device_name" {
  description = "The name of the device of secondary encrypted disk"
  default = "xvdh"
}

variable "volumes_type" {
  description = "The type of all the disk instances in my project"
  default = "gp2"
}

variable "owner_tag" {
  description = "The owner tag will be applied to every resource in the project through the 'default variables' feature"
  default = "Ops-School"
  type    = string
}

variable "purpose_tag" {
  default = "Grampa's Whiskey"
  type    = string
}

