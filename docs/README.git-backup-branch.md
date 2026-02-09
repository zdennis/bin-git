# git-backup-branch

Create timestamped backup copies of branches. Backups are named with a `.bak.YYYY-MM-DD` suffix and can include optional tags. Supports listing, restoring, diffing, and cleaning up old backups.

## Commands

### Create backup (default)

```bash
# Backup current branch
git backup-branch

# Backup specific branch
git backup-branch features/sign-up

# Backup the remote branch for the current branch
git backup-branch -r

# Backup with a descriptive tag
git backup-branch -t "before main rebase"
```

### List backups

```bash
# List backups for current branch
git backup-branch -l

# List backups for specific branch
git backup-branch -l features/sign-up

# List all backup branches in the repository
git backup-branch -l --all
```

### Restore from backup

```bash
# Restore current branch from most recent backup
git backup-branch --restore

# Restore a specific branch
git backup-branch --restore features/sign-up

# Force restore (overwrites uncommitted changes)
git backup-branch --restore --force
```

### Delete backups

```bash
# Delete all backups for current branch
git backup-branch --delete

# Delete backups older than 30 days
git backup-branch --delete --older-than=30

# Delete backups for a specific branch
git backup-branch --delete features/sign-up
```

### Show diff since backup

```bash
# Show commits since last backup
git backup-branch --diff

# Show diff for a specific branch
git backup-branch --diff features/sign-up
```

## Options

| Option | Description |
|--------|-------------|
| `-t`, `--tag=TAG` | Add a descriptive tag to the backup name |
| `-l`, `--list` | List backup branches |
| `-a`, `--all` | List all backups in repository (use with `--list`) |
| `-r`, `--remote` | Use the remote branch instead of local |
| `--restore` | Restore a branch from backup |
| `-f`, `--force` | Force restore even with uncommitted changes |
| `-d`, `--delete` | Delete backup branches |
| `--older-than=DAYS` | Delete backups older than N days |
| `--diff` | Show commits between current branch and backup |
| `-q`, `--quiet` | Suppress output (just print backup name) |
| `-h`, `--help` | Show help message |
| `-v`, `--version` | Show version information |

## How it works

Backup branches follow the naming convention: `<branch>.bak[N].<date>[.tag]`

For example:
- `feature/login.bak.2025-02-08`
- `feature/login.bak2.2025-02-08` (second backup same day)
- `feature/login.bak.2025-02-08.before-rebase` (with tag)

When multiple backups exist for the same day, a numeric suffix is added to avoid collisions.

## See Also

- [git-current-branch](README.git-current-branch.md) - Output the current branch name
- [git-rollback](README.git-rollback.md) - Soft reset HEAD by N commits

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
