output "my_s3_bucket_versioning" {
  value = aws_s3_bucket_versioning.my_s3_bucket_versioning.versioning_configuration[0].status
}

output "my_iam_user_complete_details" {
  value = aws_iam_user.my_iam_user
}
