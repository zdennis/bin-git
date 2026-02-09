# git-m1

Show commits on main that are not on the current branch. The inverse of `git 1m`—shows what you're missing from main rather than what you have that main doesn't.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `ref` | Git reference to compare from (default: HEAD) |

## Examples

```bash
# Show commits on main not on this branch
git m1

# Compare from a specific ref
git m1 feature-branch
```

## See Also

- [git-1m](README.git-1m.md) - Show commits on current branch not in main
- [git-1](README.git-1.md) - Show commits in oneline format

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
