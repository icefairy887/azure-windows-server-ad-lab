# Lab Architecture

## Purpose

The lab models a small organization with one Azure virtual network and one Windows Server domain controller. It is intentionally small enough for an Azure for Students subscription while still showing infrastructure, identity, DNS, policy, and automation skills.

## Logical design

```text
Azure subscription
└── rg-adlab
    ├── vnet-adlab                    10.10.0.0/16
    │   └── snet-ad                   10.10.1.0/24
    │       └── nic-dc01              10.10.1.4 static
    │           └── DC01
    ├── nsg-dc01                      restricted RDP rule
    └── pip-dc01                      temporary administration path

DC01
├── Windows Server 2025
├── DNS
└── Active Directory Domain Services
    └── corp.brookelab.test
```

## Design decisions

- `centralus` is used because the student subscription allows it.
- A static private address keeps DNS and domain-controller references stable.
- RDP is limited to an address supplied at run time and is never stored in Git.
- One domain controller is acceptable for a learning lab, but not for production.
- The `.test` suffix prevents the lab name from pretending to be a public production domain.

## Boundary

The repository describes and automates the planned build. Its presence on GitHub does not mean the infrastructure has been deployed.

