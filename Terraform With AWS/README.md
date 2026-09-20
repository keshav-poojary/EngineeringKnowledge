# Terraform With AWS

This folder is a collection of focused Terraform and AWS practice projects. Each subfolder is an independent Terraform root module with its own configuration and state.

## Examples

| Folder                | Focus                                                               |
| --------------------- | ------------------------------------------------------------------- |
| `aws-datasources`     | AWS data source examples                                            |
| `aws-ec2`             | EC2 instances and outputs                                           |
| `aws-iam`             | IAM users, login profiles, and policy attachments from `users.yaml` |
| `aws-modules`         | Terraform module usage                                              |
| `aws-multi-resources` | Multiple AWS resources in one configuration                         |
| `aws-nginx-http`      | Nginx and HTTP infrastructure                                       |
| `aws-operators-exp`   | Terraform operators and expressions                                 |
| `aws-own-module`      | A local reusable module                                             |
| `aws-s3`              | S3 bucket and object resources                                      |
| `aws-tf-variables`    | Terraform variables and `.tfvars` values                            |
| `aws-vpc`             | VPC, subnet, routing, and EC2 resources                             |
| `static-website-host` | Static website hosting resources                                    |
| `tf-backend`          | Terraform backend configuration                                     |

## Prerequisites

- Terraform installed
- AWS CLI credentials configured without committing secrets
- An AWS account with permissions required by the selected example

Some examples use fixed region, AMI, bucket, key-pair, or resource names. Review the files before applying them in your account.

## Run an example

Choose one subfolder and run Terraform from that folder. Do not run these commands from this collection's root because the examples are independent:

```bash
cd aws-vpc
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

When finished with an example:

```bash
terraform destroy
```

Repeat the same workflow from another subfolder as needed. Keep each example's state isolated.

## Security and state

Never commit AWS access keys, passwords, private keys, or sensitive Terraform state. The IAM example creates login profiles, and Terraform state may contain sensitive infrastructure details. Prefer environment-based credentials and a remote encrypted backend for shared work.
