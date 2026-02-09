# git-get-main-branch

Determine whether the repository uses `main` or `master` as its primary branch. Checks for `main` first, then falls back to `master`. Used by many other tools in this collection.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Exit codes

| Code | Meaning |
|------|---------|
| 0 | Found main branch (prints branch name) |
| 1 | No main/master branch found |

## Examples

```bash
# Get main branch name
git get-main-branch

# Use in scripts
main_branch=$(git get-main-branch)
git log "$main_branch..HEAD"
```

## See Also

- [git-current-branch](README.git-current-branch.md) - Output the current branch name
- [git-previous-branch](README.git-previous-branch.md) - Output the previously checked out branch

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
