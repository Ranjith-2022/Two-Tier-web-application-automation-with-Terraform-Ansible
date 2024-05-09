output "s3_teambucket" {
  value = aws_s3_bucket.teambucket[*].bucket
}

output "s3_statebucket" {
  value = aws_s3_bucket.statebucket[*].bucket
}