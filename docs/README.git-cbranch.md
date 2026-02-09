# git-cbranch

Alias for [git-current-branch](README.git-current-branch.md). Output the name of the current git branch.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Get current branch
git cbranch

# Use in other commands
git push origin $(git cbranch)
```

## See Also

- [git-current-branch](README.git-current-branch.md) - The full command this aliases
- [git-pbranch](README.git-pbranch.md) - Alias for git-previous-branch

## Last analyzed

2025-02-08 | 68886b006d1f9c68d2e85f8cd0e213937c5bd203
