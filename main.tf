
# Data Source: Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2"{
    most_recent = true
    owners = [ "amazon" ]

    filter {
      name = "name"
      values = [ "amzn2-ami-hvm-*-x86_64-gp2" ]
    }

    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }
}


# EC2 Instance
resource "aws_instance" "app_server" {
    ami = data.aws_ami.amazon_linux_2.id
    instance_type = var.instance_type

    tags = {
        Name = "${var.project_name}-${var.environment}-app-server"
        Project = var.project_name
        Environment = var.environment
        ManagedBy = "Terraform"
        Owner = "Tanvir"
    }
}

# Random Suffix to guarantee a globally unique S3 bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 Bucket
resource "aws_s3_bucket" "app_bucket" {
    bucket = "${var.bucket_name_prefix}-${random_id.bucket_suffix.hex}"

    tags = {
        Name = "${var.project_name}-${var.environment}-app-bucket"
        Project = var.project_name
        Environment = var.environment
        ManagedBy = "Terraform"
        Owner = "Tanvir"
    }
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
    bucket = aws_s3_bucket.app_bucket.id

    rule {
        object_ownership = "BucketOwnerPreferred"
    }
}

resource "aws_s3_bucket_public_access_block" "app_bucket" {
    bucket = aws_s3_bucket.app_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}