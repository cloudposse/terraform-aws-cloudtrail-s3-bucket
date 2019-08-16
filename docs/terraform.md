## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acl | Canned ACL to apply to the S3 bucket | string | `log-delivery-write` | no |
| attributes | Additional attributes (e.g. `logs`) | list | `<list>` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| enabled | Set to `false` to prevent the module from creating any resources | string | `true` | no |
| expiration_days | Number of days after which to expunge the objects | string | `90` | no |
| force_destroy | A boolean that indicates the bucket can be destroyed even if it contains objects. These objects are not recoverable | string | `false` | no |
| glacier_transition_days | Number of days after which to move the data to the glacier storage tier | string | `60` | no |
| kms_master_key_arn | The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms | string | `` | no |
| lifecycle_prefix | Prefix filter. Used to manage object lifecycle events | string | `` | no |
| lifecycle_rule_enabled | Enable lifecycle events on this bucket | string | `true` | no |
| lifecycle_tags | Tags filter. Used to manage object lifecycle events | map | `<map>` | no |
| logs_acl | Canned ACL to apply to the logs S3 bucket | string | `private` | no |
| logs_expiration_days | Number of days after which to expunge the objects for logs s3 bucket | string | `90` | no |
| logs_force_destroy | A boolean that indicates the logs bucket can be destroyed even if it contains objects. These objects are not recoverable | string | `false` | no |
| logs_glacier_transition_days | Number of days after which to move the data to the glacier storage tier for logs s3 bucket | string | `60` | no |
| logs_kms_master_key_arn | The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms for logs s3 bucket | string | `` | no |
| logs_lifecycle_prefix | Prefix filter for logs s3 bucket. Used to manage object lifecycle events | string | `` | no |
| logs_lifecycle_rule_enabled | Enable lifecycle events on this logs bucket | string | `true` | no |
| logs_lifecycle_tags | Tags filter for logs s3 bucket. Used to manage object lifecycle events | map | `<map>` | no |
| logs_noncurrent_version_expiration_days | Specifies when noncurrent object versions expire for logs s3 bucket | string | `90` | no |
| logs_noncurrent_version_transition_days | Specifies when noncurrent object versions transition for logs s3 bucket | string | `30` | no |
| logs_sse_algorithm | The server-side encryption algorithm to use. Valid values are AES256 and aws:kms for logs s3 bucket | string | `AES256` | no |
| logs_standard_transition_days | Number of days to persist in the standard storage tier before moving to the infrequent access tier for logs s3 bucket | string | `30` | no |
| logs_versioning_enabled | A state of versioning logs bucket. Versioning is a means of keeping multiple variants of an object in the same bucket | string | `true` | no |
| name | Name  (e.g. `app` or `cluster`) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| noncurrent_version_expiration_days | Specifies when noncurrent object versions expire | string | `90` | no |
| noncurrent_version_transition_days | Specifies when noncurrent object versions transition | string | `30` | no |
| region | AWS Region for S3 bucket | string | `us-east-1` | no |
| sse_algorithm | The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | string | `AES256` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| standard_transition_days | Number of days to persist in the standard storage tier before moving to the infrequent access tier | string | `30` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |
| versioning_enabled | A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket | string | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_arn | Bucket ARN |
| bucket_domain_name | FQDN of bucket |
| bucket_id | Bucket Name (aka ID) |
| enabled | Is module enabled |
| prefix | Prefix configured for lifecycle rules |

