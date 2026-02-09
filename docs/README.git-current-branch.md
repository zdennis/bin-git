# git-current-branch

Output the name of the current git branch without a trailing newline. Designed for scripting and command substitution.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Get current branch
git current-branch

# Use in other commands
git push origin $(git current-branch)
```

## See Also

- [git-cbranch](README.git-cbranch.md) - Alias for this command
- [git-previous-branch](README.git-previous-branch.md) - Output the previously checked out branch
- [git-remote-branch](README.git-remote-branch.md) - Output the remote tracking branch

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
