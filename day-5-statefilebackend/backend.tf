terraform {
  backend "s3" {
    bucket = "madnhghdghdjkasds"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
