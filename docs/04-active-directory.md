# Active Directory

## Goal

Promote `DC01` into the first domain controller for `corp.brookelab.test` and create a clean OU structure.

## Scripts

1. `03-create-forest.ps1` creates the forest and installs DNS.
2. `04-create-ous.ps1` creates the root OU and child OUs.
3. `09-validate-ad.ps1` reads the resulting domain, forest, DC, OU, and DNS state.

## Planned OU structure

```text
OU=Brookelab
├── OU=Users
├── OU=Groups
├── OU=Workstations
├── OU=Servers
└── OU=Service Accounts
```

## Forest credential rule

The Directory Services Restore Mode password is requested as a `SecureString` at run time. It must never be written into a script, CSV, screenshot, transcript, or commit.

## Lab versus production

This is a single-DC learning design. Production would require redundancy, backup and recovery planning, monitoring, restricted administration paths, patch controls, and a formal identity lifecycle.

