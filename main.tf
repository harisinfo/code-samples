#######################
# Example AWS resources
#######################


resource "aws_instance" "web" {
  count         = var.environment == "prod" ? 3 : 1
  #count         = 2
  ami           = "test"
  instance_type = var.instance_type
}


output "instance_detail" {
  value = aws_instance.web[*].public_ip
}


resource "aws_s3_bucket" "hello" {
  bucket_prefix = "hello-terraform-"

  tags = {
    Name      = "My first Terraform bucket in ${var.environment}"
    ManagedBy = var.managed_by
  }
}

output "bucket_name" {
  value = aws_s3_bucket.hello.id
}


resource "aws_s3_bucket" "logs" {
  bucket_prefix = "logs-terraform-"

  tags = {
    Name      = "My second Terraform bucket"
    ManagedBy = var.managed_by
  }
}

output "logs_bucket_name" {
  value = aws_s3_bucket.logs.id
}

resource "aws_s3_bucket_versioning" "hello" {
  bucket = aws_s3_bucket.hello.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "buckets" {
  for_each      = toset(["images", "logs", "backups"])
  bucket_prefix = "${each.key}-"
}


output "bucket_ids" {
  value = { for k, b in aws_s3_bucket.buckets : k => b.id }
}
