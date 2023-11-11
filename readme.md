
# Infrastructure as Code (IAC) Configuration Documentation

## Table of Contents

1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
3. [Infrastructure Overview](#3-infrastructure-overview)
4. [Terraform Configuration](#4-terraform-configuration)
   - [4.1. Initialize Terraform](#41-initialize-terraform)
   - [4.2. Terraform Plan](#42-terraform-plan)
   - [4.3. Terraform Apply](#43-terraform-apply)
5. [AWS Setup](#5-aws-setup)
   - [5.1. AWS CLI Configuration](#51-aws-cli-configuration)
   - [5.2. IAM and Permissions](#52-iam-and-permissions)
6. [Infrastructure Components](#6-infrastructure-components)
   - [6.1. Elastic IP (EIP)](#61-elastic-ip-eip)
   - [6.2. VPC (Virtual Private Cloud)](#62-vpc-virtual-private-cloud)
   - [6.3. Subnet](#63-subnet)
   - [6.4. NACL (Network Access Control List)](#64-nacl-network-access-control-list)
   - [6.5. NAT Gateway (Network Address Translation)](#65-nat-gateway-network-address-translation)
   - [6.6. Internet Gateway (IGW)](#66-internet-gateway-igw)
   - [6.7. Key Pair](#67-key-pair)
   - [6.8. EC2 Instance](#68-ec2-instance)
   - [6.9. Route Table](#69-route-table)
   - [6.10. Backend](#610-backend)
7. [Conclusion](#7-conclusion)

## 1. Introduction

This documentation provides a comprehensive guide to our Infrastructure as Code (IAC) configuration. We'll explain the setup of our AWS infrastructure using Terraform, covering the provision of an application server with Elastic IP (EIP), VPC, Subnet, Network Access Control List (NACL), NAT Gateway, Internet Gateway (IGW), Key Pair, EC2 instance, Route Table, and a Backend service. We will also touch upon the role of AWS services, AWS CLI configuration, and IAM (Identity and Access Management) setup.

## 2. Prerequisites

Before proceeding with this configuration, ensure that you have the following prerequisites:

- An AWS account with the necessary permissions.
- Terraform installed on your local machine.
- AWS CLI installed and configured with appropriate IAM credentials.
- Basic knowledge of AWS services and IAM.

## 3. Infrastructure Overview

Our infrastructure will consist of an EC2 instance serving as an application server. It will be deployed within a VPC, with a public subnet for internet access. We'll use an Elastic IP (EIP) for the EC2 instance to have a static public IP. NACLs, NAT Gateway, and IGW will be set up to control traffic and allow internet access. A key pair will provide SSH access to the EC2 instance. Route tables will be configured to manage network traffic.

## 4. Terraform Configuration

### 4.1. Initialize Terraform

To initialize Terraform for your project, run:

```bash
terraform init
```

This command downloads necessary plugins and initializes your working directory for Terraform.

### 4.2. Terraform Plan

Generate a plan to see what changes Terraform will make:

```bash
terraform plan
```

This step is crucial to review the changes Terraform will apply to your infrastructure before making any modifications.

### 4.3. Terraform Apply

Apply the changes to your AWS infrastructure:

```bash
terraform apply
```

This command provisions the resources defined in your Terraform configuration.

## 5. AWS Setup

### 5.1. AWS CLI Configuration

Configure your AWS CLI by running:

```bash
aws configure
```

Provide your AWS Access Key ID, Secret Access Key, default region, and output format. This is essential for Terraform to interact with your AWS account.

### 5.2. IAM and Permissions

Set up IAM users, roles, and permissions to ensure secure access to your AWS resources. Assign appropriate permissions for your Terraform project and AWS CLI.

## 6. Infrastructure Components

Now, let's dive into the details of the components provisioned by Terraform.

### 6.1. Elastic IP (EIP)

An Elastic IP provides a static public IP address for your EC2 instance, ensuring consistent external accessibility.

### 6.2. VPC (Virtual Private Cloud)

A Virtual Private Cloud isolates your resources and allows you to define your network configuration.

### 6.3. Subnet

We create a public subnet for your EC2 instance within the VPC to enable internet access.

### 6.4. NACL (Network Access Control List)

NACLs are used to control inbound and outbound traffic to and from your subnets.

### 6.5. NAT Gateway (Network Address Translation)

The NAT Gateway allows instances in a private subnet to initiate outbound traffic to the internet.

### 6.6. Internet Gateway (IGW)

An Internet Gateway allows communication between your VPC and the internet.

### 6.7. Key Pair

A Key Pair is used to securely access your EC2 instance via SSH.

### 6.8. EC2 Instance

The EC2 instance serves as your application server, running your application code.

### 6.9. Route Table

Route tables define the rules for network traffic within your VPC.

### 6.10. Backend

Your application backend service is configured to interact with the EC2 instance as required.

## 7. Conclusion

This documentation provides a comprehensive overview of myIAC configuration using Terraform and AWS. By following these steps, you have successfully set up an application server in your AWS environment. Please ensure to customize the configuration according to your specific requirements, including security policies and additional services. The documentation helps you maintain and manage your infrastructure effectively and understand the rationale behind each configuration choice.
