# git-rebase-edit-sha

Start an interactive rebase with specified commits marked for editing. Works with single SHAs, multiple SHAs, or ranges.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha` | One or more commit SHAs to edit |
| `sha-range` | A range of commits (e.g., abc123..def456) |

## Examples

```bash
# Edit a single commit
git rebase-edit-sha abc1234

# Edit multiple commits
git rebase-edit-sha abc1234 def5678 ghi9012

# Edit a range of commits
git rebase-edit-sha abc1234..def5678
```

## See Also

- [git-edit-sha](README.git-edit-sha.md) - Alias for this command
- [git-reword-sha](README.git-reword-sha.md) - Reword commit messages

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
