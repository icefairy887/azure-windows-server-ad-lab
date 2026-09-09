# Optional AI Tool Hooks

These files make the repository easier to review with different coding assistants. They do not install a model, call an API, or deploy Azure resources.

## Included hooks

| Tool type | Repository hook |
|---|---|
| Codex and other agent-aware tools | `/AGENTS.md` |
| GitHub Copilot | `/.github/copilot-instructions.md` |
| OpenCode | `/.opencode/commands/review.md` |
| Continue | `/.continue/rules/lab-safety.md` |
| Any chat or local LLM | `integrations/prompts/review-repository.md` and exported review bundle |

## Provider-neutral adapter example

`adapters.example.json` documents possible external tools without enabling any of them. Copy it to an ignored local file only when you decide which tool to use. Keep API keys in environment variables or the tool's secure credential store, never in Git.

## One-file review bundle

Run this locally:

```powershell
./tools/Export-ReviewBundle.ps1
```

It writes `review-bundle.txt`, which can be opened in Notepad or pasted into a tool that does not read repositories directly. The generated file is ignored by Git.

## Required review boundary

An AI review may inspect and suggest changes. It must not execute the Azure or Active Directory scripts unless the user separately and explicitly requests deployment.

