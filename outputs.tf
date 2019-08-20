output "bucket_domain_name" {
  value       = "${var.enabled == "true" ? join("", aws_s3_bucket.default.*.bucket_domain_name) : ""}"
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = "${var.enabled == "true" ? join("", aws_s3_bucket.default.*.id) : ""}"
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = "${var.enabled == "true" ? join("", aws_s3_bucket.default.*.arn) : ""}"
  description = "Bucket ARN"
}

output "access_logs_bucket_id" {
  value       = "${module.access_logs_bucket.bucket_id}"
  description = "Access logs bucket name (aka ID)"
}

output "access_logs_bucket_arn" {
  value       = "${module.access_logs_bucket.bucket_arn}"
  description = "Access logs bucket ARN"
}

output "prefix" {
  value       = "${var.lifecycle_prefix}"
  description = "Prefix configured for lifecycle rules"
}

output "enabled" {
  value       = "${var.enabled}"
  description = "Is module enabled"
}
