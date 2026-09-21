# AWS Cloud Infrastructure & CI/CD Automation Learning Plan
## Pearson Associate Cloud Engineer Intern Interview Preparation

---

## 1. Project Goal & Final Architecture

### **Goal**: 
Deploy a FastAPI application using AWS cloud services with automated CI/CD pipeline to demonstrate cloud engineering skills for Pearson Associate Cloud Engineer Intern interview.

### **Architecture Diagram**:
```
┌─────────────┐    ┌──────────────────┐    ┌─────────────────────────┐
│   GitHub    │───▶│  GitHub Actions  │───▶│        AWS Cloud        │
│  Repository │    │     CI/CD        │    │                         │
└─────────────┘    └──────────────────┘    └─────────────────────────┘
                                                        │
                    ┌─────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────────────────┐
│                           AWS VPC                                   │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │                    Public Subnet                              │  │
│  │  ┌─────────────────┐    ┌─────────────────┐                  │  │
│  │  │   EC2 Instance  │    │  Security Group │                  │  │
│  │  │                 │    │   (Port 8000)   │                  │  │
│  │  │  ┌───────────┐  │    └─────────────────┘                  │  │
│  │  │  │  Docker   │  │                                         │  │
│  │  │  │Container  │  │    ┌─────────────────┐                  │  │
│  │  │  │           │  │    │   Internet      │                  │  │
│  │  │  │ FastAPI   │◀─┼────┤   Gateway       │                  │  │
│  │  │  │    App    │  │    │                 │                  │  │
│  │  │  │:8000      │  │    └─────────────────┘                  │  │
│  │  │  └───────────┘  │                                         │  │
│  │  └─────────────────┘                                         │  │
│  └───────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 2. Progress Tracker

### **Completed** ✅
- [x] FastAPI application created (app/main.py)
- [x] Dockerfile created and tested
- [x] Docker container running locally
- [x] Basic Python project structure

### **In Progress** 🔄
- [ ] AWS Account setup
- [ ] VPC and networking configuration
- [ ] EC2 instance deployment

### **Upcoming** 📋
- [ ] Terraform infrastructure as code
- [ ] GitHub Actions CI/CD pipeline
- [ ] IAM roles and security
- [ ] Cost optimization
- [ ] Documentation and monitoring
- [ ] Interview preparation materials

---

## 3. 7-Day Learning Plan

### **Day 1: Cloud Fundamentals + Docker** ✅ COMPLETED

**Concepts Learned:**
- Cloud computing basics (IaaS, PaaS, SaaS)
- Docker containerization concepts
- FastAPI framework fundamentals
- Local development environment

**Tasks Completed:**
1. Created FastAPI application
2. Built and tested Docker container
3. Validated local deployment

**Key Commands Used:**
```bash
docker build -t fastapi-app .
docker run -p 8000:8000 fastapi-app
```

**Interview Knowledge Points:**
- Explain containerization benefits
- Describe microservices architecture
- Understanding of REST APIs

---

### **Day 2: AWS Account + VPC + Networking**

**Concepts to Learn:**
- AWS Free Tier limits and best practices
- VPC (Virtual Private Cloud) fundamentals
- Subnets, Route Tables, Internet Gateways
- Security Groups vs NACLs
- AWS CLI basics

**Hands-on Tasks:**
1. Create AWS account and set up billing alerts
2. Configure AWS CLI with IAM user credentials
3. Create custom VPC with public subnet
4. Set up Internet Gateway and route table
5. Create Security Group for web traffic
6. Test connectivity and security rules

**Key Commands:**
```bash
# AWS CLI setup
aws configure
aws sts get-caller-identity

