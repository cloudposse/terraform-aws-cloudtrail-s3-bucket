variable "namespace" {
  description = "Namespace (e.g. `cp` or `cloudposse`)"
  type        = string
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = string
}

variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = string
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `logs`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "acl" {
  type        = string
  description = "Canned ACL to apply to the S3 bucket"
  default     = "log-delivery-write"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region for S3 bucket"
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

variable "kms_master_key_id" {
  description = "The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms"
  default     = ""
}

