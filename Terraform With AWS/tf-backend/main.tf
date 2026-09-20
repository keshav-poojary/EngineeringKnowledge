terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.0"
    }
  }
  backend "s3" {
    bucket = "demo-bucket-keshavpoojary22"
    key="state.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region="us-east-1"
}

resource "aws_instance" "myserver"{
  ami="ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"

  tags = {
    Name="SampleFirstServer"
  }
}