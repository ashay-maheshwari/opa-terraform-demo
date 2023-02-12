resource "aws_s3_bucket" "dms-bucket" {
  bucket_prefix = "dms-bucket-dev"
  versioning {
    enabled = true
  }
  acl = "private"

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Environment = "Dev"
    Costcenter = "Research"
  }
}

resource "aws_s3_bucket_versioning" "versioning_demo" {
  bucket = aws_s3_bucket.dms-bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
