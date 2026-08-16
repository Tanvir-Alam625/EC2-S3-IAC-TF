# Terraform EC2 & S3 Resource Lifecycle

Provisions a `t2.micro` EC2 instance and a uniquely named S3 bucket in
`us-east-1`, then tears them down cleanly with `terraform destroy`.

## Project Structure

```
terraform-ec2-s3-lifecycle/
├── main.tf                      # EC2 instance, S3 bucket, and supporting resources
├── variables.tf                 # Input variable declarations
├── outputs.tf                   # Output values (instance ID, bucket name, etc.)
├── provider.tf                  # AWS provider configuration
├── versions.tf                  # Terraform & provider version constraints
├── terraform.tfvars.example     # Sample variable values (copy to terraform.tfvars)
├── .gitignore                   # Excludes state files and secrets from VCS
└── README.md
```

## Prerequisites

- Terraform >= 1.5.0
- AWS CLI with the `aws-profile-name` named profile configured (`aws configure --profile aws-profile-name`)
- IAM permissions for EC2 and S3 on that profile

## Usage

1. Copy the example variables file and adjust if needed:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Initialize the working directory:
   ```bash
   terraform init
   ```

3. Review the execution plan:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

5. Verify resources in the AWS Console (EC2 → Instances, S3 → Buckets).

6. Destroy all resources once verified:
   ```bash
   terraform destroy
   ```

## Resources Created

| Resource | Type | Notes |
|---|---|---|
| EC2 Instance | `aws_instance` | `t2.micro`, latest Amazon Linux 2 AMI |
| S3 Bucket | `aws_s3_bucket` | Unique name via random suffix |
| S3 Ownership Controls | `aws_s3_bucket_ownership_controls` | Bucket owner preferred |
| S3 Public Access Block | `aws_s3_bucket_public_access_block` | Blocks all public access |

## Tags

Both the EC2 instance and S3 bucket are tagged:
```
Name        = "TerraformAssignment"
Environment = "dev"
ManagedBy   = "Terraform"
```