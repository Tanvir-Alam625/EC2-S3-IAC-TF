variable "aws_region" {
  description = "AWS region to deploy resources into"
  type = string
  default = "us-east-1"
}
variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}
variable "project_name" {
  description = "Project name used for tagging resources"
  type = string
  default = "ConnectEC2ToS3"
}
variable "environment" {
  description = "Deployment environment"
  type = string
  default = "dev"
}
variable "bucket_name_prefix" {
    description = "Prefix used to generate a unique S3 bucket name"
    type =  string
    default = "tv-terraform-assessment-bucket"
}

variable "aws_profile" {
  description = "Named AWS CLI profile to use for authentication"
  type = string
  default = "tv-ostad-aws"
}