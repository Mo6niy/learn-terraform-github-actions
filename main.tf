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

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_object" "content" {
  for_each = fileset("content/", "*")
  bucket   = aws_s3_bucket.lambda_bucket.id
  key      = each.value
  source   = "content/${each.value}"
  etag     = filemd5("content/${each.value}")
}