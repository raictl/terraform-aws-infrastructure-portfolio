
# AWS Infrastructure with Terraform

A portfolio project demonstrating Infrastructure as Code (IaC) on AWS using Terraform. The project is designed with separate development and production configurations, reusable modules, network isolation, and cost-conscious deployment practices.

## Project Objectives

- Provision AWS infrastructure using Terraform.
- Organize infrastructure into reusable modules.
- Separate development and production configurations and state.
- Deploy an application behind an Application Load Balancer (ALB).
- Place application compute and PostgreSQL database resources in private subnets.
- Configure outbound connectivity using a NAT Gateway.
- Apply security groups and IAM least-privilege principles.
- Validate infrastructure changes using Terraform formatting, validation, and plans.
- Automate static checks with GitHub Actions.
- Document cost management, cleanup, and troubleshooting.

## Planned Architecture

Internet
   |
Internet Gateway
   |
Public Subnets (two Availability Zones)
   |-- Application Load Balancer
   |-- NAT Gateway
   |
Private Application Subnets
   |-- EC2 application instance(s)
   |
Private Database Subnets
   |-- Amazon RDS for PostgreSQL

Terraform modules will manage the VPC, security groups, ALB, EC2, and RDS components.

## Environments

### Development (`dev`)

- Intended for testing and demonstration.
- One small EC2 application instance initially.
- One NAT Gateway.
- Application Load Balancer across two public subnets.
- Single-AZ RDS for PostgreSQL.
- Resources will be deployed only after architecture, cost, and plan review.

### Production (`prod`)

- Separate Terraform configuration and state.
- Intended to demonstrate production-oriented settings.
- Planned application scaling and Multi-AZ database availability.
- Configuration only until deployment receives explicit approval.

The development configuration is not intended to provide production-grade high availability.

## Technology Stack

- AWS
- Terraform
- Amazon VPC
- Amazon EC2
- Application Load Balancer
- NAT Gateway
- Amazon RDS for PostgreSQL
- Amazon S3 for Terraform remote state
- Git and GitHub
- GitHub Actions

## Repository Structure

```text
.
├── bootstrap/
├── environments/
│   ├── dev/
│   └── prod/
├── modules/
│   ├── vpc/
│   ├── security/
│   ├── alb/
│   ├── compute/
│   └── rds/
├── .github/
│   └── workflows/
├── .gitignore
└── README.md
```

## Security Principles

- EC2 and RDS will not be publicly accessible.
- PostgreSQL access will be restricted to the application security group.
- SSH will not be exposed to the entire internet.
- AWS credentials and database passwords must not be committed to Git.
- Terraform state will use an encrypted, versioned S3 bucket.
- Development and production will use separate state keys.
- Infrastructure changes will be reviewed using `terraform plan`.

## Cost Management

NAT Gateways, ALBs, EC2, RDS, public IPv4 addresses, storage, and data transfer can incur charges.

Cost controls will include:

- Reviewing AWS Pricing Calculator estimates before deployment.
- Deploying development resources only after explicit approval.
- Deleting temporary infrastructure after testing.
- Reviewing retained database snapshots and storage.
- Configuring billing alerts and monitoring usage.

Free-tier eligibility is not guaranteed. Actual costs depend on account eligibility, configuration, usage, and AWS pricing.

## Terraform Workflow

The planned workflow is:

1. Format Terraform files.
2. Initialize Terraform.
3. Validate the configuration.
4. Review the execution plan.
5. Review estimated costs and security implications.
6. Obtain explicit approval before applying changes.
7. Verify deployed resources.
8. Clean up temporary infrastructure when finished.

No AWS infrastructure should be created until the architecture, cost estimate, and Terraform plan have been reviewed and deployment is explicitly approved.

## Project Status

- [x] Repository initialized.
- [x] Initial directory structure created.
- [x] `.gitignore` created.
- [ ] Terraform modules implemented.
- [ ] Remote state bootstrap implemented.
- [ ] Development and production configurations completed.
- [ ] CI validation workflow configured.
- [ ] Cost and security review completed.
- [ ] Development deployment approved and verified.
- [ ] Final documentation and interview notes completed.

## Disclaimer

This repository is an educational portfolio project. Production readiness requires additional reviews for availability, disaster recovery, access control, monitoring, compliance, and operational procedures.
```
