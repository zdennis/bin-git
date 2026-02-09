# git-fixup-n-rebase

Create a fixup commit and immediately rebase to squash it. Combines `git fixup` and `git rebase-sha` into one step.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha` | The commit SHA to fixup and rebase onto (required) |

## Examples

```bash
# Stage changes, then fixup and rebase in one step
git add file.txt
git fixup-n-rebase abc1234
```

## See Also

- [git-fixup](README.git-fixup.md) - Create a fixup commit
- [git-rebase-sha](README.git-rebase-sha.md) - Interactive rebase from a commit

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
