# git-1sha

Print short SHAs of commits on the current branch since it diverged from main. Outputs one SHA per line, making it useful for scripting and piping to other commands.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `ref` | Git reference (default: HEAD) |

## Examples

```bash
# Show SHAs of commits on this branch
git 1sha

# Show SHAs up to a specific branch
git 1sha feature-branch

# Count commits on this branch
git 1sha | wc -l
```

## See Also

- [git-1](README.git-1.md) - Show commits in oneline format
- [git-1m](README.git-1m.md) - Show commits on current branch not in main
- [git-copy-sha](README.git-copy-sha.md) - Copy the current commit SHA to clipboard

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
