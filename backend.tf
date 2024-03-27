terraform {
  backend "s3" {
    bucket = "vsltfbucket"
    key    = "tools/state"
    region = "us-east-1"
  }
}