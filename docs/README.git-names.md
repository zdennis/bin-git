# git-names

Show changed filenames with their status (Added/Modified/Deleted). Uses `git diff --name-status` to display both the change type and filename.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `ref` | Git reference or range (default: main..HEAD) |

## Examples

```bash
# List files changed between this branch and main
git names

# List files in the last two commits
git names HEAD~2

# List files in a custom commit range
git names abc..xyz
```

Output shows status prefix: `A` (added), `M` (modified), `D` (deleted).

## See Also

- [git-changed-files](README.git-changed-files.md) - List changed files (names only)
- [git-open-files](README.git-open-files.md) - Open changed files in editor

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
