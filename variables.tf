variable "bucket_name" {
  description = "Name of the S3 bucket for the static website"
  type        = string
  default     = "your-name-static-site"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment tag (dev, staging, prod)"
  type        = string
  default     = "dev"
}