  # =============================================================================
  # TERRAFORM OUTPUTS
  # =============================================================================
  # Outputs display useful information after Terraform creates resources.
  # They're like return values - showing you what was created.
  # =============================================================================

  output "ec2_public_ip" {
    description = "Public IP address of the EC2 instance"
    value       = aws_instance.main.public_ip
  }

  output "ec2_public_dns" {
    description = "Public DNS name of the EC2 instance"
    value       = aws_instance.main.public_dns
  }

  output "vpc_id" {
    description = "ID of the VPC"
    value       = aws_vpc.main.id
  }

  output "subnet_id" {
    description = "ID of the public subnet"
    value       = aws_subnet.public.id
  }

  output "security_group_id" {
    description = "ID of the security group"
    value       = aws_security_group.main.id
  }

  output "s3_bucket_name" {
    description = "Name of the S3 bucket"
    value       = aws_s3_bucket.main.id
  }

  output "ssh_command" {
    description = "Command to SSH into the EC2 instance"
    value       = "ssh -i your-key.pem ubuntu@${aws_instance.main.public_ip}"
  }

  output "api_url" {
    description = "URL to access the API"
    value       = "http://${aws_instance.main.public_ip}/health"
  }
