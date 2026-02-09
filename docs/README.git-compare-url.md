# git-compare-url

Generate a GitHub compare URL for viewing differences between two branches. Outputs the URL to stdout.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `base` | Base branch (default: main/master) |
| `head` | Head branch (default: current branch) |

## Examples

```bash
# Compare current branch against main
git compare-url

# Compare against specific base
git compare-url develop

# Compare two specific branches
git compare-url main feature-branch
```

## See Also

- [git-open-compare](README.git-open-compare.md) - Open the compare URL in your browser
- [git-diff-branch](README.git-diff-branch.md) - Show range-diff between branches

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
