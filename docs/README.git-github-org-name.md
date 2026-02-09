# git-github-org-name

Extract and print the GitHub organization or username from the repository URL. For `github.com/rails/rails`, returns `rails`.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Get org name
git github-org-name

# Use in scripts
org=$(git github-org-name)
```

## See Also

- [git-repos-name](README.git-repos-name.md) - Output the full org/repo name
- [git-project](README.git-project.md) - Output the project name
- [git-url](README.git-url.md) - Get the repository URL

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
