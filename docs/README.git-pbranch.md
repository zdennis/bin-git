# git-pbranch

Alias for [git-previous-branch](README.git-previous-branch.md). Output the previously checked out branch.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Show previous branch
git pbranch

# Switch to previous branch
git checkout $(git pbranch)
```

## See Also

- [git-previous-branch](README.git-previous-branch.md) - The full command
- [git-cbranch](README.git-cbranch.md) - Alias for git-current-branch

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
