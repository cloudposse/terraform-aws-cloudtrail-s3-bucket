provider "aws" {
  region = var.region
}

module "cloudtrail_s3_bucket" {
  source = "../../"

  region        = var.region
  namespace     = var.namespace
  stage         = var.stage
  name          = var.name
  force_destroy = true
}
