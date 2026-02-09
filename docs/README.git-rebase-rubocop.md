# git-rebase-rubocop

Run rubocop on each commit during an interactive rebase. Useful for ensuring code style compliance across all commits.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Rebase and run rubocop on each commit
git rebase -i --exec 'git-rebase-rubocop' main
```

## See Also

- [git-rubocop-branch](README.git-rubocop-branch.md) - Run rubocop on changed files

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
