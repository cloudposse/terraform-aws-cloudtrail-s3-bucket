output "bucket_domain_name" {
  value       = module.s3_bucket.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = module.s3_bucket.bucket_id
  description = "Bucket ID"
  #
  # Ensure the bucket is fully configured before allowing any use of `bucket_id`.
  #
  # Although undocumented, `depends_on` is allowed in an output block.
  # The `bucket_id` is available before the bucket is fully configured 
  # with policies, versioning, lifecycle, etc. However, all that 
  # needs to happen before the bucket can be used as a destination for 
  # a CloudTrail. While the documented way to ensure this would be
  # for the user of this module to add a `depends_on` that depends
  # on this module, since this is such a common need, and since
  # we can depend on a submodule here rather than this entire module,
  # we add the `depends_on` block here.
  depends_on = [
    module.s3_bucket
  ]
}

output "bucket_arn" {
  value       = module.s3_bucket.bucket_arn
  description = "Bucket ARN"
}

output "prefix" {
  value       = module.s3_bucket.prefix
  description = "Prefix configured for lifecycle rules"
}

output "bucket_notifications_sqs_queue_arn" {
  value       = module.s3_bucket.bucket_notifications_sqs_queue_arn
  description = "Notifications SQS queue ARN"
}
