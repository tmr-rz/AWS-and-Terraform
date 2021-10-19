# Create instance1

resource "aws_instance" "nginx" {
  ami = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  key_name = "my-keypair-opsschool"

 connection {
   host        = self.private_ip
   agent       = true
   type        = "ssh"
   private_key = file(pathexpand("~/.ssh/id_rsa"))
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start",
      "sudo systemctl enable nginx",
      "echo <p1>Welcome to Grandpa's Whiskey</p1> | sudo tee /var/www/html/index.html"
      ]
    }
  tags = {
    Name = "web-server"
  }
}

# Attach EBS Volume

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sda1"
  volume_id   = aws_ebs_volume.ebs10.id
  instance_id = aws_instance.nginx.id
}

resource "aws_ebs_volume" "ebs10" {
  availability_zone = "us-east-1c"
  size              = 10
  encrypted = true
}


# Create instance2

resource "aws_instance" "nginx2" {
  ami = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  key_name = "my-keypair-opsschool"

 connection {
   host        = self.private_ip
   agent       = true
   type        = "ssh"
   private_key = file(pathexpand("~/.ssh/id_rsa"))
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start",
      "sudo systemctl enable nginx",
      "echo <p1>Welcome to Grandpa's Whiskey</p1> | sudo tee /var/www/html/index.html"
      ]
    }
  tags = {
    Name = "web-server"
  }
}

# Attach EBS Volume

resource "aws_volume_attachment" "ebs_att2" {
  device_name = "/dev/sda1"
  volume_id   = aws_ebs_volume.ebs10-2.id
  instance_id = aws_instance.nginx2.id
}

resource "aws_ebs_volume" "ebs10-2" {
  availability_zone = "us-east-1c"
  size              = 10
  encrypted = true
}
