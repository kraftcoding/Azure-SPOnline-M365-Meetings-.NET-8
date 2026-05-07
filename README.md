# Infrastructure Deployment – Multi‑Environment Bicep Setup

This project provides a fully refactored, modular, and production‑ready Azure infrastructure deployment using Bicep. 
It supports dev, test, and prod environments without modifying the code, relying instead on per‑environment parameter files.

## Key Components
main.bicep – Orchestrates all modules and defines the full deployment.
modules/ – Contains isolated, reusable Bicep modules for each Azure resource.
params/ – Environment‑specific parameter files.

To keep it manageable, it is divided into the following parts:

- The new complete project structure
- The content of each Bicep module
- The new orchestrator main.bicep
- The per‑environment parameters
- Important deployment notes

infrastructure/
│
├── main.bicep
│
├── modules/
│   ├── certificates.bicep
│   ├── functionapp-auth.bicep
│   ├── functionapp-aux.bicep
│   ├── naming.bicep
│   ├── identity.bicep
│   ├── keyvault.bicep
│   ├── keyvault-access.bicep
│   ├── storage.bicep
│   ├── appplan.bicep
│   ├── monitoring.bicep
│   └── support-deployment-keyvaultcert.ps1   ← if you use option A
│
└── params/
    ├── dev.json
    ├── test.json
    └── prod.json

## Deployment Instructions

Login:
az login

From script:
chmod +x deploy.sh
./deploy.sh

With the CLI:
az group delete --name rg-dev-meetings --yes --no-wait   (only if it already exists)
az group create --name rg-dev-meetings --location westeurope
az deployment group create --resource-group rg-dev-meetings --template-file main.bicep --parameters @params/dev.json

## Notes
The structure is designed to scale cleanly across multiple environments.
No code changes are required when switching environments—only the parameter file changes.
The support-deployment-keyvaultcert.ps1 script is only needed if you choose the Key Vault certificate deployment option A.
