![Azure Windows Server AD Lab](azure-windows-server-ad-lab-banner.jpg)

# Azure Windows Server + Active Directory Cloud Lab

A hands-on Azure infrastructure lab demonstrating Windows Server, IaaS, PaaS, networking, identity, RBAC, security, encryption, monitoring, and Active Directory concepts.

## Current Status

### Objective 1 — IaaS and PaaS
- [x] Add workload subnet
- [x] Build Windows VM as IaaS
- [x] Configure NSG rules
- [x] Deploy Azure App Service as PaaS

### Objective 2 — Security and Compliance
- [x] Configure Microsoft Entra ID access
- [x] Configure RBAC
- [x] Enable MFA
- [x] Add Azure Key Vault
- [x] Verify VM disk encryption
- [ ] Finish centralized VM logging
- [ ] Review Microsoft Defender for Cloud

## Environment

| Component | Current value |
|---|---|
| Resource group | `rg-adlab` |
| Original Azure VNet | `vnet-adlab` |
| AD subnet | `snet-ad` |
| Workload VM | `vm-workload01` |
| VM operating system | Windows Server 2025 Datacenter: Azure Edition |
| VM region | Belgium Central |
| VM security group | `vm-workload01-nsg` |
| App Service | `app-adlab-workload01` |
| App Service runtime | Python 3.12 / Linux |
| App Service region | Belgium Central |
| Entra security group | `grp-adlab-admins` |
| Key Vault | `kv-adlab-brooke01` |
| Log Analytics workspace | `law-adlab` |
| Log Analytics region | Canada Central |

## Architecture Work Completed

### Networking
- Created Azure virtual networking for the lab
- Created separate AD and workload subnet designs
- Configured NAT Gateway resources for controlled outbound connectivity
- Configured Network Security Groups
- Restricted VM RDP access with a custom inbound rule

### IaaS
Deployed `vm-workload01` as the Windows Server IaaS workload.

The VM provides hands-on experience with:

- Windows Server administration
- Azure virtual machines
- Network interfaces
- NSGs
- Managed disks
- Azure Monitor
- PowerShell
- Cloud infrastructure troubleshooting

### PaaS
Deployed `app-adlab-workload01` using Azure App Service.

A Python Flask application was packaged and deployed through Azure CLI and verified successfully in a browser.

Example application output:

```text
Azure App Service PaaS lab is working.

Identity and Access
Created Entra security group grp-adlab-admins
Added the lab administrator account to the group
Assigned the Contributor RBAC role to the group at rg-adlab
Enabled MFA
Used group-based access instead of assigning permissions only to individual users
Security and Data Protection
Created Azure Key Vault
Configured Key Vault to use Azure RBAC
Verified the Windows VM OS disk uses server-side encryption
Encryption uses an Azure platform-managed key
Restricted inbound VM administration traffic with NSG rules
Monitoring and Logging
Created Log Analytics workspace law-adlab
Connected App Service diagnostic logs to Log Analytics
Enabled App Service HTTP, application, console, audit, platform, and authentication logs
Installed AzureMonitorWindowsAgent on vm-workload01
VM Data Collection Rule configuration is still being completed
Repository Map
app-service-demo/           Python Flask PaaS demo
config/                     Lab configuration
data/                       Fake lab data
docs/                       Architecture and build documentation
integrations/               Optional AI-tool integration notes
powershell/azure/           Azure infrastructure scripts
powershell/active-directory/ Windows Server / AD scripts
powershell/tests/           Repository validation
review-notes/               Review notes
screenshots/                Build and verification evidence
tools/                      Local helper tools
Evidence

The screenshots/ directory contains evidence from the real Azure build, including:

NAT Gateway deployment
Workload subnet configuration
Windows Server VM deployment
NSG configuration
App Service deployment
Azure CLI deployment output
Running Flask application
Entra group configuration
RBAC assignments
Key Vault deployment
Disk encryption
Monitoring and logging configuration
Skills Demonstrated
Azure IaaS
Azure PaaS
Windows Server
Microsoft Entra ID
Azure RBAC
Network Security Groups
Virtual Networks and subnets
NAT Gateway
Azure Key Vault
MFA
Managed disk encryption
Azure App Service
Python / Flask
Azure CLI
PowerShell
Azure Monitor
Log Analytics
Cloud security and access control
Infrastructure troubleshooting
Safety Rules
Never commit passwords, tokens, public home IP addresses, tenant IDs, or subscription IDs.
Redact sensitive information from screenshots before committing them.
Do not expose RDP broadly to the internet.
Use restricted NSG source addresses for administrative access.
Stop or deallocate lab resources when they are not needed.
Keep production credentials and secrets out of the repository.
Remaining Work
Finish VM Data Collection Rule configuration.
Verify VM logs are flowing into law-adlab.
Review Microsoft Defender for Cloud.
Continue Windows Server / Active Directory configuration.
Add directory users, groups, and Group Policy testing.
Add final architecture diagrams and validation screenshots.