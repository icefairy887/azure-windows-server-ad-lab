# Azure Infrastructure

## Goal

Create the resource container, network, security boundary, public IP, network interface, and Windows Server VM used by the lab.

## Script order

| Script | Result |
|---|---|
| `01-create-resource-group.ps1` | Creates `rg-adlab` |
| `02-create-network.ps1` | Creates `vnet-adlab` and `snet-ad` |
| `03-create-nsg.ps1` | Creates `nsg-dc01` and a restricted RDP rule |
| `04-create-public-ip.ps1` | Creates `pip-dc01` |
| `05-create-nic.ps1` | Creates `nic-dc01` |
| `06-set-static-private-ip.ps1` | Assigns `10.10.1.4` |
| `07-create-dc01-vm.ps1` | Defines and creates the Windows Server VM |

## Prerequisites

- An active Azure subscription
- PowerShell 7 or Azure Cloud Shell
- The `Az.Accounts`, `Az.Resources`, `Az.Network`, and `Az.Compute` modules
- A selected Azure context with permission to create resources
- A strong VM administrator credential supplied interactively

## RDP source address

The NSG script requires `-AllowedRdpSourceIp`. Supply only the current public IPv4 address, without `/32`; the script adds the prefix. The address is not saved in this repository.

Example for a later deployment:

```powershell
./03-create-nsg.ps1 -AllowedRdpSourceIp '203.0.113.10' -WhatIf
```

The example address is reserved for documentation and is not a real home address.

## Verification

After each later deployment step, check the object in Azure before running the next script. Record only non-sensitive evidence in `screenshots/` and `docs/07-validation.md`.

## Cost boundary

Creating the VM and public IP can consume subscription credit. This repo update stops before those actions.

