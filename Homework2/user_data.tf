#User data
locals {
  my-instance-userdata = <<USERDATA
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable nginx
sed -i "s/nginx/Welcome to Grandpa's Whiskey/g" /var/www/html/index.nginx-debian.html
sed -i '15,23d' /var/www/html/index.nginx-debian.html
service nginx restart
USERDATA
}