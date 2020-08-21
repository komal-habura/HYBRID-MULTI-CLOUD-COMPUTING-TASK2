provider "aws" {
  version = "~> 2.0"
  region     = "ap-south-1"
  profile    = "akash"
  access_key = "AKIA6CHGFUTHHGDXTJX4"
  secret_key = "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"
}

resource "aws_s3_bucket" "project-komal-bucket" {
  bucket = "s3-website-komal.com"
  acl    = "public-read"

  tags = {
    Name        = "project-komal-bucket"
  }
}

resource "aws_s3_bucket_policy" "proje-policy-bucket" {
  bucket = aws_s3_bucket.project-komal-bucket.id

  policy = <<POLICY
{
  "Id": "Policy1597663660847",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1597663657826",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::s3-website-komal.com",
      "Principal": "*"
    }
   ]
}
POLICY
}