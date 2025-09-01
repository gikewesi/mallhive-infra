resource "aws_s3_bucket" "static_site" {
  bucket        = "microfrontend-s3"
  force_destroy = true

  tags = {
    Name        = "mallhive"
    Environment = "prod"
    Project     = "mallhive-frontend"
  }
}

resource "aws_s3_bucket_ownership_controls" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket                  = aws_s3_bucket.static_site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


