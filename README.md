# Debug Action

Prints comprehensive debug information about the GitHub Actions runner environment, contexts, environment variables, and PowerShell state.

> [!CAUTION]
> This action exposes environment variables and contexts, which may include sensitive information or secrets. GitHub attempts to mask
> secrets in logs, but if a secret contains newlines (common with private keys) due to PowerShell's formatting, GitHub masking may fail and
> inadvertently expose the secret.

## Usage

### Inputs

This action does not currently require any inputs.

### Secrets

This action does not explicitly require secrets but may display environment variables or contexts containing sensitive information. Use with caution.

### Outputs

This action does not provide outputs.

## Example

```yaml
jobs:
  Get-Debug:
    runs-on: ubuntu-latest
    steps:
      - name: Debug
        uses: PSModule/Debug@v1
```

## Information Displayed

- [GitHub Context](https://docs.github.com/en/actions/learn-github-actions/contexts)
- [Environment Variables](https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables)
- GitHub event payload details
- PowerShell environment details including:
  - Variables
  - Installed Modules
  - Execution context
  - Host details
  - Invocation details
  - PowerShell session options
  - PowerShell version details
