resource "aws_s3_bucket" "frontend" {
  bucket = var.bucketname
  force_destroy = true
  # acl    = "public-read" ## Deprecated
  # website { ## Deprecated
  #     index_document = "index.html"
  #     error_document = "index.html"
  # # }

  # Set one time in provider.
  # tags = {
  #   Name        = "Xitry_Frontend"
  #   Environment = "Development"
  # }
}

resource "aws_s3_bucket_policy" "public_read_only" {
  bucket = aws_s3_bucket.frontend.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.frontend.arn}/*"
      },
    ]
  })
}

resource "aws_s3_bucket_ownership_controls" "frontend" {
  bucket = aws_s3_bucket.frontend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

## This allow public access block is in conflict with the bucket policy, which will lead to fail in the terraform apply for bucket policy.
# resource "aws_s3_bucket_public_access_block" "frontend" {
#   bucket = aws_s3_bucket.frontend.id

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }
## Deprecated
# resource "aws_s3_bucket_acl" "frontend" {
#   depends_on = [
#     aws_s3_bucket_ownership_controls.frontend,
#     aws_s3_bucket_public_access_block.frontend,
#   ]

#   bucket = aws_s3_bucket.frontend.id
#   acl    = "public-read"
# }

resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}