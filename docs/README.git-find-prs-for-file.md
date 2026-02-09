# git-find-prs-for-file

Find all pull requests that modified a specific file. Shows both open and closed PRs with their status, author, date, and URL.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `FILE` | One or more file paths to search for |

## Examples

```bash
# Find PRs that modified a file
git find-prs-for-file app/models/user.rb

# Find PRs for multiple files
git find-prs-for-file app/models/user.rb app/controllers/users_controller.rb
```

## How it works

Uses `git log` to find commits that touched the file(s), then queries the GitHub API via `gh` to find associated pull requests.

**Requires:** GitHub CLI (`gh`) to be installed and authenticated.

## See Also

- [git-find-pr-for-sha](README.git-find-pr-for-sha.md) - Find the PR for a specific commit
- [git-whatadded](README.git-whatadded.md) - Find the commit that added a file
- [git-author-stats](README.git-author-stats.md) - Show author statistics for paths

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
