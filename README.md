# bin-git

A collection of 88 git helper scripts that extend git with useful shortcuts and automation for common workflows.

## Installation

Add the `bin/` directory to your PATH:

```bash
export PATH="$PATH:/path/to/bin-git/bin"
```

The scripts are designed to work as git subcommands. For example, `git-open-branch` can be invoked as `git open-branch`.

## Scripts Overview

All scripts support `--help` and `--version` flags for documentation and version information.

### Categories

**Branch Management**
- `git-current-branch` / `git-cbranch` - Get current branch name
- `git-previous-branch` / `git-pbranch` - Get previously checked out branch
- `git-remote-branch` / `git-rbranch` - Get remote tracking branch
- `git-choose-branch` - Interactive branch selector
- `git-backup-branch` - Create backup copies of branches

**File Operations**
- `git-changed-files` - List files changed in branch
- `git-changed-specs` - List spec files for changed code
- `git-open-files` - Open changed files in editor

**URL/Browser Operations**
- `git-open-branch` - Open current branch on GitHub
- `git-open-pull` - Open PR for current branch
- `git-open-sha` - Open commit on GitHub
- `git-file-url` - Get GitHub URL for a file
- `git-branch-url` - Get GitHub URL for current branch

**Commit Operations**
- `git-amend` - Amend last commit
- `git-fixup` - Create fixup commit
- `git-reword-sha` - Reword a commit message
- `git-squash-all-commits` - Squash all commits into one

**Rebase Tools**
- `git-rib` - Interactive rebase on main
- `git-rebase-branch` - Rebase current branch on main
- `git-rebase-edit-sha` - Rebase with commits marked for edit
- `git-rebase-rubocop` - Run rubocop during rebase

**Information**
- `git-author-stats` - Show commit statistics by author
- `git-who-owns` - Show code ownership
- `git-list-authors` - List all commit authors

## Notable Behaviors

### git-changed-files Argument Parsing

The `git-changed-files` script has special handling for its argument:

| Argument | Interpretation |
|----------|----------------|
| *(none)* | `main...HEAD` (changes in current branch) |
| `HEAD~3` | Passed through as-is |
| `3` | Converted to `HEAD~3` |
| `abc123...def456` | Passed through as-is (SHA range) |

The numeric shorthand (`3` → `HEAD~3`) is a convenience feature. If you need to pass a SHA that happens to be all digits, use the full range syntax instead.

---

## Developing

### Prerequisites

- Ruby (for Ruby-based scripts and tests)
- Bundler
- Git

### Setup

```bash
# Clone the repository
git clone <repo-url>
cd bin-git

# Install dependencies
bundle install
```

### Project Structure

```
bin-git/
├── bin/           # Git helper scripts (88 scripts)
├── spec/          # RSpec test suites
│   ├── spec_helper.rb
│   └── git-*/     # One directory per script
├── script/        # Development binstubs
├── Gemfile
└── README.md
```

### Running Tests

Use the binstub in `script/` to run tests:

```bash
# Run all tests
script/rspec

# Run tests for a specific script
script/rspec spec/git-changed-files/

# Run with documentation format
script/rspec --format documentation

# Run a single test file
script/rspec spec/git-amend/git_amend_spec.rb
```

Alternatively, use bundle exec:

```bash
bundle exec rspec
```

### Test Goals

The test suite aims to:

1. **Verify CLI contracts** - Every script must support `--version`/`-v` and `--help`/`-h` flags with proper exit codes and output.

2. **Validate error handling** - Scripts should fail gracefully with helpful error messages when given invalid input or run outside a git repository.

3. **Test core functionality** - Where feasible, tests verify the actual behavior of scripts using temporary git repositories.

4. **Document expected behavior** - Tests serve as executable documentation for how each script should behave.

### Test Limitations

Some scripts cannot be fully tested in automated environments:

- **Browser-opening scripts** (`git-open-*`) - Use the `open` command
- **Interactive scripts** (`git-choose-branch`) - Require user input
- **Network-dependent scripts** (`git-add-ignore`) - Download from GitHub
- **Rebase scripts** - Modify repository history interactively

For these scripts, tests verify `--version`, `--help`, and error handling only.

### Writing Tests

Tests use RSpec with custom helpers defined in `spec/spec_helper.rb`:

```ruby
# Run a script and capture output
stdout, stderr, status = run_bin("git-script-name", "arg1", "arg2")

# Create a temporary git repository for testing
with_test_repo do |repo|
  create_branch(repo, "feature")
  create_commit(repo, message: "Add feature", files: { "file.rb" => "content" })

  stdout, _, status = run_bin("git-changed-files", chdir: repo)
  expect(stdout).to include("file.rb")
end
```

### Adding a New Script

1. Create the script in `bin/` with `--version` and `--help` support
2. Create a test directory: `mkdir spec/git-your-script`
3. Write tests in `spec/git-your-script/git_your_script_spec.rb`
4. Run tests to verify: `script/rspec spec/git-your-script/`

### Code Style

- Scripts can be written in Bash, Ruby, or other languages
- All scripts should include version and help flags
- Error messages should be written to stderr
- Exit with non-zero status on errors
