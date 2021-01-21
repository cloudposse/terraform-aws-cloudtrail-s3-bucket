provider "aws" {
  region = var.region
}

module "cloudtrail_s3_bucket" {
  source = "../../"

  force_destroy            = true
  create_access_log_bucket = true

  context = module.this.context
}
