terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.3"
    }
     aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}

