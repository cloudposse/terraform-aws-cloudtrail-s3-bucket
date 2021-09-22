output "bucket_domain_name" {
  value       = module.s3_bucket.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = module.s3_bucket.bucket_id
  description = "Bucket ID"
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