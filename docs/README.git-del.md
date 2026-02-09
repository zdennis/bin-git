# git-del

Stage deleted files for commit. When you delete files with `rm` instead of `git rm`, this command finds them and runs `git rm` to stage the deletions.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Delete files and stage the deletions
rm file1.txt file2.txt
git del
git commit -m "Remove files"
```

## How it works

Finds files showing as deleted in `git status` (` D` status) and runs `git rm` on each.

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
