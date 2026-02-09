# git-file-url

Generate GitHub URLs for files. Supports specifying a branch/ref and line numbers or ranges.

## Options

| Option | Description |
|--------|-------------|
| `-r`, `--ref REF` | Branch, tag, or commit SHA (default: current branch) |
| `-l`, `--line LINE` | Line number or range (e.g., `42` or `42:50`) |
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# URL for a single file
git file-url path/to/file.rb

# URL for a file on specific branch
git file-url -r main path/to/file.rb

# URL for a specific line
git file-url -l 42 path/to/file.rb

# URL for a line range
git file-url -l 42:50 path/to/file.rb

# URL for multiple files
git file-url file1.rb file2.rb
```

## See Also

- [git-open-file-remote](README.git-open-file-remote.md) - Open a file on GitHub in browser
- [git-sha-url](README.git-sha-url.md) - Get URL for a commit SHA
- [git-branch-url](README.git-branch-url.md) - Get URL for a branch

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
