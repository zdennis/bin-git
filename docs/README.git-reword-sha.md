# git-reword-sha

Reword commit messages via interactive rebase. Works with single SHAs, multiple SHAs, or ranges.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha` | One or more commit SHAs to reword |
| `sha-range` | A range of commits (e.g., abc123..def456) |

## Examples

```bash
# Reword a single commit
git reword-sha abc1234

# Reword multiple commits
git reword-sha abc1234 def5678

# Reword a range of commits
git reword-sha abc1234..def5678
```

## See Also

- [git-edit-sha](README.git-edit-sha.md) - Edit commits (code changes)
- [git-rebase-sha](README.git-rebase-sha.md) - Interactive rebase from SHA

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
