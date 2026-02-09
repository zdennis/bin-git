# git-changed-files

List files changed in the current branch vs main. Outputs file paths that can be piped to other tools like rubocop, rspec, or editors. Supports filtering by file type and including related spec files.

## Options

| Option | Description |
|--------|-------------|
| `-f`, `--file-type=TYPE` | Filter by file extension (can specify multiple) |
| `-l`, `--list` | Show files in table format (Added/Modified/Deleted) |
| `--pattern=PATTERN` | Filter by filename pattern |
| `-i`, `--include-specs` | Include spec files for changed implementation files |
| `-n`, `--dry-run` | Show what would be done without doing it |
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# List all changed files
git changed-files

# List only Ruby files
git changed-files -f rb

# List with table format showing Added/Modified/Deleted
git changed-files -l

# Include spec files for changed implementation files
git changed-files -i

# Filter by multiple file types
git changed-files -f rb,erb

# Use with other tools
rubocop $(git changed-files -f rb)
rspec $(git changed-files --pattern _spec.rb)
```

## See Also

- [git-changed-specs](README.git-changed-specs.md) - List spec files for changed source files
- [git-names](README.git-names.md) - Show changed filenames with their status
- [git-open-files](README.git-open-files.md) - Open changed files in your editor
- [git-rubocop-branch](README.git-rubocop-branch.md) - Run rubocop on changed files

## Last analyzed

2025-02-08 | 6b2394a22f5c6b0c96c55a18492db7c2f96838bd
