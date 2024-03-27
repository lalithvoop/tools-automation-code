terraform {
  backend "s3" {
    bucket = "vsltfbucket"
    key    = "tools/state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}