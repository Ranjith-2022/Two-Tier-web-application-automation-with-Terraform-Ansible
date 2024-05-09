provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "teambucket" {
  count         = length(var.env)
  bucket        = "${var.env[count.index]}-images-acs730-shadowy-inspiration"
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket" "statebucket" {
  count         = length(var.env)
  bucket        = "${var.env[count.index]}-state-acs730-shadowy-inspiration"
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_ownership_controls" "bucketowner" {
  count  = length(var.env)
  bucket = aws_s3_bucket.teambucket[count.index].id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bucketaccess" {
  count  = length(var.env)
  bucket = aws_s3_bucket.teambucket[count.index].id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucketacl" {
  count = length(var.env)
  depends_on = [
    aws_s3_bucket_ownership_controls.bucketowner,
    aws_s3_bucket_public_access_block.bucketaccess,
  ]

  bucket = aws_s3_bucket.teambucket[count.index].id
  acl    = "public-read"
}