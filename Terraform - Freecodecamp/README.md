# Terraform FreeCodeCamp Examples

This folder contains a Terraform AWS networking example. The configuration creates a VPC, internet gateway, route table, subnet, security group, network interface, Elastic IP, and Ubuntu EC2 instance.

## Prerequisites

- Terraform installed
- An AWS account and permissions to create the resources in `main.tf`
- AWS credentials configured through the AWS CLI, environment variables, or another supported credential provider

The current `main.tf` contains hard-coded AWS credentials. Rotate those credentials immediately and remove them from the file before using this example. Never commit access keys to source control.

## Run

From this directory:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

When finished, destroy the resources to avoid ongoing AWS charges:

```bash
terraform destroy
```

The configuration uses the `us-east-1` region, a `t2.micro` instance, and an existing EC2 key pair named `main-key`. Update those values for your account before applying.

## State

Terraform state files are present in this learning folder. Treat state as sensitive because it can contain infrastructure details and secrets. For shared work, use a remote encrypted backend with locking.
