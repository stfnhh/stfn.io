terraform {
  required_version = "~> 1.11"

  backend "s3" {
    bucket       = "stfn-tf-state"
    key          = "stfnio.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.91"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = var.tags
  }
}
