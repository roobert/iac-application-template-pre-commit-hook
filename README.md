# IAC Application Template Pre-Commit Hook

A pre-commit hook plugin to run IAC application templating

## Usage

Add the following to `.pre-commit-config.yaml` under the `repos` key:

```
- repo: https://github.com/roobert/iac-application-template-pre-commit-hook
  rev: 0.0.1
  hooks:
    - id: iac-application-template
```
