
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