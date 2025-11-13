
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "Jenkins-Setup"
      Environment = "Dev"
      Terraform   = "true"
    }
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bkt_name

  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "bkt_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = var.version_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm_type
    }
  }
}


resource "aws_s3_bucket_public_access_block" "block_access_to_public" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_policy_for_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    id     = var.lifecycle_id
    status = var.lifecycle_status

    filter {
      prefix = ""
    }

    noncurrent_version_expiration {
      noncurrent_days = var.lifecycle_days
    }

  }
}

resource "aws_dynamodb_table" "lock_table" {
  name         = var.dynamodb_table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key_name

  attribute {
    name = var.hash_key_name
    type = "S"
  }

  tags = var.tags_for_dynamoDB
}

