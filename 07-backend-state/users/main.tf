variable "application_name" {
  default = "07-backend-state"
}

variable "project_name" {
  default = "users"
}

variable "environment" {
  default = "dev"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    bucket         = "pisckitamadev-backend-state"
    key            = "dev/07-backend-state/users/backend-state"
    region         = "us-east-1"
    dynamodb_table = "pisckitamadev_locks"
    encrypt        = true
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_iam_user" "my_iam_user" {
  name = "${terraform.workspace}_my_iam_user_pisckitama"
}
