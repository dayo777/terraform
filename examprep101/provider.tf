terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # backend "remote" {
  #   hostname = "app.terraform.io"
  #   organization = "org-Kamps"
  #   workspaces {
  #     name = "ws-manufacturing"
  #   }
  # }
}

provider "aws" {
  region = "us-east-1"
}