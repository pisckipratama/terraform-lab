terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

// S3 Bucket
resource "aws_s3_bucket" "enterprise_backend_state" {
  bucket = "pisckitamadev-backend-state"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enterprise_backend_state_versioning" {
  bucket = aws_s3_bucket.enterprise_backend_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "enterprise_backend_state_encrypt" {
  bucket = aws_s3_bucket.enterprise_backend_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

// locking - Dynamo DB
resource "aws_dynamodb_table" "enterprise_backend_lock" {
  name         = "pisckitamadev_locks"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
