resource "aws_s3_bucket" "tf_cloud_test_bucket" {
  bucket = "tf-cloud-test-bucket"

  tags = {
    Name        = "${var.prefix}-tf_cloud_test_bucket"
    Environment = "Dev"
  }
}
