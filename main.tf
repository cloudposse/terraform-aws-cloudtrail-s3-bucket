
module "access_log_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name = "cloudtrail-access-log"

  context = module.this.context
}

module "s3_bucket" {
  source  = "cloudposse/s3-log-storage/aws"
  version = "0.28.0"
  enabled = module.this.enabled

  acl                = var.acl
  policy             = join("", data.aws_iam_policy_document.default.*.json)
  force_destroy      = var.force_destroy
  versioning_enabled = var.versioning_enabled

  sse_algorithm                = var.sse_algorithm
  kms_master_key_arn           = var.kms_master_key_arn
  block_public_acls            = var.block_public_acls
  block_public_policy          = var.block_public_policy
  ignore_public_acls           = var.ignore_public_acls
  restrict_public_buckets      = var.restrict_public_buckets
  access_log_bucket_name       = local.access_log_bucket_name
  allow_ssl_requests_only      = var.allow_ssl_requests_only
  bucket_notifications_enabled = var.bucket_notifications_enabled
  bucket_notifications_type    = var.bucket_notifications_type
  bucket_notifications_prefix  = var.bucket_notifications_prefix

  lifecycle_configuration_rules = [
    {
      enabled = true
      id      = "v2rule"

      abort_incomplete_multipart_upload_days = var.abort_incomplete_multipart_upload_days
      enable_glacier_transition              = var.enable_glacier_transition
      prefix                                 = var.lifecycle_prefix
      tags                                   = var.lifecycle_tags

      filter_and = null

      expiration = {
        days = var.expiration_days
      }

      noncurrent_version_expiration = {
        noncurrent_days = var.noncurrent_version_expiration_days
      }

      transition = [{
        days          = var.standard_transition_days
        storage_class = "STANDARD_IA"
        },
        {
          days          = var.glacier_transition_days
          storage_class = "GLACIER"
      }]

      noncurrent_version_transition = [{
        noncurrent_days = var.noncurrent_version_transition_days
        storage_class   = "ONEZONE_IA" # string/enum, one of GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR.
      }]
    }
  ]


  context = module.this.context
}

module "s3_access_log_bucket" {
  source  = "cloudposse/s3-log-storage/aws"
  version = "0.28.0"
  enabled = module.this.enabled && var.create_access_log_bucket

  acl                     = var.acl
  policy                  = ""
  force_destroy           = var.force_destroy
  versioning_enabled      = var.versioning_enabled
  sse_algorithm           = var.sse_algorithm
  kms_master_key_arn      = var.kms_master_key_arn
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  access_log_bucket_name  = ""
  allow_ssl_requests_only = var.allow_ssl_requests_only

  lifecycle_configuration_rules = [
    {
      enabled = true
      id      = "v2rule"

      abort_incomplete_multipart_upload_days = var.abort_incomplete_multipart_upload_days
      enable_glacier_transition              = var.enable_glacier_transition
      prefix                                 = var.lifecycle_prefix
      tags                                   = var.lifecycle_tags

      filter_and = null

      expiration = {
        days = var.expiration_days
      }

      noncurrent_version_expiration = {
        noncurrent_days = var.noncurrent_version_expiration_days
      }

      transition = [{
        days          = var.standard_transition_days
        storage_class = "STANDARD_IA"
        },
        {
          days          = var.glacier_transition_days
          storage_class = "GLACIER"
      }]

      noncurrent_version_transition = [{
        noncurrent_days = var.noncurrent_version_transition_days
        storage_class   = "ONEZONE_IA" # string/enum, one of GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR.
      }]
    }
  ]


  attributes = ["access-logs"]
  context    = module.this.context
}

data "aws_iam_policy_document" "default" {
  count       = module.this.enabled ? 1 : 0
  source_json = var.policy == "" ? null : var.policy

  statement {
    sid = "AWSCloudTrailAclCheck"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "${local.arn_format}:s3:::${module.this.id}",
    ]
  }

  statement {
    sid = "AWSCloudTrailWrite"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com", "config.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${local.arn_format}:s3:::${module.this.id}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}

data "aws_partition" "current" {}

locals {
  access_log_bucket_name = var.create_access_log_bucket == true ? module.s3_access_log_bucket.bucket_id : var.access_log_bucket_name
  arn_format             = "arn:${data.aws_partition.current.partition}"
}