# VPC operations
aws ec2 create-vpc --cidr-block 10.0.0.0/16
aws ec2 create-subnet --vpc-id vpc-xxx --cidr-block 10.0.1.0/24
aws ec2 create-internet-gateway
```

**Interview Knowledge Points:**
- Explain VPC components and their relationships
- Security Groups vs NACLs differences
- AWS networking fundamentals
- CIDR notation and subnetting

---

### **Day 3: EC2 + Manual Deployment**

**Concepts to Learn:**
- EC2 instance types and pricing
- AMI (Amazon Machine Images)
- Key pairs and SSH access
- User data scripts
- Elastic IP addresses

**Hands-on Tasks:**
1. Launch EC2 instance in custom VPC
2. Configure key pair for SSH access
3. Install Docker on EC2 instance
4. Transfer application files to EC2
5. Build and run Docker container on EC2
6. Test public access to application
7. Create AMI snapshot

**Key Commands:**
```bash
# SSH to EC2
ssh -i key.pem ec2-user@public-ip

# Install Docker on Amazon Linux
sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

# Deploy application
docker build -t fastapi-app .
docker run -d -p 8000:8000 fastapi-app
```

**Interview Knowledge Points:**
- EC2 instance lifecycle
- SSH and key pair security
- Docker deployment strategies
- AWS AMI concepts

---

### **Day 4: Terraform / Infrastructure as Code**

**Concepts to Learn:**
- Infrastructure as Code (IaC) principles
- Terraform syntax and concepts
- State management
- Resource dependencies
- Variables and outputs

**Hands-on Tasks:**
1. Install Terraform locally
2. Create main.tf for VPC resources
3. Define variables.tf and outputs.tf
4. Initialize and plan infrastructure
5. Apply Terraform configuration
6. Modify and update infrastructure
7. Destroy and recreate resources

**Key Commands:**
```bash
# Terraform workflow
terraform init
terraform plan
terraform apply
terraform destroy

# Format and validate
terraform fmt
terraform validate
```

**Interview Knowledge Points:**
- Benefits of Infrastructure as Code
- Terraform vs CloudFormation
- State file management
- Resource lifecycle management

---

### **Day 5: CI/CD + GitHub Actions**

**Concepts to Learn:**
- Continuous Integration/Continuous Deployment
- GitHub Actions workflows
- Secrets management
- Docker registry integration
- Automated testing

**Hands-on Tasks:**
1. Create GitHub repository
2. Push code to repository
3. Create .github/workflows/deploy.yml
4. Configure GitHub secrets for AWS
5. Set up automated Docker build
6. Implement deployment workflow
7. Test CI/CD pipeline

**Key Commands:**
```bash
# Git operations
git init
git add .
git commit -m "Initial commit"
git remote add origin <repository-url>
git push -u origin main
```

**Interview Knowledge Points:**
- CI/CD pipeline benefits
- GitHub Actions vs other CI tools
- Security in CI/CD pipelines
- Automated testing strategies

---

### **Day 6: Deployment Pipeline + IAM**

**Concepts to Learn:**
- IAM (Identity and Access Management)
- Roles, policies, and permissions
- Service-to-service authentication
- Deployment strategies (blue-green, rolling)
- Monitoring and logging basics

**Hands-on Tasks:**
1. Create IAM role for EC2 deployment
2. Configure least-privilege policies
3. Update GitHub Actions with proper IAM
4. Implement automated deployment script
5. Add health checks and rollback
6. Set up basic CloudWatch monitoring
7. Configure log aggregation

**Key Commands:**
```bash
# IAM operations
aws iam create-role --role-name EC2DeployRole
aws iam attach-role-policy --role-name EC2DeployRole --policy-arn arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess

# CloudWatch
aws logs create-log-group --log-group-name /aws/ec2/application
```

**Interview Knowledge Points:**
- IAM best practices
- Principle of least privilege
- Deployment strategies
- Monitoring and observability

---

### **Day 7: Documentation + Review + GenAI Basics**

**Concepts to Learn:**
- Technical documentation best practices
- System architecture documentation
- GenAI/ML basics for cloud engineers
- Cost optimization strategies
- Interview preparation techniques

**Hands-on Tasks:**
1. Create comprehensive README.md
2. Document architecture decisions
3. Add code comments and docstrings
4. Create deployment runbook
5. Review and test entire pipeline
6. Practice explaining the project
7. Prepare demo presentation

**Key Commands:**
```bash
# Cost analysis
aws ce get-cost-and-usage --time-period Start=2024-01-01,End=2024-01-31 --granularity MONTHLY --metrics BlendedCost

