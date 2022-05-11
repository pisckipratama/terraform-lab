variable "names" {
  default = ["danny", "piscki", "pratama", "feby"]
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
  # count    = length(var.names)
  # name     = var.names[count.index]
  for_each = toset(var.names)
  name     = each.value
}
