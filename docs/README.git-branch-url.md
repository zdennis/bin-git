# git-branch-url

Get the GitHub URL for viewing a branch. Outputs the URL to stdout for copying or piping to other commands.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `branch` | Branch name (default: current branch) |

## Examples

```bash
# URL for current branch
git branch-url

# URL for a specific branch
git branch-url feature/new-feature
```

## See Also

- [git-open-branch](README.git-open-branch.md) - Open the branch URL in your browser
- [git-tree-url](README.git-tree-url.md) - Get the GitHub tree URL
- [git-url](README.git-url.md) - Get the repository URL

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
