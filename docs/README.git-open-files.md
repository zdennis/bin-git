# git-open-files

Find files matching a pattern and open them on GitHub in your browser.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `pattern` | File name pattern to search for (required) |

## Examples

```bash
# Open all files containing "user" in the name
git open-files user

# Open all controller files
git open-files controller
```

## See Also

- [git-open-file-remote](README.git-open-file-remote.md) - Open a specific file
- [git-changed-files](README.git-changed-files.md) - List changed files

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