# Resource cleanup
terraform destroy
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
```

**Interview Knowledge Points:**
- Project explanation and demo
- Cost optimization strategies
- Lessons learned and improvements
- GenAI impact on cloud engineering

---

## 4. Final Repository Structure

```
AWS_Cloud_CICD_Automation/
│
├── app/
│   ├── main.py                 # FastAPI application
│   ├── requirements.txt        # Python dependencies
│   └── __init__.py
│
├── infrastructure/
│   ├── main.tf                 # Terraform main configuration
│   ├── variables.tf            # Terraform variables
│   ├── outputs.tf              # Terraform outputs
│   └── terraform.tfvars        # Terraform variable values
│
├── .github/
│   └── workflows/
│       ├── ci.yml              # Continuous Integration
│       └── deploy.yml          # Deployment pipeline
│
├── scripts/
│   ├── setup.sh                # Environment setup
│   ├── deploy.sh               # Deployment script
│   └── cleanup.sh              # Resource cleanup
│
├── docs/
│   ├── architecture.md         # System architecture
│   ├── deployment.md           # Deployment guide
│   └── troubleshooting.md      # Common issues
│
├── Dockerfile                  # Container definition
├── docker-compose.yml          # Local development
├── .gitignore                  # Git ignore rules
├── README.md                   # Project documentation
└── .env.example               # Environment variables template
```

---

## 5. Interview Preparation Checklist

### **Must Know** ⭐⭐⭐
- [ ] Explain your project architecture end-to-end
- [ ] Demo the working application
- [ ] Describe CI/CD pipeline implementation
- [ ] AWS VPC and networking concepts
- [ ] Docker containerization benefits
- [ ] Infrastructure as Code with Terraform
- [ ] Security best practices (IAM, Security Groups)
- [ ] Cost optimization strategies

### **Know Conceptually** ⭐⭐
- [ ] Other AWS services (RDS, S3, Lambda)
- [ ] Load balancing and auto-scaling
- [ ] Database concepts and management
- [ ] Monitoring and logging strategies
- [ ] Different deployment strategies
- [ ] DevOps culture and practices
- [ ] Agile methodology basics

### **Basic Awareness** ⭐
- [ ] Machine Learning and AI in cloud
- [ ] Kubernetes vs Docker Swarm
- [ ] Multi-cloud strategies
- [ ] Compliance and governance
- [ ] Disaster recovery planning
- [ ] Performance optimization
- [ ] Cloud migration strategies

---

## 6. Common Interview Questions

### **Technical Questions**

**Q: Walk me through your project architecture.**
**A:** "I built a FastAPI application deployed on AWS using a fully automated CI/CD pipeline. The architecture includes a custom VPC with public subnet, EC2 instance running Docker containers, and GitHub Actions for automated deployment. I used Terraform for infrastructure as code to ensure reproducible deployments."

**Q: Why did you choose Docker for this project?**
**A:** "Docker provides consistent environments across development and production, simplifies dependency management, enables easy scaling, and follows microservices best practices. It also makes the deployment process more reliable and portable."

**Q: How do you ensure security in your AWS setup?**
**A:** "I implemented security groups with minimal required ports, used IAM roles with least-privilege principles, stored secrets securely in GitHub Actions, and ensured all resources are in a private VPC with controlled internet access."

**Q: What would you do differently if this was a production system?**
**A:** "I'd add load balancing, implement auto-scaling, use RDS for database instead of local storage, add comprehensive monitoring with CloudWatch, implement proper logging, use multiple availability zones, and add backup and disaster recovery procedures."

### **Behavioral Questions**

**Q: Tell me about a challenging problem you solved.**
**A:** Focus on debugging deployment issues, learning Terraform, or troubleshooting networking problems during the project.

**Q: How do you stay updated with new technologies?**
**A:** Mention AWS documentation, tech blogs, hands-on projects, online courses, and community involvement.

---

## 7. CV Bullet Points

Use these after project completion:

- **Designed and deployed a scalable FastAPI application on AWS EC2 using Docker containerization, implementing Infrastructure as Code with Terraform**

- **Built automated CI/CD pipeline using GitHub Actions, reducing deployment time by 90% and ensuring consistent, reliable releases**

- **Configured AWS VPC with custom networking, security groups, and IAM roles following cloud security best practices**

- **Implemented Infrastructure as Code using Terraform, enabling reproducible deployments and version-controlled infrastructure changes**

- **Optimized cloud costs through efficient resource allocation and monitoring, staying within AWS free tier limits while maintaining performance**

- **Created comprehensive technical documentation and deployment runbooks for knowledge sharing and maintenance**

---

## 8. Cost Management Tips

### **Stay within Free Tier**
- **EC2**: 750 hours/month of t2.micro or t3.micro instances
- **VPC**: No additional charges for basic VPC resources
- **Data Transfer**: 15 GB outbound per month
- **CloudWatch**: Basic monitoring included

### **What to Avoid**
- Large instance types (t2.small and above incur charges)
- Elastic Load Balancers (not free tier eligible)
- NAT Gateways ($45/month minimum)
- Multiple Availability Zones unnecessarily
- Elastic IPs when not attached to running instances

### **Cost Monitoring**
- Set up billing alerts for $5, $10, $25
- Use AWS Cost Explorer regularly
- Tag all resources for cost tracking
- Clean up resources after testing

### **Cleanup Commands**
```bash
# Terminate EC2 instances
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0

