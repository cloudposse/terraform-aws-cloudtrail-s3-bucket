module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.3"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  name       = "${var.name}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
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
      identifiers = ["cloudtrail.amazonaws.com"]
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

module "s3_bucket" {
  source                 = "git::https://github.com/cloudposse/terraform-aws-s3-log-storage.git?ref=tags/0.2.0"
  namespace              = "${var.namespace}"
  stage                  = "${var.stage}"
  name                   = "${var.name}"
  region                 = "${var.region}"
  acl                    = "${var.acl}"
  policy                 = "${data.aws_iam_policy_document.default.json}"
  force_destroy          = "false"
  versioning_enabled     = "true"
  lifecycle_rule_enabled = "false"
  delimiter              = "${var.delimiter}"
  attributes             = "${var.attributes}"
  tags                   = "${var.tags}"
}
