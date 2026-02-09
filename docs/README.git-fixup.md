# git-fixup

Create a fixup commit for a previous commit. The fixup will be automatically squashed into the target commit during an interactive rebase with `--autosquash`.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Arguments

| Argument | Description |
|----------|-------------|
| `sha` | The commit SHA to create a fixup for (required) |

## Examples

```bash
# Create fixup commit for a specific SHA
git fixup abc1234

# Typical workflow
git add file.txt
git fixup abc1234
git rebase -i --autosquash main
```

## How it works

Runs `git commit --fixup=<sha>`. The resulting commit message is prefixed with `fixup!` followed by the original commit's subject line. During rebase with `--autosquash`, git automatically reorders and marks it for squashing.

## See Also

- [git-fixup-n-rebase](README.git-fixup-n-rebase.md) - Create fixup and immediately rebase
- [git-amend](README.git-amend.md) - Amend the last commit
- [git-rebase-sha](README.git-rebase-sha.md) - Interactive rebase from a commit

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
