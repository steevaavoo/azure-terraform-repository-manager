# azure-terraform-repository-manager

Project to implement Nexus Repository Manager running on an AKS Kubernetes Cluster

## Goals

I want to use the following tools and services to create a fully automated, reusable repository solution:

- GitHub Actions: Continuous Integration ("build and test" orchestration)
- Terraform: Infrastructure as Code
- Azure: Cloud Platform
- AKS: Azure Kubernetes Service - deployment and scaling of Services
- Nexus: Artifact Repository (will publish my custom module here)
- Ansible: Configuration of Nexus via REST API

Ultimately I intend to utilise my skills and experience with these tools to create an environment from which I can
seamlessly install custom modules on remote devices.
