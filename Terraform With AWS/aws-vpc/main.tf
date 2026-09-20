terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

provider "aws" {
  region="us-east-1"
} 

#Create a VPC

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="my-vpc"
  }
}

#Create a Public & Private Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name="public subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name="private subnet"
  }
}

#internet gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
}

#route define
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route  {
    cidr_block="0.0.0.0/0"
    gateway_id=aws_internet_gateway.my-igw.id
  }
}

#route asssociation

resource "aws_route_table_association" "my-table-association" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id = aws_subnet.public_subnet.id
}

#EC2
resource "aws_instance" "my-server"{
  ami="ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_subnet.id
  tags = {
    Name="FirstServer"
  }
}
