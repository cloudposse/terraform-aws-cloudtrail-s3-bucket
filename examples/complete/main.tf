provider "aws" {
  region = var.region
}

module "cloudtrail_s3_bucket" {
  source = "../../"

  force_destroy = true

  context = module.this.context
}
