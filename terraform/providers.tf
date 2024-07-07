terraform {
  required_version = "~> 1.8"
  required_providers {
    kubernetes = {
      version = "~> 2.31.0"
    }
    helm = {
      version = "~> 2.14.0"
    }
    null = {
      version = "~> 3.2.0"
    }
  }
}
