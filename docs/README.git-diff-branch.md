# git-diff-branch

Show range-diff between your current branch and its upstream (or another ref). Uses `git range-diff` to compare commits, which is useful for seeing if changes are meaningful or just SHA/message updates from a rebase.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `base-ref` | Base reference to compare against (default: `@{u}` - upstream) |

## Examples

```bash
# Compare against upstream
git diff-branch

# Compare against main branch
git diff-branch main

# Compare against a specific branch
git diff-branch origin/develop
```

## See Also

- [git-compare-url](README.git-compare-url.md) - Generate GitHub compare URL
- [git-review](README.git-review.md) - Review commits not yet pushed

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
