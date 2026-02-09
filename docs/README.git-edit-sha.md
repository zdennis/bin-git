# git-edit-sha

Mark commits for editing in an interactive rebase. Works with single SHAs, multiple SHAs, or ranges. An alias for `git-rebase-edit-sha`.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha` | One or more commit SHAs to edit (can use range format) |

## Examples

```bash
# Edit a single commit
git edit-sha abc1234

# Edit multiple commits
git edit-sha abc1234 def5678

# Edit a range of commits
git edit-sha abc1234..def5678
```

## See Also

- [git-rebase-edit-sha](README.git-rebase-edit-sha.md) - The underlying command
- [git-reword-sha](README.git-reword-sha.md) - Reword commit messages
- [git-rebase-sha](README.git-rebase-sha.md) - Interactive rebase from a specific commit

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
