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

data "aws_ami" "name" {
  most_recent = true
  owners = [ "amazon" ]
}

output "aws_ami_output" {
  value = data.aws_ami.name.id
}

data "aws_vpc" "name" {
  tags = {
    "default-vpc"= "global"
  }
}

output "aws_vpc_name" {
  value = data.aws_vpc.name.id
}