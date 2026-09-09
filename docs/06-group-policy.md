# Group Policy

## Goal

Create small, explainable GPO objects and optionally link them only after review.

## Planned GPOs

| GPO | Intended target | Purpose |
|---|---|---|
| `Brookelab - Workstation Baseline` | Workstations OU | Future workstation settings |
| `Brookelab - User Baseline` | Users OU | Future user settings |
| `Brookelab - Server Baseline` | Servers OU | Future server settings |

## Safe default

`08-create-gpos.ps1` creates the GPO objects but does not link them unless `-LinkPolicies` is supplied. It does not populate security settings. That keeps the first run reversible and easy to inspect.

## Validation later

- Review each GPO in Group Policy Management.
- Confirm links exist only on the intended OU.
- Use `gpresult /h` on a joined test machine before claiming a policy is applied.
- Do not edit the Default Domain Policy for ordinary lab settings.

