# git-rebase-sha

Interactive rebase starting from a specific commit. Headless—no need to manually edit the rebase todo list.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha` | The commit SHA to rebase from (required) |

## Examples

```bash
# Interactive rebase from a specific commit
git rebase-sha abc1234
```

## See Also

- [git-rebase-branch](README.git-rebase-branch.md) - Rebase from merge-base with main
- [git-edit-sha](README.git-edit-sha.md) - Mark commits for editing
- [git-rib](README.git-rib.md) - Interactive rebase on main

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
