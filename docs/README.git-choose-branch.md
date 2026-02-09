# git-choose-branch

Interactive branch selector. Shows a menu of recent branches and lets you pick one to check out. Uses `git recent` to get the branch list.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Choose from recent branches
git choose-branch
```

## How it works

Runs `git recent` to get a list of recently checked-out branches, then presents them in a numbered menu. Select a branch by number to check it out. The current branch is marked in the list.

Requires the `highline` Ruby gem (auto-installed on first run).

## See Also

- [git-recent](README.git-recent.md) - List recently checked-out branches

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
