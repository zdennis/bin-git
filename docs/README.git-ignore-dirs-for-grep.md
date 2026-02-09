# git-ignore-dirs-for-grep

Generate `--exclude-dir` flags for grep from `.gitignore`. Outputs flags that can be used with command substitution to make grep respect gitignore patterns.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Use with grep
grep -r "pattern" $(git ignore-dirs-for-grep) .
```

## See Also

- [git-ignore-files-for-grep](README.git-ignore-files-for-grep.md) - Generate `--exclude` flags for files
- [git-link-usages](README.git-link-usages.md) - Uses these ignore patterns

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
