# git-1m

Show commits on the current branch that aren't in main. This is a convenience wrapper around `git 1` that provides a quick way to see what work exists on your branch.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

Any additional arguments are passed through to `git 1`.

## Examples

```bash
# Show commits on this branch not in main
git 1m

# Show with author info
git 1m --author
```

## See Also

- [git-1](README.git-1.md) - The underlying command this wraps
- [git-m1](README.git-m1.md) - Show the last commit on main branch
- [git-1sha](README.git-1sha.md) - Output just the SHA of the last commit

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
