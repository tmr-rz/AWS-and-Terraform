############
# Instances
############
resource "aws_instance" "my_instances" {
  count                       = var.number_of_nginx_instances
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.get_my_first_public_subnet_info.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [data.aws_security_group.get_my_first_sg_info.id]
  user_data                   = local.my-instance-userdata

  root_block_device {
    encrypted   = false
    volume_type = "gp2"
    volume_size = var.root_disk_size
  }

  ebs_block_device {
    encrypted   = true
    device_name = "web-server-ebs"
    volume_type = "gp2"
    volume_size = var.encrypted_disk_size
  }

  tags = {
    Name    = "${var.name_tag}-EC2-${count.index+1}"
    Purpose = var.purpose_tag
  }
}