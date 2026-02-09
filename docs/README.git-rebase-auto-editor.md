# git-rebase-auto-editor

A no-op editor for automated rebases. Used as `GIT_SEQUENCE_EDITOR` to automatically accept the default rebase todo list.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Use with GIT_SEQUENCE_EDITOR
GIT_SEQUENCE_EDITOR=git-rebase-auto-editor git rebase -i HEAD~3
```

## See Also

- [git-rebase-sha](README.git-rebase-sha.md) - Uses this internally
- [git-rebase-edit-sha](README.git-rebase-edit-sha.md) - Rebase with commits marked for edit

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
