# git-open-pull

Open or create a pull request for the current branch. With no arguments, opens existing PR or creates a new one. Can also open a specific PR by number or find the PR containing a commit.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha-or-ref` | SHA, branch, or PR number (optional) |

## Examples

```bash
# Open/create PR for current branch
git open-pull

# Open PR #123
git open-pull 123

# Open PR containing a specific commit
git open-pull abc1234
```

**Requires:** GitHub CLI (`gh`) to be installed.

## See Also

- [git-pull-url](README.git-pull-url.md) - Get PR URL
- [git-open-pulls](README.git-open-pulls.md) - Open PRs page

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
