# git-open-file-remote

Open a file from the repository on GitHub in your browser.

## Options

| Option | Description |
|--------|-------------|
| `-m`, `--main` | Open on main branch instead of current branch |
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Open file on current branch
git open-file-remote spec/models/user_spec.rb

# Open file on main branch
git open-file-remote -m spec/models/user_spec.rb
```

## See Also

- [git-file-url](README.git-file-url.md) - Get the URL without opening browser
- [git-open-files](README.git-open-files.md) - Open files matching a pattern

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
