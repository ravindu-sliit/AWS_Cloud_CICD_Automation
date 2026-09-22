# Terraform providers configuration
# This file defines which cloud providers and their versions we'll use

terraform {
  # Specify the required Terraform version
  # This ensures all team members use a compatible Terraform version
  required_version = ">= 1.0"
  
  # Define required providers and their versions
  # Version constraints ensure reproducible infrastructure deployments
  required_providers {
    aws = {
      source  = "hashicorp/aws"  # Official AWS provider from HashiCorp
      version = "~> 5.0"         # Use version 5.x (allows minor version updates)
    }
  }
}

# Configure the AWS Provider
# This tells Terraform how to authenticate and which region to use
provider "aws" {
  region = var.aws_region  # Use the region defined in variables.tf
  
  # Default tags applied to all resources created by this provider
  # Tags help with cost tracking, resource management, and organization
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = "development"
      ManagedBy   = "terraform"
      CreatedOn   = timestamp()
    }
  }
}