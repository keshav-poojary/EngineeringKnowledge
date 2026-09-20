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

resource "aws_instance" "server" {
  ami="ami-0ae8f15ae66fe8cda"
  instance_type = var.instance_type

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    "Name"="my-ec2-server"
  }
}