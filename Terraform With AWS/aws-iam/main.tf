terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  users_data = yamldecode(file("./users.yaml")).users
}

output "users" {
  value = local.users_data
}

# Create IAM users
resource "aws_iam_user" "iam_user" {
  for_each = toset(local.users_data[*].username)
  name     = each.key
}

# Create IAM login profile for each user
resource "aws_iam_user_login_profile" "login_profile" {
  for_each = aws_iam_user.iam_user
  user     = each.key
  password_reset_required = false

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

# Define an IAM policy
resource "aws_iam_policy" "policy" {
  name        = "ExamplePolicy"
  description = "A test policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
         Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to each user
resource "aws_iam_user_policy_attachment" "test-attach" {
  for_each   = aws_iam_user.iam_user
  user       = each.key
  policy_arn = aws_iam_policy.policy.arn
}

# Output the IAM usernames and passwords for reference
output "user_credentials" {
  value = {
    for user, profile in aws_iam_user_login_profile.login_profile : user => {
      username = profile.user
    }
  }
}
