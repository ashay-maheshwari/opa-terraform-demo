resource "aws_s3_bucket" "b" {
  bucket_prefix = "dms-bucket-dev"
  versioning {
    enabled = true
  }
  acl = "private"
  force_destroy = true
  
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Environment = "Dev"
    Costcenter = "Research"
  }
}