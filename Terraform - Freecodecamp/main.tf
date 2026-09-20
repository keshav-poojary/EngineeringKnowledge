provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "vpc-prod" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "production"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "ig-prod" {
  vpc_id = aws_vpc.vpc-prod.id

  tags = {
    Name = "production-ig"
  }
}

# Create a Custom Route Table
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc-prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-prod.id
  }

  tags = {
    Name = "production"
  }
}

# Create Subnet
resource "aws_subnet" "prod-subnet" {
  vpc_id            = aws_vpc.vpc-prod.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "production-subnet"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.prod-subnet.id
  route_table_id = aws_route_table.route-table.id
}

# Create a Security Group for Ports 80 (HTTP), 443 (HTTPS), 22 (SSH)
resource "aws_security_group" "allow_web_traffic" {
  name        = "allow_traffic"
  description = "Allow web traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc-prod.id

  tags = {
    Name = "allow_traffic"
  }
}

resource "aws_security_group_rule" "allow_https_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.allow_web_traffic.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.allow_web_traffic.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.allow_web_traffic.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_traffic_ipv4" {
  type              = "egress"
  security_group_id = aws_security_group.allow_web_traffic.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # All protocols
  cidr_blocks       = ["0.0.0.0/0"]
}

# Create a Network Interface
resource "aws_network_interface" "network-interface" {
  subnet_id       = aws_subnet.prod-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web_traffic.id]
}

# Assign an Elastic IP to the Network Interface
resource "aws_eip" "elastic-ip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.network-interface.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.ig-prod]
}

# Create an Ubuntu Server
resource "aws_instance" "ubuntu-server" {
  ami           = "ami-04a81a99f5ec58529" # Update this with the latest Ubuntu AMI ID from AWS Marketplace
  instance_type = "t2.micro"
  key_name      = "main-key" # Ensure you have a key pair created in the specified region
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.network-interface.id
  }

  tags = {
    Name = "production-ubuntu-server"
  }
}

# Outputs
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_eip.elastic-ip.public_ip
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ubuntu-server.id
}
