# git-rebase-branch

Rebase the current branch from its divergence point with main. Finds the merge-base and rebases from there.

## Options

| Option | Description |
|--------|-------------|
| `-i`, `--interactive` | Rebase interactively |
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `base-branch` | Base branch to rebase onto (default: main) |

## Examples

```bash
# Rebase current branch onto main
git rebase-branch

# Interactive rebase
git rebase-branch -i

# Rebase onto specific branch
git rebase-branch develop
```

## See Also

- [git-rib](README.git-rib.md) - Interactive rebase on main
- [git-rebase-sha](README.git-rebase-sha.md) - Rebase from specific SHA

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
