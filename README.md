# Debug

Gets debug information about the environment.

Uses all the contexts, environment variables and PowerShell variables and modules.

- [Contexts | GitHub Docs](https://docs.github.com/en/actions/learn-github-actions/contexts)
- [Variables | GitHub Docs](https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables)

## Usage

### Example

#### Example 1: Get debug information

```yaml
jobs:
  Get-Debug:
    runs-on: ubuntu-latest
    steps:
      - name: Debug
        uses: PSModule/Debug@v1
```
