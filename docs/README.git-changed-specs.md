# git-changed-specs

List spec files (`*_spec.rb`) that have changed in the current branch vs main. A wrapper around `git changed-files` that filters for spec files.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

Any additional arguments are passed through to `git changed-files`.

## Examples

```bash
# List changed spec files
git changed-specs

# Use with rspec
rspec $(git changed-specs)
```

## See Also

- [git-changed-files](README.git-changed-files.md) - The underlying command this wraps
- [git-rubocop-branch](README.git-rubocop-branch.md) - Run rubocop on changed files

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
