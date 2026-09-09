# Validation

## Offline repository checks

Run before Azure deployment:

```powershell
./powershell/tests/Test-Repository.ps1
```

This checks required files, parses every PowerShell script, and scans tracked text for common secret patterns. It does not connect to Azure.

## Azure checks for later

- Resource group exists in `centralus`.
- VNet and subnet CIDRs match the design.
- NSG allows TCP 3389 from only one `/32` address.
- `nic-dc01` has private address `10.10.1.4`.
- VM size and image match the reviewed configuration.

## Active Directory checks for later

Run `09-validate-ad.ps1` on `DC01`. Confirm:

- Domain is `corp.brookelab.test`.
- `DC01` is discoverable as a domain controller.
- DNS service is running.
- Planned OUs exist.
- Sample groups and users exist only after their scripts are run.
- GPO links match the reviewed design.

## Portfolio evidence

Capture milestone screenshots, not secrets or every command. Remove public IP addresses, usernames, subscription IDs, and notification details from screenshots before committing them.

