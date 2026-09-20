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

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket-keshavpoojary22"
}

resource "aws_s3_object" "data-object" {
  bucket =  aws_s3_bucket.demo-bucket.bucket
  source = "./myfile.txt"
  key = "mydata.txt"
}