# git-clone-github

Clone a GitHub repository using SSH with shorthand notation. Instead of typing the full URL, just provide `org/repo`.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `org/repo` | GitHub organization and repository name |

## Examples

```bash
git clone-github rails/rails
git clone-github ruby/ruby
git clone-github anthropics/anthropic-sdk-python
```

Expands to: `git clone git@github.com:org/repo`

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
