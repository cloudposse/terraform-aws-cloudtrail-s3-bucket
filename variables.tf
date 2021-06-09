variable "acl" {
  type        = string
  description = "The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services"
  default     = "log-delivery-write"
}

variable "policy" {
  type        = string
  description = "A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy"
  default     = ""
}

variable "lifecycle_prefix" {
  type        = string
  description = "Prefix filter. Used to manage object lifecycle events"
  default     = ""
}

variable "lifecycle_tags" {
  type        = map(string)
  description = "Tags filter. Used to manage object lifecycle events"
  default     = {}
}

variable "arn_format" {
  type        = string
  default     = "arn:aws"
  description = "ARN format to be used. May be changed to support deployment in GovCloud/China regions."
}

variable "force_destroy" {
  type        = bool
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
  default     = false
}

variable "lifecycle_rule_enabled" {
  type        = bool
  description = "Enable lifecycle events on this bucket"
  default     = true
}

variable "versioning_enabled" {
  type        = bool
  description = "A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket"
  default     = false
}

variable "noncurrent_version_expiration_days" {
  description = "Specifies when noncurrent object versions expire"
  default     = 90
}

variable "noncurrent_version_transition_days" {
  description = "Specifies when noncurrent object versions transitions"
  default     = 30
}

variable "standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
  default     = 30
}

variable "glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier"
  default     = 60
}

variable "enable_glacier_transition" {
  type        = bool
  default     = false
  description = "Glacier transition might just increase your bill. Set to false to disable lifecycle transitions to AWS Glacier."
}

variable "expiration_days" {
  description = "Number of days after which to expunge the objects"
  default     = 90
}

variable "abort_incomplete_multipart_upload_days" {
  type        = number
  default     = 5
  description = "Maximum time (in days) that you want to allow multipart uploads to remain in progress"
}

variable "sse_algorithm" {
  type        = string
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
  default     = "AES256"
}

variable "kms_master_key_arn" {
  type        = string
  description = "The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms"
  default     = ""
}

variable "block_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public access lists on the bucket"
}

variable "block_public_policy" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public policies on the bucket"
}

variable "ignore_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the ignoring of public access lists on the bucket"
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the restricting of making the bucket public"
}

variable "access_log_bucket_name" {
  type        = string
  default     = ""
  description = "Name of the S3 bucket where s3 access log will be sent to"
}

variable "create_access_log_bucket" {
  type        = bool
  default     = false
  description = "A flag to indicate if a bucket for s3 access logs should be created"
}

variable "allow_ssl_requests_only" {
  type        = bool
  default     = false
  description = "Set to `true` to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests"
}
