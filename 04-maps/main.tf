variable "users" {
  default = {
    piscki : { city : "Bandung", departement : "IT" },
    pratama : { city : "Garut", departement : "FInance" },
    feby : { city : "Depok", departement : "HRD" },
  }
}

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
  region  = "us-west-2"
}

// using for_each for no replacing name
resource "aws_iam_user" "my_iam_user" {
  for_each = var.users
  name     = each.key
  tags = {
    city : each.value.city
    departement : each.value.departement
  }
}
