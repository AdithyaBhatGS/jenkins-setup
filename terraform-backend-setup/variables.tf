variable "region" {
  type        = string
  description = "Region where the infrastructure will be deployed"
}

variable "bkt_name" {
  type        = string
  description = "Represents the bucket name"
}

variable "tags_for_s3" {
  type        = map(string)
  description = "Represents the tag associated with the s3 bucket"
}


variable "version_status" {
  type        = string
  description = "Represents the versioning status"
}

variable "sse_algorithm_type" {
  type        = string
  description = "Represents the sse algorithm type"
}

variable "dynamodb_table_name" {
  type        = string
  description = "Represents the name of the dynamodb table"
}

variable "billing_mode" {
  type        = string
  description = "Represents the billing mode for the table"
}

variable "hash_key_name" {
  type        = string
  description = "Name of the hash key"
}

variable "tags_for_dynamoDB" {
  type        = map(string)
  description = "Represents the tag associated with the dynamoDB table"
}

variable "lifecycle_id" {
  type        = string
  description = "Represents the id associated with lifecycle id"
}

variable "lifecycle_status" {
  type        = string
  description = "Represents the status of the id"
}

variable "lifecycle_days" {
  type        = string
  description = "Represents the expiration days"
}
