# git-who-owns

Show which teams own a file based on CODEOWNERS.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `file` | File path to check ownership for (required) |

## Examples

```bash
git who-owns app/models/user.rb
```

## How it works

Parses the repository's CODEOWNERS file to determine which team(s) are responsible for a given file path.

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
