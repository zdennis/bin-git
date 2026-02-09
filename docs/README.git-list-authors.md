# git-list-authors

List unique authors who have modified specific files or directories. Each author appears once, sorted by their most recent commit to that path.

## Options

| Option | Description |
|--------|-------------|
| `-v`, `--verbose` | Show the git command being run |
| `--help`, `-h` | Show help message |
| `--version` | Show version information |

## Examples

```bash
# List authors for a file
git list-authors path/to/some/file

# List authors for a directory
git list-authors app/models/
```

## See Also

- [git-author-stats](README.git-author-stats.md) - Show commit statistics by author

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
