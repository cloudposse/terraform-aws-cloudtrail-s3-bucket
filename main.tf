module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.3"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  name       = "${var.name}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
  enabled    = "${var.enabled}"
}

module "access_logs_bucket" {
  source = "git::https://github.com/cloudposse/terraform-aws-s3-log-storage.git?ref=tags/0.4.1"

  enabled = "${var.enabled}"

  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  name       = "${var.name}"
  delimiter  = "${var.delimiter}"
  attributes = "${concat(list("access", "logging"), var.attributes)}"
  tags       = "${var.tags}"

  region = "${var.region}"

  acl = "${var.access_logs_acl}"

  force_destroy = "${var.access_logs_force_destroy}"

  versioning_enabled = "${var.access_logs_versioning_enabled}"

  lifecycle_rule_enabled = "${var.access_logs_lifecycle_rule_enabled}"
  lifecycle_prefix       = "${var.access_logs_lifecycle_prefix}"
  lifecycle_tags         = "${var.access_logs_lifecycle_tags}"

  noncurrent_version_expiration_days = "${var.access_logs_noncurrent_version_expiration_days}"
  noncurrent_version_transition_days = "${var.access_logs_noncurrent_version_transition_days}"

  standard_transition_days = "${var.access_logs_standard_transition_days}"
  glacier_transition_days  = "${var.access_logs_glacier_transition_days}"
  expiration_days          = "${var.access_logs_expiration_days}"

  sse_algorithm      = "${var.access_logs_sse_algorithm}"
  kms_master_key_arn = "${var.access_logs_kms_master_key_arn}"
}

data "aws_iam_policy_document" "default" {
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
      "arn:aws:s3:::${module.label.id}",
    ]
  }

  statement {
    sid = "AWSCloudTrailWrite"

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com", "cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${module.label.id}/*",
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

resource "aws_s3_bucket" "default" {
  count         = "${var.enabled == "true" ? 1 : 0}"
  bucket        = "${module.label.id}"
  acl           = "${var.acl}"
  region        = "${var.region}"
  force_destroy = "${var.force_destroy}"
  policy        = "${data.aws_iam_policy_document.default.json}"

  versioning {
    enabled = "${var.versioning_enabled}"
  }

  lifecycle_rule {
    id      = "${module.label.id}"
    enabled = "${var.lifecycle_rule_enabled}"

    prefix = "${var.lifecycle_prefix}"
    tags   = "${var.lifecycle_tags}"

    noncurrent_version_expiration {
      days = "${var.noncurrent_version_expiration_days}"
    }

    noncurrent_version_transition {
      days          = "${var.noncurrent_version_transition_days}"
      storage_class = "GLACIER"
    }

    transition {
      days          = "${var.standard_transition_days}"
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = "${var.glacier_transition_days}"
      storage_class = "GLACIER"
    }

    expiration {
      days = "${var.expiration_days}"
    }
  }

  # https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html
  # https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#enable-default-server-side-encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "${var.sse_algorithm}"
        kms_master_key_id = "${var.kms_master_key_arn}"
      }
    }
  }

  logging {
    target_bucket = "${module.access_logs_bucket.bucket_id}"
  }

  tags = "${module.label.tags}"
}
