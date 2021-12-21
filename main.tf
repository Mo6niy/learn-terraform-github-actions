terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }

  }
  required_version = ">= 1.1.0"
}


provider "aws" {
  region = "us-west-1"
}



resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "test-ci-1234eqweadg"
  acl           = "private"
  force_destroy = true
}
