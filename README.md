![Azure Windows Server AD Lab](azure-windows-server-ad-lab-banner.jpg)
# Azure Active Directory Lab

A portfolio lab for building an Azure-hosted Windows Server domain with PowerShell.

## Current status

**Repository scaffold complete. Azure deployment intentionally not started by this repository update.**

The scripts are ready for manual review. Nothing in this repository runs automatically, and no workflow deploys resources.

## Planned environment

| Component | Planned value |
|---|---|
| Azure region | Central US |
| Resource group | `rg-adlab` |
| Virtual network | `vnet-adlab` (`10.10.0.0/16`) |
| AD subnet | `snet-ad` (`10.10.1.0/24`) |
| Domain controller | `DC01` |
| Private IP | `10.10.1.4` |
| AD DNS domain | `corp.brookelab.test` |
| NetBIOS name | `BROOKELAB` |

## What is included

- Reusable Azure infrastructure scripts
- Windows Server and Active Directory setup scripts
- Example users, groups, and memberships with fake data only
- Group Policy creation and validation templates
- Written documentation for every project stage
- Troubleshooting and security notes
- Neutral hooks for Codex, OpenCode, Copilot, Continue, or another LLM
- A review-bundle exporter that produces one Notepad-friendly text file

## Repository map

```text
config/                    Lab settings used by the scripts
data/                      Fake CSV input examples
docs/                      Build and design documentation
integrations/              Optional AI-tool context and adapter examples
powershell/azure/          Azure resource templates
powershell/active-directory/ Windows Server and AD templates
powershell/tests/          Offline repository checks
review-notes/              Plain-text review notes
screenshots/               Milestone evidence added during the real build
tools/                     Local helper tools
```

## Review before using Azure

1. Open [`review-notes/REVIEW_NOTES.txt`](review-notes/REVIEW_NOTES.txt) in Notepad.
2. Review [`config/lab.config.psd1`](config/lab.config.psd1).
3. Run the offline repository test:

   ```powershell
   ./powershell/tests/Test-Repository.ps1
   ```

4. Read [`docs/02-azure-infrastructure.md`](docs/02-azure-infrastructure.md).
5. When you are ready later, run Azure scripts one at a time in numeric order.

## Safety rules

- Never commit passwords, public home IP addresses, tokens, tenant IDs, or subscription IDs.
- The RDP source IP must be provided at run time.
- Scripts do not call `Connect-AzAccount` or sign in for you.
- VM and AD changes require explicit manual execution.
- Use `-WhatIf` where the script supports it.
- Stop the VM when it is not being used to control student-subscription costs.

## Optional AI review tools

AI tools are not required and are disabled by default. See [`integrations/README.md`](integrations/README.md). The repository contains instruction files and example adapter settings, but no API key and no automatic LLM call.

## Planned build order

1. Review and validate the repository locally.
2. Build Azure networking and the VM.
3. Configure Windows Server.
4. Create the forest and directory structure.
5. Add fake lab identities and groups.
6. Create and test Group Policy.
7. Capture milestone screenshots and validation output.

