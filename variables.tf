variable "enabled" {
  description = "Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

variable "namespace" {
  description = "Namespace (e.g. `cp` or `cloudposse`)"
  type        = "string"
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = "string"
}

variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = "string"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `logs`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "region" {
  type        = "string"
  default     = "us-east-1"
  description = "AWS Region for S3 bucket"
}

variable "acl" {
  type        = "string"
  description = "Canned ACL to apply to the S3 bucket"
  default     = "log-delivery-write"
}

variable "force_destroy" {
  description = "A boolean that indicates the bucket can be destroyed even if it contains objects. These objects are not recoverable"
  default     = "false"
}

variable "versioning_enabled" {
  description = "A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket"
  default     = "true"
}

variable "lifecycle_rule_enabled" {
  description = "Enable lifecycle events on this bucket"
  default     = "true"
}

variable "lifecycle_prefix" {
  description = "Prefix filter. Used to manage object lifecycle events"
  default     = ""
}

variable "lifecycle_tags" {
  description = "Tags filter. Used to manage object lifecycle events"
  default     = {}
}

variable "noncurrent_version_expiration_days" {
  description = "Specifies when noncurrent object versions expire"
  default     = "90"
}

variable "noncurrent_version_transition_days" {
  description = "Specifies when noncurrent object versions transition"
  default     = "30"
}

variable "standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
  default     = "30"
}

variable "glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier"
  default     = "60"
}

variable "expiration_days" {
  description = "Number of days after which to expunge the objects"
  default     = "90"
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
  default     = "AES256"
}

variable "kms_master_key_arn" {
  description = "The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms"
  default     = ""
}

variable "logs_acl" {
  type        = "string"
  description = "Canned ACL to apply to the logs S3 bucket"
  default     = "private"
}

variable "logs_force_destroy" {
  description = "A boolean that indicates the logs bucket can be destroyed even if it contains objects. These objects are not recoverable"
  default     = "false"
}

variable "logs_versioning_enabled" {
  description = "A state of versioning logs bucket. Versioning is a means of keeping multiple variants of an object in the same bucket"
  default     = "true"
}

variable "logs_lifecycle_rule_enabled" {
  description = "Enable lifecycle events on this logs bucket"
  default     = "true"
}

variable "logs_lifecycle_prefix" {
  description = "Prefix filter for logs s3 bucket. Used to manage object lifecycle events"
  default     = ""
}

variable "logs_lifecycle_tags" {
  description = "Tags filter for logs s3 bucket. Used to manage object lifecycle events"
  default     = {}
}

variable "logs_noncurrent_version_expiration_days" {
  description = "Specifies when noncurrent object versions expire for logs s3 bucket"
  default     = "90"
}

variable "logs_noncurrent_version_transition_days" {
  description = "Specifies when noncurrent object versions transition for logs s3 bucket"
  default     = "30"
}

variable "logs_standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier for logs s3 bucket"
  default     = "30"
}

variable "logs_glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier for logs s3 bucket"
  default     = "60"
}

variable "logs_expiration_days" {
  description = "Number of days after which to expunge the objects for logs s3 bucket"
  default     = "90"
}

variable "logs_sse_algorithm" {
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms for logs s3 bucket"
  default     = "AES256"
}

variable "logs_kms_master_key_arn" {
  description = "The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms for logs s3 bucket"
  default     = ""
}
