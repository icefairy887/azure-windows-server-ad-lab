# Repository instructions for coding agents

## Scope

Help review, document, or improve this Azure Active Directory lab repository.

## Hard stops

- Do not deploy, modify, or delete Azure resources without a direct user request for that exact action.
- Do not execute scripts in `powershell/azure` or `powershell/active-directory` automatically.
- Do not add secrets, credentials, public IP addresses, subscription IDs, or tenant IDs.
- Do not replace fake lab identities with real personal information.
- Do not weaken the RDP source rule to allow the entire internet.

## Review behavior

- Prefer offline syntax and structure checks.
- Explain proposed infrastructure changes before execution.
- Keep scripts readable for a junior Windows/Azure administrator.
- Preserve the numbered build order.
- Update the matching document whenever behavior changes.

## Project facts

- Region: `centralus`
- Resource group: `rg-adlab`
- Domain controller: `DC01`
- Private IP: `10.10.1.4`
- Domain: `corp.brookelab.test`

