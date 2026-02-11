# Azure Landing Zone Lite (Terraform + Azure Policy) — UK Hireable Portfolio Project

This repo is a beginner-friendly, enterprise-style Azure “Landing Zone Lite” built with Terraform.
It creates a secure baseline that UK employers expect for cloud / DevOps / platform roles:
- Governance (Policy / tagging / allowed regions)
- Standardized naming and structure
- Repeatable Infrastructure-as-Code (Terraform)

✅ Designed to be low-cost on Pay-As-You-Go: no Firewalls, no Gateways, no Bastion, no AKS, no always-on VMs.

---

## What this project builds (Layer 1: Governance)

Terraform deploys the following at **subscription scope**:

### 1) Platform Resource Group
- `alz-lite-rg-platform` (region: `uksouth`)
- Default tags: `Owner`, `Environment`, `ManagedBy`, `Project`

### 2) Azure Policy: Require Tags (DENY)
Denies resource creation if mandatory tags are missing:
- `Owner`
- `Environment`

### 3) Azure Policy: Allowed Locations (DENY)
Denies resource creation outside:
- `uksouth`
- `ukwest`

These are real “platform governance” controls used to prevent cloud sprawl and enforce standards.

---

## Why this matters (what UK employers look for)

This project demonstrates:
- Terraform IaC skills (repeatable deployments, version control)
- Azure governance (Policy definitions + assignments)
- Enterprise mindset (guardrails first)
- Cost-awareness (avoid common bill traps)

---

## Architecture (conceptual)
Landing Zone Lite = governance foundation for workloads:

- Subscription (scope)
  - Policies assigned (deny missing tags, deny non-UK regions)
  - Platform RG for baseline/platform resources

> Next layers (future): hub-spoke networking, logging workspace, CI/CD with GitHub Actions (OIDC).

---

## Prerequisites
- Azure subscription (Pay-As-You-Go is ok)
- Linux machine with:
  - Terraform
  - Azure CLI (`az`)
  - Git

Login:
```bash
az login --use-device-code
az account show
