# git-find-pr-for-sha

Find the pull request that introduced a specific commit. Searches the merge history and returns the GitHub PR URL.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha` | The commit SHA to find the PR for (required) |

## Examples

```bash
# Find PR for commit abc1234
git find-pr-for-sha abc1234

# Open the PR in browser
open $(git find-pr-for-sha abc1234)
```

## See Also

- [git-find-merge-with-sha](README.git-find-merge-with-sha.md) - Find the merge commit for a SHA
- [git-find-prs-for-file](README.git-find-prs-for-file.md) - Find PRs that modified a file
- [git-open-sha](README.git-open-sha.md) - Open a commit on GitHub

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
