variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "instance_type" {
  description = "The type of the nginx EC2, t2.micro"
  type        = string
  default     = "t2.micro"
}

variable "number_of_nginx_instances" {
  description = "The number of nginx instances to create"
  default = "2"
}

variable "root_disk_size" {
  description = "The size of the root disk"
  default = "10"
}

variable "encrypted_disk_size" {
  description = "The size of the secondary encrypted disk"
  default = "10"
}

variable "key_name" {
  default     = "my-keypair-opsschool"
  description = "my key pair"
  type        = string
}

variable "owner_tag" {
  description = "The owner tag will be applied to every resource in the project through the 'default variables' feature"
  default = "tmrz-Administrator"
  type    = string
}

variable "purpose_tag" {
  default = "web-sever for Whiskey"
  type    = string
}

variable "name_tag" {
  default = "Nginx"
  type    = string
}

variable "ubuntu_account_number" {
  default = "self"
  type    = string
}

variable "number_of_db_instances" {
  description = "The number of db instances to create"
  default = "2"
}