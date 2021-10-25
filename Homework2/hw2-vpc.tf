#Create VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
    Name = "production"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id
}

# Create a subnet-public
resource "aws_subnet" "subnet-pub" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.prod-vpc.id
  availability_zone = "us-east-1"

  tags = {
    Name = "public-subnet"
  }
}
# Create a subnet-private
resource "aws_subnet" "subnet-pr" {
  cidr_block = "10.0.100.0/24"
  vpc_id     = aws_vpc.prod-vpc.id
  availability_zone = "us-east-1"

  tags = {
    Name = "private-subnet"
  }
}

# Create route table - public
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw.id
    },
    {
      ipv6_cidr_block        = "::/0"
      egress_only_gateway_id = aws_internet_gateway.gw.id
    }
  ]
  tags = {
    Name = "prod"
  }
}

#Route table association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-pub.id
  route_table_id = aws_route_table.prod-route-table.id
}

# Create NAT gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.one.id
  subnet_id     = aws_subnet.subnet-pub.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

# Create route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.nat-gw.id
    },
    {
      ipv6_cidr_block        = "::/0"
      egress_only_gateway_id = aws_nat_gateway.nat-gw.id
    }
  ]
  tags = {
    Name = "private"
  }
}

#Private route table association
resource "aws_route_table_association" "a-pr" {
  subnet_id      = aws_subnet.subnet-pr.id
  route_table_id = aws_route_table.private-route-table.id
}

#Create a security group
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.prod-vpc.id

    ingress {
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "allow_web"
  }
}

# Allow network interface
resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-pub.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]
}

# Assign EIP
resource "aws_eip" "one" {
  vpc      = true
  network_interface = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.gw]
}
