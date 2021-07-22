# Provider setup #
terraform {
  required_providers {
    aws = {
      source  = "aws"
      version = "3.50.0"
    }
  }
}

## Fetch existing aws resources
data "aws_vpc" "ramp_up_vpc" {
  id = var.vpc_id
}

data "aws_subnet" "public_subnet_1" {
  id = var.public_subnet_1_id
}

data "aws_subnet" "private_subnet_1" {
  id = var.private_subnet_1_id
}