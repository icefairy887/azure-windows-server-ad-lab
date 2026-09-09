# Infrastructure Repository Review Prompt

Review this Azure Active Directory lab as code only.

Do not connect to Azure. Do not run any deployment, Windows Server, AD DS, DNS, user, group, or GPO command. Do not request or generate credentials.

Check:

1. PowerShell parse errors and broken paths.
2. Mismatches between `config/lab.config.psd1`, scripts, and documentation.
3. Non-idempotent behavior that could create duplicates.
4. Security problems, especially RDP exposure and secret storage.
5. Incorrect Azure or AD dependency order.
6. Missing validation or rollback notes.
7. Statements that claim resources already exist when they are only planned.

Return findings ordered by severity. For each finding, name the file, explain the concrete failure mode, and suggest the smallest safe fix. End with a short go/no-go recommendation for beginning the manual Azure build.

