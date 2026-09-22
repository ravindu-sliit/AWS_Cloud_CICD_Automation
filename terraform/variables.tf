# Terraform Input Variables
# Variables make our configuration reusable and customizable
# Users can override default values in terraform.tfvars or via command line

variable "aws_region" {
  description = "AWS region where all resources will be created"
  type        = string
  default     = "ap-southeast-2"
  
  # Validation ensures only valid AWS regions are provided
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.aws_region))
    error_message = "AWS region must be in format like 'us-west-2' or 'ap-southeast-2'."
  }
}

variable "project_name" {
  description = "Name of the project - used as prefix for all resource names"
  type        = string
  default     = "assessment-api"
  
  # Validation ensures naming compatibility with AWS resources
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Project name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC - defines the IP address range for our network"
  type        = string
  default     = "10.0.0.0/16"
  
  # Validation ensures proper CIDR format
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet - must be within VPC CIDR range"
  type        = string
  default     = "10.0.1.0/24"
  
  # Validation ensures proper CIDR format
  validation {
    condition     = can(cidrhost(var.public_subnet_cidr, 0))
    error_message = "Subnet CIDR must be a valid IPv4 CIDR block."
  }
}

variable "instance_type" {
  description = "EC2 instance type - determines CPU, memory, and network performance"
  type        = string
  default     = "t3.micro"
  
  # Validation ensures only valid instance types
  validation {
    condition = contains([
      "t3.nano", "t3.micro", "t3.small", "t3.medium", "t3.large",
      "t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large"
    ], var.instance_type)
    error_message = "Instance type must be a valid EC2 instance type."
  }
}

variable "my_ip" {
  description = "Your public IP address for SSH access (format: x.x.x.x/32). Get it from https://whatismyipaddress.com/"
  type        = string
  # No default - user must provide their IP for security
  
  # Validation ensures proper IP format with /32 CIDR
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/32$", var.my_ip))
    error_message = "my_ip must be a valid IPv4 address in CIDR format (e.g., 203.0.113.1/32)."
  }
}