# git-copy-sha

Copy a commit SHA to the clipboard. By default copies the full SHA of the current commit. Supports copying short versions or specific SHAs.

## Options

| Option | Description |
|--------|-------------|
| `-n`, `--num-chars=N` | Copy only the first N characters |
| `-s`, `--short-abbrev` | Copy the short-abbreviated form |
| `--gcb-short` | Copy 7 characters (Google Cloud Build style) |
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Copy the current commit's full SHA
git copy-sha

# Copy the short abbreviated SHA
git copy-sha -s

# Copy 7 characters (Google Cloud Build SHORT_SHA)
git copy-sha --gcb-short

# Copy first 20 characters
git copy-sha -n 20

# Copy a specific SHA
git copy-sha abc1234
```

## How it works

Uses `pbcopy` to copy to the macOS clipboard.

## See Also

- [git-1sha](README.git-1sha.md) - Print SHAs of commits on the current branch
- [git-sha-url](README.git-sha-url.md) - Get the GitHub URL for a commit SHA

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
