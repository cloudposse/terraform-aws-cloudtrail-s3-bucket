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

  enable_logging                = var.enable_logging
  enable_log_file_validation    = var.enable_log_file_validation
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  is_organization_trail         = var.is_organization_trail
  s3_bucket_name                = module.cloudtrail_s3_bucket.bucket_id

  context = module.this.context
}
