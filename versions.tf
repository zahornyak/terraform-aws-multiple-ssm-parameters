terraform {
  required_version = ">= 1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.37"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4"
    }
  }
}
