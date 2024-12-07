resource "aws_s3_bucket" "test_aws_s3_bucket" {
  bucket = "dayo777-bucket"
  tags = {
    Name = "s3-bucket"
    CreatedBy = "Dru"
  }
}

resource "aws_s3_bucket_versioning" "enable_bucket_versioning" {
  bucket = aws_s3_bucket.test_aws_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}