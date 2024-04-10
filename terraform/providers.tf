provider "aws" {
  region  = "us-east-1"
  profile = "personal"

  default_tags {
    tags = {
      Owner       = "Xitry"
      Environment = "Development"
    }
  }
}