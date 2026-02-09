# git-oneline

Show git log in oneline format. A shortcut for `git log --oneline`.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

Any additional arguments are passed through to `git log`.

## Examples

```bash
# Show recent commits in oneline format
git oneline

# Show last 5 commits
git oneline -n 5

# Show commits for a specific file
git oneline -- path/to/file
```

## See Also

- [git-1](README.git-1.md) - Show commits between main and HEAD
- [git-1m](README.git-1m.md) - Show commits on current branch not in main

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
