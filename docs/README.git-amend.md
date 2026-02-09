# git-amend

Amend the last commit without changing its message. A shorter way to run `git commit --amend -C HEAD`.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

Any additional arguments are passed through to `git commit`.

## Examples

```bash
# Amend the last commit with staged changes
git amend

# Amend and include all modified tracked files
git amend -a

# Amend with specific files
git amend -- file1.txt file2.txt
```

## See Also

- [git-fixup](README.git-fixup.md) - Create a fixup commit for a previous commit
- [git-rollback](README.git-rollback.md) - Soft reset HEAD by N commits

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
