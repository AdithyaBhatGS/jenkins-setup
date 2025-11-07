output "backend_config" {
  value = {
    bucket_name         = aws_s3_bucket.terraform_state.arn
    dynamodb_table_name = aws_dynamodb_table.lock_table.arn
  }
}
