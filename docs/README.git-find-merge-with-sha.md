# git-find-merge-with-sha

Find the merge commit that introduced a given commit to main. Useful for tracking when a commit was merged.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha` | The commit SHA to find the merge for (required) |

## Examples

```bash
# Find when commit abc1234 was merged
git find-merge-with-sha abc1234
```

## See Also

- [git-find-pr-for-sha](README.git-find-pr-for-sha.md) - Find the PR for a commit
- [git-whatadded](README.git-whatadded.md) - Find when a file was added

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
