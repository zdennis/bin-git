# git-1

Show commits in oneline format. By default, shows commits on the current branch that aren't in main. Accepts optional ref arguments for viewing specific ranges or recent commits.

## Options

| Option | Description |
|--------|-------------|
| `--author`, `-a` | Include author name in the output |
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Show commits on this branch vs main
git 1

# Show commits with author
git 1 --author

# Show last 5 commits
git 1 HEAD~5

# Show commits in a range
git 1 abc123..def456
```

## See Also

- [git-1m](README.git-1m.md) - Show commits on current branch not in main (similar but different default behavior)
- [git-1sha](README.git-1sha.md) - Output just the SHA of the last commit
- [git-oneline](README.git-oneline.md) - Show git log in oneline format with graph

## Last analyzed

2025-02-08 | d4678e1a03fc4d077ddcb4aebe0c12647c204672
