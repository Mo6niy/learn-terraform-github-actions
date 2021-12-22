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
  bucket        = "test-ci-1234eqweadgffd"
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_object" "content" {
  for_each = fileset("content/", "*")
  bucket   = aws_s3_bucket.lambda_bucket.id
  key      = each.value
  source   = "content/${each.value}"
  etag     = filemd5("content/${each.value}")
}