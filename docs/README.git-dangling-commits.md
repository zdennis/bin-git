# git-dangling-commits

Find and list dangling commits in the repository. These are commits not reachable from any branch or tag—typically lost due to branch deletion or hard resets. Useful for recovering lost work.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# List all dangling commits
git dangling-commits
```

Output shows full SHA and commit message for each dangling commit.

## How it works

Runs `git fsck --lost-found` to find dangling commits, then shows the oneline description of each.

**Note:** Must be run from the repository root.

## See Also

- [git-stash-find](README.git-stash-find.md) - Search stash entries

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
