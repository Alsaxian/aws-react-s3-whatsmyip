terraform {
  backend "s3" {
    bucket = "xitry-terraform-state"
    key    = "aws-react-s3-whatsmyip/terraform.tfstate"
    region = "us-east-1"
  }
}