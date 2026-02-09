# git-rebase-sha-bash

Drop into a bash shell during an interactive rebase at a specific commit. Useful for debugging or making manual changes.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha` | The commit SHA to stop at (required) |

## Examples

```bash
# Start rebase and drop into bash at specific commit
git rebase-sha-bash abc1234
```

## See Also

- [git-rebase-sha](README.git-rebase-sha.md) - Interactive rebase from SHA
- [git-edit-sha](README.git-edit-sha.md) - Mark commits for editing

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
