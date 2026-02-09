# git-pushf

Force push with `--force-with-lease` (safer force push). Fails if the remote has been updated since your last fetch, preventing accidental overwrites.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

Any additional arguments are passed through to `git push`.

## Examples

```bash
# Force push current branch safely
git pushf

# Force push to a specific remote
git pushf origin
```

## See Also

- [git-pushr](README.git-pushr.md) - Push and set upstream

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
