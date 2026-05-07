# Azure SP-Online integrating M365 Meetings Solution v1.x (WORKING ON IT)

## Introduction

This repository contains a complete end‑to‑end solution for managing online meeting reservations across Microsoft 365. It integrates SharePoint Online, Azure, and Microsoft Graph, combining a modern SPFx front‑end with a scalable .NET 8 Azure Functions backend.

The project is organized into clear, domain‑focused folders that separate ALM, infrastructure, provisioning, SPFx components, and backend services. This structure makes the solution easy to maintain, extend, and deploy across multiple environments.

At its core, the solution provides:

- A SharePoint Online user interface built with SPFx, offering a seamless experience for booking and managing meetings.
- A set of Azure Functions (.NET 8) that handle business logic, meeting orchestration, and secure communication with Microsoft Graph.
- A fully modular Azure infrastructure defined in Bicep, supporting dev/test/prod deployments with environment‑specific parameters.
- Automated provisioning scripts to configure SharePoint artifacts, permissions, and application components.
This architecture is designed for organizations that need a reliable, cloud‑native meeting reservation system tightly integrated with Microsoft 365, while maintaining clean separation of concerns and enterprise‑grade deployment practices.

## Infrastructure Deployment – Multi‑Environment Bicep Setup

This project provides a fully refactored, modular, and production‑ready Azure infrastructure deployment using Bicep. 
It supports dev, test, and prod environments without modifying the code, relying instead on per‑environment parameter files.

### Key Components
main.bicep – Orchestrates all modules and defines the full deployment.
modules/ – Contains isolated, reusable Bicep modules for each Azure resource.
params/ – Environment‑specific parameter files.

To keep it manageable, it is divided into the following parts:

- The new complete project structure
- The content of each Bicep module
- The new orchestrator main.bicep
- The per‑environment parameters
- Important deployment notes

### Deployment Instructions

Login:
 ```sh
az login
 ```

From script:
 ```sh
chmod +x deploy.sh
./deploy.sh
 ```
With the CLI:
 ```sh
az group delete --name rg-dev-meetings --yes --no-wait   (only if it already exists)
az group create --name rg-dev-meetings --location westeurope
az deployment group create --resource-group rg-dev-meetings --template-file main.bicep --parameters @params/dev.json
 ```

Notes
The structure is designed to scale cleanly across multiple environments.
No code changes are required when switching environments—only the parameter file changes.
The support-deployment-keyvaultcert.ps1 script is only needed if you choose the Key Vault certificate deployment option A.
