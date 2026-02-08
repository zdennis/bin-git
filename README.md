# bin-git

[![Tests](https://github.com/zdennis/bin-git/actions/workflows/test.yml/badge.svg)](https://github.com/zdennis/bin-git/actions/workflows/test.yml)

A collection of 88 git helper scripts that extend git with useful commands for everyday workflows.

## Why This Exists

Git automatically discovers any executable prefixed with `git-` in your PATH. Running `git backup-branch` will find and execute `git-backup-branch`. This project leverages that feature to provide a collection of git extensions that are:

- **Easy to discover** — Run `git <tab><tab>` to see available commands, or use `--help` on any tool
- **Easy to evolve** — Each tool is a standalone script that can be modified, replaced, or extended independently
- **Polyglot** — Tools can be written in any language (Bash, Ruby, Python, Go, etc.), not just shell
- **Testable** — Unlike git aliases, these scripts can have proper test suites
- **Maintainable** — Far more maintainable than a sprawling `.gitconfig` with inline aliases

This is the git-specific sibling of [zdennis/bin](https://github.com/zdennis/bin).

## Installation

Add the `bin/` directory to your PATH:

```bash
export PATH="$PATH:/path/to/bin-git/bin"
```

All tools support `--help` and `--version` flags.

## Directory Structure

```
bin/          # Git tools (add this to your $PATH)
script/       # Project-internal scripts (binstubs, dev helpers)
spec/         # Tests for the tools
```

**Note:** `bin/` contains the tools meant for external use. `script/` contains development helpers that should not be added to your `$PATH`.

## Tools

| Tool | Description |
|------|-------------|
| git-1 | Show the last commit (shorthand for `git log -1`) |
| git-1m | Show commits on current branch not in main |
| git-1sha | Output the SHA of the last commit |
| git-add-ignore | Download and append gitignore templates from GitHub |
| git-amend | Amend the last commit with staged changes |
| git-anim | Animate git log output |
| git-author-stats | Show commit statistics grouped by author |
| git-backup-branch | Create timestamped backup copies of branches |
| git-bin-git-path | Output the path to the bin-git directory |
| git-branch-url | Get the GitHub URL for the current branch |
| git-build-go-helpers | Build Go-based helper tools |
| git-cbranch | Alias for `git-current-branch` |
| git-changed-files | List files changed in the current branch vs main |
| git-changed-specs | List spec files corresponding to changed source files |
| git-choose-branch | Interactive branch selector using fzf |
| git-clone-github | Clone a GitHub repository by org/repo shorthand |
| git-compare-url | Get the GitHub compare URL for current branch |
| git-copy-sha | Copy the current commit SHA to clipboard |
| git-current-branch | Output the current branch name |
| git-dangling-commits | Find dangling/orphaned commits |
| git-del | Delete a branch locally and remotely |
| git-diff-branch | Show range-diff between branches |
| git-edit-sha | Open a commit in interactive rebase for editing |
| git-file-url | Get the GitHub URL for a specific file |
| git-find-merge-with-sha | Find the merge commit that contains a given SHA |
| git-find-pr-for-sha | Find the PR that introduced a given commit |
| git-find-prs-for-file | Find PRs that modified a specific file |
| git-fixup | Create a fixup commit for a previous commit |
| git-fixup-n-rebase | Create a fixup commit and immediately rebase |
| git-get-main-branch | Detect and output the main branch name (main or master) |
| git-github-org-name | Output the GitHub organization/user for the repo |
| git-ignore-dirs-for-grep | Output directories to ignore when grepping |
| git-ignore-files-for-grep | Output files to ignore when grepping |
| git-link-usages | Find usages of a symbol and output as links |
| git-list-authors | List all commit authors in the repository |
| git-m1 | Show the last commit on main branch |
| git-my-prs | List your open pull requests |
| git-names | Show changed filenames with their status (A/M/D) |
| git-new-repos | Find recently created repositories |
| git-oneline | Show git log in oneline format with graph |
| git-open-branch | Open the current branch on GitHub in browser |
| git-open-circleci | Open CircleCI for the current repository |
| git-open-compare | Open GitHub compare view in browser |
| git-open-file-remote | Open a file on GitHub at the current commit |
| git-open-files | Open changed files in your editor |
| git-open-github-project | Open the GitHub project board |
| git-open-my-pulls | Open your PRs on GitHub in browser |
| git-open-pull | Open the PR for the current branch |
| git-open-pulls | Open the pull requests page on GitHub |
| git-open-sha | Open a specific commit on GitHub |
| git-open-sha-diff | Open the diff for a specific commit on GitHub |
| git-open-travisci | Open Travis CI for the current repository |
| git-open-tree | Open the repository tree on GitHub |
| git-open-url | Open the repository URL on GitHub |
| git-pbranch | Alias for `git-previous-branch` |
| git-previous-branch | Output the previously checked out branch |
| git-project | Output the project/repository name |
| git-prs-waiting-for-my-review | List PRs where your review is requested |
| git-pull-url | Get the URL for the current branch's PR |
| git-pulls | List pull requests for the repository |
| git-pushf | Force push with lease (safer force push) |
| git-pushr | Push and set upstream tracking |
| git-rbranch | Alias for `git-remote-branch` |
| git-rebase-auto-editor | Automated rebase editor for scripted rebases |
| git-rebase-branch | Rebase current branch from its divergence point |
| git-rebase-commit-messages-jira-ref | Add JIRA references to commit messages during rebase |
| git-rebase-edit-sha | Start interactive rebase with a commit marked for edit |
| git-rebase-rubocop | Run rubocop on each commit during rebase |
| git-rebase-sha | Interactive rebase starting from a specific commit |
| git-rebase-sha-bash | Drop into bash during rebase at a specific commit |
| git-recent | List recently checked out branches |
| git-remote-branch | Output the remote tracking branch |
| git-repos-name | Output the repository name from remote URL |
| git-review | Review commits not yet pushed to remote |
| git-reword-sha | Reword a specific commit message |
| git-rib | Interactive rebase on main branch |
| git-rollback | Soft reset HEAD by N commits, keeping changes staged |
| git-rreview | Review remote commits not in local branch |
| git-rubocop-branch | Run rubocop on files changed in current branch |
| git-sha-url | Get the GitHub URL for a specific commit SHA |
| git-squash-all-commits | Squash all commits on branch into one |
| git-stash-find | Search stash entries by message or content |
| git-story | Output story/ticket ID from branch name |
| git-tree-url | Get the GitHub tree URL for current branch |
| git-unmerged | Show branches with commits not merged to main |
| git-url | Get the GitHub URL for the repository |
| git-whatadded | Find the commit that added a specific file |
| git-who-owns | Show CODEOWNERS for a file |

## Developing

### Setup

```bash
bundle install
```

### Running Tests

Tests are written in RSpec and located in `spec/`. Each tool has its own spec directory.

```bash
# Run all tests
script/rspec spec/

# Run tests for a specific tool
script/rspec spec/git-backup-branch/

# Run with documentation format
script/rspec spec/ --format documentation
```

### Test Philosophy

The tests are **black-box, end-to-end tests** that verify tool behavior by:

- Executing the actual tool as a subprocess
- Providing input (arguments, stdin, files, git repositories)
- Verifying output (stdout, stderr, exit codes)

Tests do **not** load tool internals. This ensures:

1. **Confidence in real-world usage** — Tests exercise the same code paths users encounter
2. **Refactoring safety** — Internal changes don't break tests as long as behavior is preserved
3. **Documentation by example** — Tests serve as executable usage examples

### Adding a New Tool

1. Create the script in `bin/` with `--version` and `--help` support
2. Create a spec directory: `mkdir spec/git-your-tool`
3. Add tests: `spec/git-your-tool/git_your_tool_spec.rb`
4. Run tests: `script/rspec spec/git-your-tool/`

### Code Style

- Tools can be written in any language
- All tools must support `--version`/`-v` and `--help`/`-h` flags
- Error messages go to stderr
- Exit with non-zero status on errors
