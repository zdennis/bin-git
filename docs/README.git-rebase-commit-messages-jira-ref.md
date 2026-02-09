# git-rebase-commit-messages-jira-ref

Add JIRA references to commit messages during rebase. Ensures each commit has a REFERENCES section with a JIRA link.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Environment Variables

| Variable | Description |
|----------|-------------|
| `JIRA_REF` | JIRA ticket ID (e.g., APPS-12345) |

## Examples

```bash
# With env var (recommended)
JIRA_REF=APPS-12345 git rebase -i --exec 'git-rebase-commit-messages-jira-ref' HEAD~5^

# Without env var (prompts for each commit)
git rebase -i --exec 'git-rebase-commit-messages-jira-ref' HEAD~5^
```

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
