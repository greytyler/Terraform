resource "aws_s3_bucket" "tf_s3_bucket" {
  bucket = "nodejsbucket007"

  tags = {
    Name        = "Nodejs terraform S3 Bucket"
    Environment = "Dev"
  }
} 


resource "aws_s3_object" "tf_s3_object" {
  bucket = aws_s3_bucket.tf_s3_bucket.bucket
  for_each = fileset("../public/images", "**")
  key    = "images/${each.value}"
  source = "../public/images/${each.key}"

}

# have successfully provisioned , managed and automated infrastracture using Terraform