# git-rollback

Soft reset HEAD by N commits, keeping changes staged. Useful for undoing commits while preserving your work.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `n` | Number of commits to roll back (default: 1) |

## Examples

```bash
# Roll back one commit
git rollback

# Roll back 3 commits
git rollback 3
```

## See Also

- [git-amend](README.git-amend.md) - Amend the last commit
- [git-backup-branch](README.git-backup-branch.md) - Create backup before risky operations

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
