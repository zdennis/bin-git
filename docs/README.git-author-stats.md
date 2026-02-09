# git-author-stats

Show commit statistics grouped by author for specific paths. Uses `git shortlog` to display commit counts and author information for files or directories.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `path` | One or more file or directory paths (required) |

## Examples

```bash
# Stats for a directory
git author-stats app/

# Stats for specific files
git author-stats file1.rb file2.rb

# Stats for multiple paths
git author-stats app/models/ lib/
```

## See Also

- [git-list-authors](README.git-list-authors.md) - List all commit authors in the repository

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
