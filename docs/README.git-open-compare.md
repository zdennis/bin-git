# git-open-compare

Open GitHub compare view in your browser to see differences between two branches.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `base` | Base branch (default: main) |
| `head` | Head branch (default: current branch) |

## Examples

```bash
# Compare current branch against main
git open-compare

# Compare against specific base
git open-compare develop

# Compare two specific branches
git open-compare main feature-branch
```

## See Also

- [git-compare-url](README.git-compare-url.md) - Get the URL without opening browser
- [git-diff-branch](README.git-diff-branch.md) - Show range-diff in terminal

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
