# git-anim

Show branches merged into acceptance but not main. The name is an abbreviation: **A**cceptance **N**ot **I**n **M**ain. Useful for tracking what's staged for release in workflows that use an acceptance branch.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Show branches in acceptance not in main
git anim
```

## How it works

Runs `git log main..acceptance` and filters for merge commit messages to show which branches have been integrated into acceptance but not yet released to main.

## See Also

- [git-unmerged](README.git-unmerged.md) - Show branches with commits not merged to main

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
