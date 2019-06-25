output "bucket_domain_name" {
  value       = module.cloudtrail_s3_bucket.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = module.cloudtrail_s3_bucket.bucket_id
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = module.cloudtrail_s3_bucket.bucket_arn
  description = "Bucket ARN"
}
