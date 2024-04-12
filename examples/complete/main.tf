provider "aws" {
  region = var.region
}

module "cloudtrail_s3_bucket" {
  source = "../../"

  force_destroy            = true
  create_access_log_bucket = true

  context = module.this.context
}

module "cloudtrail" {
  source  = "cloudposse/cloudtrail/aws"
  version = "0.23.0"

  is_multi_region_trail = false
  s3_bucket_name        = module.cloudtrail_s3_bucket.bucket_id

  context = module.this.context
}
