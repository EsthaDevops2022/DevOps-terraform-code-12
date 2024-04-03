terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.61.0"
    }
  }
}

provider "aws" {
  
  region = "us-east-1"
}

resource "aws_iam_group" "gp1" {
  name = "manager"
}

resource "aws_iam_user" "usr1" {
  name = "serge2024"
}