# bin-git

[![Tests](https://github.com/zdennis/bin-git/actions/workflows/test.yml/badge.svg)](https://github.com/zdennis/bin-git/actions/workflows/test.yml)

A collection of git helper scripts that extend git with useful commands for everyday workflows.

## Compatibility

| Ruby Version | Status |
|--------------|--------|
| 3.4 | ✅ Tested |
| 4.0 | ✅ Tested |

## Why This Exists

I don't want to remember things I can look up. And I want the things that help me to be discoverable.

Git finds any executable named `git-*` in your PATH and lets you run it as a subcommand. For instance, `git-backup-branch` becomes `git backup-branch`. No aliases, no configuration.

This repository is a collection of these scripts—things like `git open-pull` to open the current PR in a browser, or `git previous-branch` to get the branch you were just on. They started as quick fixes for daily annoyances and accumulated over time.

In my experience, scripts beat aliases. You can write them in any language, give them proper `--help` output, version them, and test them. They're also easier to change and easier to delete.

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

## Top Tools

These are the ones I reach for most often.

| Tool | Notes |
|------|-------|
| `git-backup-branch` | Used daily. Creates timestamped branch backups. I've incorporated this into AI-assisted workflows so agents can create restore points before making changes. |
| `git-1m` | Used daily. Quick view of commits on the current branch vs main. Faster than typing `git log --oneline main..`. Companions: `git-1` (last commit) and `git-m1` (last commit on main). |
| `git-amend` | Used daily. Amends staged changes to the last commit. Shorter than `git commit --amend -C HEAD`. |
| `git-current-branch` / `git-previous-branch` / `git-get-main-branch` | Used in scripts when referencing branches. `git-get-main-branch` works with both `main` and `master` so you don't have to care how the repo is configured. |
| `git-diff-branch` | Used daily. Shows range-diff between current branch and its remote. Useful for seeing if changes are meaningful or just SHA/message updates from a rebase. |
| `git-recent` | Used daily. Lists recently checked-out branches. Quick way to switch back to something I was working on. |
| `git-pushr` | Used daily. Pushes to the remote tracking branch, setting it up if needed. |
| `git-pushf` | Used daily. Force push with `--force-with-lease`. |
| `git-fixup` | Used daily. Creates fixup commits for later autosquashing. Lets me keep moving without interrupting flow to squash immediately. |
| `git-rebase-sha` | Used daily. Interactive rebase from a given SHA. Headless—no need to manually edit the todo list. |
| `git-edit-sha` | Used daily. Marks commits for editing in an interactive rebase. Works with single SHAs, multiple SHAs, or ranges. |
| `git-reword-sha` | Used daily. Rewords commit messages via interactive rebase. Works with single SHAs, multiple SHAs, or ranges. |
| `git-find-prs-for-file` | Used frequently. Finds pull requests that touched a given file. |
| `git-open-url` | Used daily. Opens the repo on GitHub in my browser. |
| `git-compare-url` | Used weekly. Generates GitHub compare URLs. |
| `git-changed-files` | Used daily. Lists files changed on the current branch vs main. I alias this to `cf` and use it to feed file lists to other tools (rubocop, rspec, etc). |
| `git-who-owns` | Used weekly. Shows which teams own a file based on CODEOWNERS. |

## All Tools

| Tool | Category | Description |
|------|----------|-------------|
| git-1 | Commits | Show the last commit (shorthand for `git log -1`) |
| git-1m | Commits | Show commits on current branch not in main |
| git-1sha | Commits | Output the SHA of the last commit |
| git-add-ignore | Files | Download and append gitignore templates from GitHub |
| git-amend | Commits | Amend the last commit with staged changes |
| git-anim | Commits | Animate git log output |
| git-author-stats | Commits | Show commit statistics grouped by author |
| git-backup-branch | Branches | Create timestamped backup copies of branches |
| git-bin-git-path | GitHub | Output the path to the bin-git directory |
| git-branch-url | GitHub | Get the GitHub URL for the current branch |
| git-build-go-helpers | Files | Build Go-based helper tools |
| git-cbranch | Branches | Alias for `git-current-branch` |
| git-changed-files | Files | List files changed in the current branch vs main |
| git-changed-specs | Files | List spec files corresponding to changed source files |
| git-choose-branch | Branches | Interactive branch selector using fzf |
| git-clone-github | GitHub | Clone a GitHub repository by org/repo shorthand |
| git-compare-url | GitHub | Get the GitHub compare URL for current branch |
| git-copy-sha | Commits | Copy the current commit SHA to clipboard |
| git-current-branch | Branches | Output the current branch name |
| git-dangling-commits | Commits | Find dangling/orphaned commits |
| git-del | Branches | Delete a branch locally and remotely |
| git-diff-branch | Commits | Show range-diff between branches |
| git-edit-sha | Rebase | Open a commit in interactive rebase for editing |
| git-file-url | GitHub | Get the GitHub URL for a specific file |
| git-find-merge-with-sha | Commits | Find the merge commit that contains a given SHA |
| git-find-pr-for-sha | GitHub | Find the PR that introduced a given commit |
| git-find-prs-for-file | GitHub | Find PRs that modified a specific file |
| git-fixup | Commits | Create a fixup commit for a previous commit |
| git-fixup-n-rebase | Rebase | Create a fixup commit and immediately rebase |
| git-get-main-branch | Branches | Detect and output the main branch name (main or master) |
| git-github-org-name | GitHub | Output the GitHub organization/user for the repo |
| git-ignore-dirs-for-grep | Files | Output directories to ignore when grepping |
| git-ignore-files-for-grep | Files | Output files to ignore when grepping |
| git-link-usages | Files | Find usages of a symbol and output as links |
| git-list-authors | Commits | List all commit authors in the repository |
| git-m1 | Commits | Show the last commit on main branch |
| git-my-prs | GitHub | List your open pull requests |
| git-names | Files | Show changed filenames with their status (A/M/D) |
| git-new-repos | GitHub | Find recently created repositories |
| git-oneline | Commits | Show git log in oneline format with graph |
| git-open-branch | GitHub | Open the current branch on GitHub in browser |
| git-open-circleci | GitHub | Open CircleCI for the current repository |
| git-open-compare | GitHub | Open GitHub compare view in browser |
| git-open-file-remote | GitHub | Open a file on GitHub at the current commit |
| git-open-files | Files | Open changed files in your editor |
| git-open-github-project | GitHub | Open the GitHub project board |
| git-open-my-pulls | GitHub | Open your PRs on GitHub in browser |
| git-open-pull | GitHub | Open the PR for the current branch |
| git-open-pulls | GitHub | Open the pull requests page on GitHub |
| git-open-sha | GitHub | Open a specific commit on GitHub |
| git-open-sha-diff | GitHub | Open the diff for a specific commit on GitHub |
| git-open-travisci | GitHub | Open Travis CI for the current repository |
| git-open-tree | GitHub | Open the repository tree on GitHub |
| git-open-url | GitHub | Open the repository URL on GitHub |
| git-pbranch | Branches | Alias for `git-previous-branch` |
| git-previous-branch | Branches | Output the previously checked out branch |
| git-project | GitHub | Output the project/repository name |
| git-prs-waiting-for-my-review | GitHub | List PRs where your review is requested |
| git-pull-url | GitHub | Get the URL for the current branch's PR |
| git-pulls | GitHub | List pull requests for the repository |
| git-pushf | Branches | Force push with lease (safer force push) |
| git-pushr | Branches | Push and set upstream tracking |
| git-rbranch | Branches | Alias for `git-remote-branch` |
| git-rebase-auto-editor | Rebase | Automated rebase editor for scripted rebases |
| git-rebase-branch | Rebase | Rebase current branch from its divergence point |
| git-rebase-commit-messages-jira-ref | Rebase | Add JIRA references to commit messages during rebase |
| git-rebase-edit-sha | Rebase | Start interactive rebase with a commit marked for edit |
| git-rebase-rubocop | Rebase | Run rubocop on each commit during rebase |
| git-rebase-sha | Rebase | Interactive rebase starting from a specific commit |
| git-rebase-sha-bash | Rebase | Drop into bash during rebase at a specific commit |
| git-recent | Branches | List recently checked out branches |
| git-remote-branch | Branches | Output the remote tracking branch |
| git-repos-name | GitHub | Output the repository name from remote URL |
| git-review | Commits | Review commits not yet pushed to remote |
| git-reword-sha | Rebase | Reword a specific commit message |
| git-rib | Rebase | Interactive rebase on main branch |
| git-rollback | Commits | Soft reset HEAD by N commits, keeping changes staged |
| git-rreview | Commits | Review remote commits not in local branch |
| git-rubocop-branch | Files | Run rubocop on files changed in current branch |
| git-sha-url | GitHub | Get the GitHub URL for a specific commit SHA |
| git-squash-all-commits | Commits | Squash all commits on branch into one |
| git-stash-find | Commits | Search stash entries by message or content |
| git-story | Branches | Output story/ticket ID from branch name |
| git-tree-url | GitHub | Get the GitHub tree URL for current branch |
| git-unmerged | Branches | Show branches with commits not merged to main |
| git-url | GitHub | Get the GitHub URL for the repository |
| git-whatadded | Files | Find the commit that added a specific file |
| git-who-owns | Files | Show CODEOWNERS for a file |

## By Category

### Branches

Managing branches is one of the most frequent git activities. These tools reduce friction for common operations like switching between recent work, backing up before risky changes, and cleaning up old branches. The `git-get-main-branch` tool is particularly useful in scripts since it handles both `main` and `master` conventions.

| Tool | Description |
|------|-------------|
| git-backup-branch | Create timestamped backup copies of branches |
| git-cbranch | Alias for `git-current-branch` |
| git-choose-branch | Interactive branch selector using fzf |
| git-current-branch | Output the current branch name |
| git-del | Delete a branch locally and remotely |
| git-get-main-branch | Detect and output the main branch name (main or master) |
| git-pbranch | Alias for `git-previous-branch` |
| git-previous-branch | Output the previously checked out branch |
| git-pushf | Force push with lease (safer force push) |
| git-pushr | Push and set upstream tracking |
| git-rbranch | Alias for `git-remote-branch` |
| git-recent | List recently checked out branches |
| git-remote-branch | Output the remote tracking branch |
| git-story | Output story/ticket ID from branch name |
| git-unmerged | Show branches with commits not merged to main |

### Commits

Viewing and manipulating commits is central to git workflows. These tools provide shortcuts for common operations like amending, creating fixup commits, and inspecting history. Several are just shorter ways to type things you already do—`git-amend` saves keystrokes, `git-1` shows the last commit without remembering log flags.

| Tool | Description |
|------|-------------|
| git-1 | Show the last commit (shorthand for `git log -1`) |
| git-1m | Show commits on current branch not in main |
| git-1sha | Output the SHA of the last commit |
| git-amend | Amend the last commit with staged changes |
| git-anim | Animate git log output |
| git-author-stats | Show commit statistics grouped by author |
| git-copy-sha | Copy the current commit SHA to clipboard |
| git-dangling-commits | Find dangling/orphaned commits |
| git-diff-branch | Show range-diff between branches |
| git-find-merge-with-sha | Find the merge commit that contains a given SHA |
| git-fixup | Create a fixup commit for a previous commit |
| git-list-authors | List all commit authors in the repository |
| git-m1 | Show the last commit on main branch |
| git-oneline | Show git log in oneline format with graph |
| git-review | Review commits not yet pushed to remote |
| git-rollback | Soft reset HEAD by N commits, keeping changes staged |
| git-rreview | Review remote commits not in local branch |
| git-squash-all-commits | Squash all commits on branch into one |
| git-stash-find | Search stash entries by message or content |

### Rebase

Rebasing is powerful but the commands are verbose and easy to mistype. These tools automate common rebase patterns—editing a commit, rewording a message, or running checks on each commit. They handle the interactive rebase ceremony so you don't have to manually edit todo lists.

| Tool | Description |
|------|-------------|
| git-edit-sha | Open a commit in interactive rebase for editing |
| git-fixup-n-rebase | Create a fixup commit and immediately rebase |
| git-rebase-auto-editor | Automated rebase editor for scripted rebases |
| git-rebase-branch | Rebase current branch from its divergence point |
| git-rebase-commit-messages-jira-ref | Add JIRA references to commit messages during rebase |
| git-rebase-edit-sha | Start interactive rebase with a commit marked for edit |
| git-rebase-rubocop | Run rubocop on each commit during rebase |
| git-rebase-sha | Interactive rebase starting from a specific commit |
| git-rebase-sha-bash | Drop into bash during rebase at a specific commit |
| git-reword-sha | Reword a specific commit message |
| git-rib | Interactive rebase on main branch |

### GitHub

These tools bridge git and GitHub. Some generate URLs for sharing, others open pages directly in your browser. Useful when you're working locally but need to quickly jump to a PR, view a file on GitHub, or share a link to a specific commit.

| Tool | Description |
|------|-------------|
| git-bin-git-path | Output the path to the bin-git directory |
| git-branch-url | Get the GitHub URL for the current branch |
| git-clone-github | Clone a GitHub repository by org/repo shorthand |
| git-compare-url | Get the GitHub compare URL for current branch |
| git-file-url | Get the GitHub URL for a specific file |
| git-find-pr-for-sha | Find the PR that introduced a given commit |
| git-find-prs-for-file | Find PRs that modified a specific file |
| git-github-org-name | Output the GitHub organization/user for the repo |
| git-my-prs | List your open pull requests |
| git-new-repos | Find recently created repositories |
| git-open-branch | Open the current branch on GitHub in browser |
| git-open-circleci | Open CircleCI for the current repository |
| git-open-compare | Open GitHub compare view in browser |
| git-open-file-remote | Open a file on GitHub at the current commit |
| git-open-github-project | Open the GitHub project board |
| git-open-my-pulls | Open your PRs on GitHub in browser |
| git-open-pull | Open the PR for the current branch |
| git-open-pulls | Open the pull requests page on GitHub |
| git-open-sha | Open a specific commit on GitHub |
| git-open-sha-diff | Open the diff for a specific commit on GitHub |
| git-open-travisci | Open Travis CI for the current repository |
| git-open-tree | Open the repository tree on GitHub |
| git-open-url | Open the repository URL on GitHub |
| git-project | Output the project/repository name |
| git-prs-waiting-for-my-review | List PRs where your review is requested |
| git-pull-url | Get the URL for the current branch's PR |
| git-pulls | List pull requests for the repository |
| git-repos-name | Output the repository name from remote URL |
| git-sha-url | Get the GitHub URL for a specific commit SHA |
| git-tree-url | Get the GitHub tree URL for current branch |
| git-url | Get the GitHub URL for the repository |

### Files

Working with changed files is a common need—running linters on them, opening them in an editor, or just listing what changed. These tools make it easy to get file lists that can be piped to other commands. `git-changed-files` in particular is useful as input to other tools like rubocop or rspec.

| Tool | Description |
|------|-------------|
| git-add-ignore | Download and append gitignore templates from GitHub |
| git-build-go-helpers | Build Go-based helper tools |
| git-changed-files | List files changed in the current branch vs main |
| git-changed-specs | List spec files corresponding to changed source files |
| git-ignore-dirs-for-grep | Output directories to ignore when grepping |
| git-ignore-files-for-grep | Output files to ignore when grepping |
| git-link-usages | Find usages of a symbol and output as links |
| git-names | Show changed filenames with their status (A/M/D) |
| git-open-files | Open changed files in your editor |
| git-rubocop-branch | Run rubocop on files changed in current branch |
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
