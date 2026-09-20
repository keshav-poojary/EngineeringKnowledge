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

//Count

resource "aws_instance" "myserver"{
  count = 2
  ami="ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"

  tags = {
    Name="SampleFirstServer-${count.index}"
  }
}

//for each with list

variable "servers" {
  type = list(string)
  default = [ "web-server","db-server","backend" ]
}

resource "aws_instance" "myserver-apps"{
  for_each = toset(var.servers)
  ami="ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"

  tags = {
    Name="SampleFirstServer-${each.key}"
  }
}

//for each with maps

variable "serversapp" {
  type = map(string)
  default = {
    web-server="t2.micro",
    db-server="t3.micro",
    backend="t2.micro"
  }
}

resource "aws_instance" "myserver-appss"{
  for_each = var.serversapp
  ami="ami-0ae8f15ae66fe8cda"
  instance_type = each.value

  tags = {
    Name="SampleFirstServer-${each.key}+${each.value}"
  }
}  