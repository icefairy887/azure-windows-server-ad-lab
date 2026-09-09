# Security

This repository is designed to contain lab code only.

## Never commit

- Passwords or password hashes
- API keys, tokens, or connection strings
- Public home IP addresses
- Azure subscription or tenant identifiers
- Real employee, family, or customer data
- RDP files containing credentials
- Certificates with private keys

## Credential handling

Scripts request credentials or secure strings at run time. Example CSV files contain fictional identities only. If a secret is committed, revoke or rotate it before removing it from Git history.

## Network exposure

RDP must be limited to one explicitly supplied `/32` source address. Do not replace that rule with `0.0.0.0/0`. Re-check the NSG before starting the VM.

