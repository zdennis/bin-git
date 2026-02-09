# git-my-prs

List your open pull requests in the current repository. Uses the GitHub CLI to query PRs authored by you.

## Quick Start

Set your GitHub username in git config:
```bash
git config --global github.user <your-github-username>
```

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# List your open PRs
git my-prs
```

## How it works

Runs `gh pr ls --author <your-username>` using the username from `git config github.user`.

**Requires:** GitHub CLI (`gh`) to be installed and authenticated.

## See Also

- [git-prs-waiting-for-my-review](README.git-prs-waiting-for-my-review.md) - PRs where your review is requested
- [git-pulls](README.git-pulls.md) - List all pull requests
- [git-open-my-pulls](README.git-open-my-pulls.md) - Open your PRs in browser

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
