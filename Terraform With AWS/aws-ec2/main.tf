terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

provider "aws" {
  region=var.region
}

resource "aws_instance" "myserver"{
  ami="ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"

  tags = {
    Name="SampleFirstServer"
  }
}