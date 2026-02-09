# git-pull-url

Get the GitHub URL for a pull request. If no PR number given, returns URL to create a new PR from current branch.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `pr-number` | Pull request number (optional) |

## Examples

```bash
# URL to create new PR from current branch
git pull-url

# URL for existing PR #123
git pull-url 123
```

## See Also

- [git-open-pull](README.git-open-pull.md) - Open PR in browser

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
