# git-link-usages

Search for a pattern in the codebase and output markdown-formatted links to GitHub for each match. Useful for generating documentation with clickable references to code.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `pattern` | The search pattern (required) |

## Examples

```bash
# Find usages and generate links
git link-usages "MyClass"
```

Output:
```markdown
[./app/models/user.rb#L42](https://github.com/org/repo/blob/main/app/models/user.rb#L42)
```

## See Also

- [git-file-url](README.git-file-url.md) - Generate GitHub URL for a specific file
- [git-ignore-dirs-for-grep](README.git-ignore-dirs-for-grep.md) - Used internally for filtering

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
