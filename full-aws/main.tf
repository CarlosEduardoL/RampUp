# Provider setup #
terraform {
  required_providers {
    aws = {
      source  = "aws"
      version = "3.50.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
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

data "aws_subnet" "public_subnet_2" {
  id = var.public_subnet_2_id
}

data "aws_subnet" "private_subnet_1" {
  id = var.private_subnet_1_id
}

data "aws_subnet" "private_subnet_2" {
  id = var.private_subnet_2_id
}

data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

data "github_ip_ranges" "github_ranges" {}