# Delete VPC resources (in order)
terraform destroy

# Check for running resources
aws ec2 describe-instances --query 'Reservations[].Instances[?State.Name==`running`]'
```

---

## 9. Quick Commands Reference

### **Docker**
```bash
# Build and run
docker build -t fastapi-app .
docker run -d -p 8000:8000 fastapi-app

# Management
docker ps                    # List running containers
docker logs <container-id>   # View logs
docker stop <container-id>   # Stop container
docker system prune -a       # Clean up
```

### **Terraform**
```bash
# Core workflow
terraform init               # Initialize
terraform plan              # Preview changes
terraform apply             # Apply changes
terraform destroy           # Destroy infrastructure

# Utilities
terraform fmt               # Format files
terraform validate          # Validate syntax
terraform state list        # List resources
terraform output            # Show outputs
```

### **AWS CLI**
```bash
# Configuration
aws configure               # Setup credentials
aws sts get-caller-identity # Verify identity

# EC2
aws ec2 describe-instances  # List instances
aws ec2 start-instances --instance-ids i-xxx
aws ec2 stop-instances --instance-ids i-xxx

# VPC
aws ec2 describe-vpcs       # List VPCs
aws ec2 describe-subnets    # List subnets
```

### **SSH & Server Management**
```bash
# Connect to EC2
ssh -i key.pem ec2-user@public-ip

# File transfer
scp -i key.pem file.txt ec2-user@public-ip:~/

# Server commands
sudo systemctl status docker
sudo systemctl start docker
sudo docker ps
```

### **Git**
```bash
# Basic workflow
git status                  # Check status
git add .                   # Stage changes
git commit -m "message"     # Commit changes
git push origin main        # Push to remote

# Branch management
git branch                  # List branches
git checkout -b feature     # Create and switch branch
git merge feature           # Merge branch
```

---

## Success Metrics

By the end of this plan, you should be able to:

1. ✅ **Deploy** a working application on AWS
2. ✅ **Explain** every component of your architecture
3. ✅ **Demonstrate** the CI/CD pipeline
4. ✅ **Discuss** security and cost considerations
5. ✅ **Troubleshoot** common deployment issues
6. ✅ **Present** your project confidently in interviews

---

**Last Updated**: September 18, 2024  
**Estimated Completion Time**: 7 days (2-3 hours per day)  
**Difficulty Level**: Intermediate  
**Target Role**: Associate Cloud Engineer Intern at Pearson