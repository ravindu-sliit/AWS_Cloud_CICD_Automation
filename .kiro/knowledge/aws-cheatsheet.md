# AWS Quick Reference Cheatsheet

## 1. AWS Services Quick Reference

| Service | What it is | When to use |
|---------|------------|-------------|
| EC2 | Virtual servers in the cloud | Need compute power, web servers, applications |
| S3 | Object storage service | Store files, backups, static websites, data lakes |
| IAM | Identity & Access Management | Control user permissions and access |
| VPC | Virtual Private Cloud | Isolated network environments |
| Lambda | Serverless compute | Event-driven code, microservices, automation |
| ECS | Container orchestration | Run Docker containers at scale |
| Security Groups | Virtual firewall | Control inbound/outbound traffic to instances |

## 2. Docker Commands

```bash
# Build & Run
docker build -t myapp .                    # Build image from Dockerfile
docker run -d -p 8080:80 myapp            # Run container in background
docker run -it ubuntu bash                # Interactive container

# Management
docker ps                                  # List running containers
docker ps -a                              # List all containers
docker images                             # List images
docker stop <container-id>                # Stop container
docker rm <container-id>                  # Remove container
docker rmi <image-id>                     # Remove image

# Docker Compose
docker-compose up -d                       # Start services in background
docker-compose down                        # Stop and remove containers
```

## 3. Terraform Commands

```bash
terraform init          # Initialize working directory, download providers
terraform plan           # Preview changes before applying
terraform apply          # Create/update infrastructure
terraform destroy        # Destroy all managed infrastructure
terraform validate       # Validate configuration syntax
terraform fmt            # Format code consistently
terraform state list     # List resources in state
```

## 4. AWS CLI Commands

```bash
# Configuration
aws configure                              # Set up credentials and region
aws sts get-caller-identity               # Verify current user/role

# EC2
aws ec2 describe-instances                # List EC2 instances
aws ec2 start-instances --instance-ids i-123456  # Start instance
aws ec2 stop-instances --instance-ids i-123456   # Stop instance

# S3
aws s3 ls                                 # List buckets
aws s3 ls s3://bucket-name/               # List objects in bucket
aws s3 cp file.txt s3://bucket/           # Upload file
aws s3 cp s3://bucket/file.txt .          # Download file
aws s3 sync ./folder s3://bucket/folder/  # Sync folder
```

## 5. SSH Commands

```bash
# Connect
ssh -i key.pem user@hostname              # Connect with key file
ssh user@hostname                         # Connect with password/agent

# File Transfer
scp -i key.pem file.txt user@host:/path/  # Copy file to remote
scp -i key.pem user@host:/path/file.txt . # Copy file from remote
scp -r folder/ user@host:/path/           # Copy directory

# Tunneling
ssh -L 8080:localhost:80 user@host        # Local port forwarding
```

## 6. Git Commands (CI/CD Workflow)

```bash
# Basic Workflow
git clone <repo-url>                      # Clone repository
git checkout -b feature-branch            # Create and switch to branch
git add .                                 # Stage changes
git commit -m "message"                   # Commit changes
git push origin feature-branch            # Push branch

# CI/CD Specific
git tag v1.0.0                           # Create release tag
git push origin v1.0.0                   # Push tag (triggers deployment)
git merge main                           # Merge main into current branch
git rebase main                          # Rebase current branch on main
git reset --hard HEAD~1                  # Undo last commit (dangerous)
```

## 7. Networking Quick Reference

```bash
# Common Ports
22    - SSH
80    - HTTP
443   - HTTPS
3389  - RDP
3306  - MySQL
5432  - PostgreSQL
6379  - Redis

# CIDR Notation Examples
10.0.0.0/8     - 16.7M IPs (10.0.0.0 to 10.255.255.255)
172.16.0.0/12  - 1M IPs (172.16.0.0 to 172.31.255.255)
192.168.0.0/16 - 65K IPs (192.168.0.0 to 192.168.255.255)
10.0.0.0/24    - 256 IPs (10.0.0.0 to 10.0.0.255)
10.0.0.0/28    - 16 IPs (10.0.0.0 to 10.0.0.15)

# Protocols
TCP - Reliable, connection-oriented (HTTP, SSH, FTP)
UDP - Fast, connectionless (DNS, DHCP, streaming)
ICMP - Network diagnostics (ping, traceroute)
```

## 8. Interview One-Liners

- **Availability Zone**: Isolated data center within a region
- **Region**: Geographic area with multiple availability zones
- **Auto Scaling**: Automatically adjust capacity based on demand
- **Load Balancer**: Distributes traffic across multiple targets
- **CDN (CloudFront)**: Global content delivery network
- **RDS**: Managed relational database service
- **Route 53**: DNS web service and domain registration
- **CloudFormation**: Infrastructure as code (AWS native)
- **Elastic IP**: Static IP address for cloud computing
- **NAT Gateway**: Allows private subnet internet access
- **Bastion Host**: Secure jump server for private resources
- **Blue/Green Deployment**: Two identical environments for zero-downtime deploys
- **Microservices**: Loosely coupled, independently deployable services
- **Container**: Lightweight, portable application package
- **Serverless**: Run code without managing servers