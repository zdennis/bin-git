# git-previous-branch

Output the name of the branch you were on before the current one. Parses the reflog to find checkout history.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Show previous branch
git previous-branch

# Switch to previous branch
git checkout $(git previous-branch)
```

## See Also

- [git-pbranch](README.git-pbranch.md) - Alias for this command
- [git-current-branch](README.git-current-branch.md) - Output current branch name
- [git-recent](README.git-recent.md) - List recently checked out branches

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
