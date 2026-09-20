terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

//create a bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = "website-bucket-for-hosting"
}

// add object t the bucket
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

//invoke public access
resource "aws_s3_bucket_public_access_block" "public_acess" {
  bucket = aws_s3_bucket.website_bucket.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

//policy add
resource "aws_s3_bucket_policy" "allow_access_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  policy = jsonencode(
    {
    "Version"= "2012-10-17",
    "Statement"= [
        {
            "Sid"= "PublicReadGetObject",
            "Effect"= "Allow",
            "Principal"= "*",
            "Action"= [
                "s3:GetObject"
            ],
            "Resource"= [
                "arn:aws:s3:::${aws_s3_bucket.website_bucket.bucket}/*"
            ]
        }
    ]
}
  )
}

resource "aws_s3_bucket_website_configuration" "webapp_conf" {
  bucket =  aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }
}

output "webb_url" {
  value = aws_s3_bucket_website_configuration.webapp_conf.website_endpoint
}