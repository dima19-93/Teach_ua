# Teach_ua: DevOps & Cloud Infrastructure Automation

This repository contains the full automated infrastructure and CI/CD pipelines for the **Teach_ua** application. The project demonstrates an enterprise-grade migration from local development environments to cloud orchestration platforms.

---

## 🏗️ Project Architecture Overview

The infrastructure lifecycle is split into three core deployment strategies, moving from manual local setups to automated cloud delivery:

1. **Local IaC & Automation:** Vagrant + VirtualBox configuration provisioned by Ansible Playbooks.
2. **Local Kubernetes PoC:** Multi-container orchestration using a lightweight **k3s cluster** to verify configurations manually before cloud migration.
3. **Production Cloud Native Deployment:** Fully managed architecture deployed on **AWS (ECS Fargate + RDS MariaDB)**.

---

## 📂 Repository Structure

*   `/backend` - Spring Boot backend application source code.
*   `/frontend` - React frontend application source code.
*   `/devops` - Infrastructure automation tools:
    *   `/devops/ansible` - Playbooks for environment provisioning.
    *   `/devops/k3s-manifests` - Kubernetes deployment manifests (Deployments, Services, Ingress).
*   `/terraform` - Infrastructure as Code configurations for AWS cloud environment provisioning.
*   `Jenkinsfile` - Declarative CI/CD pipeline definition.

---

## ⚙️ CI/CD Pipeline Workflow (Jenkinsfile)

The automated delivery pipeline executes the following stages upon every push to the repository:

1. **Checkout:** Fetches the latest source code from GitHub.
2. **Build & Push:** Automates multi-container builds and pushes versions to **Amazon ECR**.
3. **DevSecOps Code Scanning:** Integrates **Trivy Security Scanning** to audit Docker images for high/critical vulnerabilities.
4. **ChatOps Alerting:** Triggers real-time Discord notifications regarding scan completions via webhook integrations.
5. **Continuous Delivery:** Dispatches rolling updates directly to the **AWS ECS Fargate** target cluster via AWS CLI.

---

## 🚀 How to Run Manually

### 1. Local Kubernetes Testing (k3s)
To spin up the containers in your local k3s environment:
```bash
kubectl apply -f devops/k3s-manifests/backend-k3s.yaml
kubectl apply -f devops/k3s-manifests/frontend-k3s.yaml
kubectl apply -f devops/k3s-manifests/ingress-k3s.yaml
```

### 2. Cloud Provisioning (Terraform)
To spin up production infrastructure on AWS:
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

---

## 🛡️ Key Tech Stack
*   **CI/CD:** Jenkins, GitHub Webhooks, Discord Integration
*   **Security:** Trivy, AWS SSM Parameter Store
*   **Infrastructure as Code:** Terraform, Ansible, Vagrant
*   **Orchestration:** AWS ECS (Fargate), K3s (Kubernetes)
*   **Databases & Tools:** Amazon RDS (MariaDB), Docker Hub / ECR
