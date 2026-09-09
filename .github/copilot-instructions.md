# Copilot instructions

- Treat this as an un-deployed learning lab unless the user proves otherwise.
- Never run Azure, Windows Server, or Active Directory scripts automatically.
- Never add passwords, tokens, subscription IDs, tenant IDs, real identities, or public home IP addresses.
- Keep the numbered build order and use `config/lab.config.psd1` as the source of planned values.
- Prefer offline parsing and repository checks.
- Keep PowerShell readable and compatible with PowerShell 7 for Azure scripts and Windows PowerShell 5.1 for server-side scripts.
- Preserve `SupportsShouldProcess` on scripts that change state.
- Update the matching document when behavior changes.
- Read `AGENTS.md`, `SECURITY.md`, and `integrations/repository-context.md` before proposing infrastructure changes.

