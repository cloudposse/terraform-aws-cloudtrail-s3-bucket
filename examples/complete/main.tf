provider "aws" {
  region = var.region
}

module "cloudtrail_s3_bucket" {
  source  = "cloudposse/cloudtrail-s3-bucket/aws"
  version = "0.26.0"

  force_destroy = true

  context = module.this.context
}
