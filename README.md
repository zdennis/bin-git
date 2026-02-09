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

| Tool | README | Category | Description |
|------|--------|----------|-------------|
| git-1 | [README](docs/README.git-1.md) | Commits | Show the last commit (shorthand for `git log -1`) |
| git-1m | [README](docs/README.git-1m.md) | Commits | Show commits on current branch not in main |
| git-1sha | [README](docs/README.git-1sha.md) | Commits | Output the SHA of the last commit |
| git-add-ignore | [README](docs/README.git-add-ignore.md) | Files | Download and append gitignore templates from GitHub |
| git-amend | [README](docs/README.git-amend.md) | Commits | Amend the last commit with staged changes |
| git-anim | [README](docs/README.git-anim.md) | Commits | Animate git log output |
| git-author-stats | [README](docs/README.git-author-stats.md) | Commits | Show commit statistics grouped by author |
| git-backup-branch | [README](docs/README.git-backup-branch.md) | Branches | Create timestamped backup copies of branches |
| git-bin-git-path | [README](docs/README.git-bin-git-path.md) | GitHub | Output the path to the bin-git directory |
| git-branch-url | [README](docs/README.git-branch-url.md) | GitHub | Get the GitHub URL for the current branch |
| git-build-go-helpers | [README](docs/README.git-build-go-helpers.md) | Files | Build Go-based helper tools |
| git-cbranch | [README](docs/README.git-cbranch.md) | Branches | Alias for `git-current-branch` |
| git-changed-files | [README](docs/README.git-changed-files.md) | Files | List files changed in the current branch vs main |
| git-changed-specs | [README](docs/README.git-changed-specs.md) | Files | List spec files corresponding to changed source files |
| git-choose-branch | [README](docs/README.git-choose-branch.md) | Branches | Interactive branch selector using fzf |
| git-clone-github | [README](docs/README.git-clone-github.md) | GitHub | Clone a GitHub repository by org/repo shorthand |
| git-compare-url | [README](docs/README.git-compare-url.md) | GitHub | Get the GitHub compare URL for current branch |
| git-copy-sha | [README](docs/README.git-copy-sha.md) | Commits | Copy the current commit SHA to clipboard |
| git-current-branch | [README](docs/README.git-current-branch.md) | Branches | Output the current branch name |
| git-dangling-commits | [README](docs/README.git-dangling-commits.md) | Commits | Find dangling/orphaned commits |
| git-del | [README](docs/README.git-del.md) | Branches | Delete a branch locally and remotely |
| git-diff-branch | [README](docs/README.git-diff-branch.md) | Commits | Show range-diff between branches |
| git-edit-sha | [README](docs/README.git-edit-sha.md) | Rebase | Open a commit in interactive rebase for editing |
| git-file-url | [README](docs/README.git-file-url.md) | GitHub | Get the GitHub URL for a specific file |
| git-find-merge-with-sha | [README](docs/README.git-find-merge-with-sha.md) | Commits | Find the merge commit that contains a given SHA |
| git-find-pr-for-sha | [README](docs/README.git-find-pr-for-sha.md) | GitHub | Find the PR that introduced a given commit |
| git-find-prs-for-file | [README](docs/README.git-find-prs-for-file.md) | GitHub | Find PRs that modified a specific file |
| git-fixup | [README](docs/README.git-fixup.md) | Commits | Create a fixup commit for a previous commit |
| git-fixup-n-rebase | [README](docs/README.git-fixup-n-rebase.md) | Rebase | Create a fixup commit and immediately rebase |
| git-get-main-branch | [README](docs/README.git-get-main-branch.md) | Branches | Detect and output the main branch name (main or master) |
| git-github-org-name | [README](docs/README.git-github-org-name.md) | GitHub | Output the GitHub organization/user for the repo |
| git-ignore-dirs-for-grep | [README](docs/README.git-ignore-dirs-for-grep.md) | Files | Output directories to ignore when grepping |
| git-ignore-files-for-grep | [README](docs/README.git-ignore-files-for-grep.md) | Files | Output files to ignore when grepping |
| git-link-usages | [README](docs/README.git-link-usages.md) | Files | Find usages of a symbol and output as links |
| git-list-authors | [README](docs/README.git-list-authors.md) | Commits | List all commit authors in the repository |
| git-m1 | [README](docs/README.git-m1.md) | Commits | Show the last commit on main branch |
| git-my-prs | [README](docs/README.git-my-prs.md) | GitHub | List your open pull requests |
| git-names | [README](docs/README.git-names.md) | Files | Show changed filenames with their status (A/M/D) |
| git-new-repos | [README](docs/README.git-new-repos.md) | GitHub | Find recently created repositories |
| git-oneline | [README](docs/README.git-oneline.md) | Commits | Show git log in oneline format with graph |
| git-open-branch | [README](docs/README.git-open-branch.md) | GitHub | Open the current branch on GitHub in browser |
| git-open-circleci | [README](docs/README.git-open-circleci.md) | GitHub | Open CircleCI for the current repository |
| git-open-compare | [README](docs/README.git-open-compare.md) | GitHub | Open GitHub compare view in browser |
| git-open-file-remote | [README](docs/README.git-open-file-remote.md) | GitHub | Open a file on GitHub at the current commit |
| git-open-files | [README](docs/README.git-open-files.md) | Files | Open changed files in your editor |
| git-open-github-project | [README](docs/README.git-open-github-project.md) | GitHub | Open the GitHub project board |
| git-open-my-pulls | [README](docs/README.git-open-my-pulls.md) | GitHub | Open your PRs on GitHub in browser |
| git-open-pull | [README](docs/README.git-open-pull.md) | GitHub | Open the PR for the current branch |
| git-open-pulls | [README](docs/README.git-open-pulls.md) | GitHub | Open the pull requests page on GitHub |
| git-open-sha | [README](docs/README.git-open-sha.md) | GitHub | Open a specific commit on GitHub |
| git-open-sha-diff | [README](docs/README.git-open-sha-diff.md) | GitHub | Open the diff for a specific commit on GitHub |
| git-open-travisci | [README](docs/README.git-open-travisci.md) | GitHub | Open Travis CI for the current repository |
| git-open-tree | [README](docs/README.git-open-tree.md) | GitHub | Open the repository tree on GitHub |
| git-open-url | [README](docs/README.git-open-url.md) | GitHub | Open the repository URL on GitHub |
| git-pbranch | [README](docs/README.git-pbranch.md) | Branches | Alias for `git-previous-branch` |
| git-previous-branch | [README](docs/README.git-previous-branch.md) | Branches | Output the previously checked out branch |
| git-project | [README](docs/README.git-project.md) | GitHub | Output the project/repository name |
| git-prs-waiting-for-my-review | [README](docs/README.git-prs-waiting-for-my-review.md) | GitHub | List PRs where your review is requested |
| git-pull-url | [README](docs/README.git-pull-url.md) | GitHub | Get the URL for the current branch's PR |
| git-pulls | [README](docs/README.git-pulls.md) | GitHub | List pull requests for the repository |
| git-pushf | [README](docs/README.git-pushf.md) | Branches | Force push with lease (safer force push) |
| git-pushr | [README](docs/README.git-pushr.md) | Branches | Push and set upstream tracking |
| git-rbranch | [README](docs/README.git-rbranch.md) | Branches | Alias for `git-remote-branch` |
| git-rebase-auto-editor | [README](docs/README.git-rebase-auto-editor.md) | Rebase | Automated rebase editor for scripted rebases |
| git-rebase-branch | [README](docs/README.git-rebase-branch.md) | Rebase | Rebase current branch from its divergence point |
| git-rebase-commit-messages-jira-ref | [README](docs/README.git-rebase-commit-messages-jira-ref.md) | Rebase | Add JIRA references to commit messages during rebase |
| git-rebase-edit-sha | [README](docs/README.git-rebase-edit-sha.md) | Rebase | Start interactive rebase with a commit marked for edit |
| git-rebase-rubocop | [README](docs/README.git-rebase-rubocop.md) | Rebase | Run rubocop on each commit during rebase |
| git-rebase-sha | [README](docs/README.git-rebase-sha.md) | Rebase | Interactive rebase starting from a specific commit |
| git-rebase-sha-bash | [README](docs/README.git-rebase-sha-bash.md) | Rebase | Drop into bash during rebase at a specific commit |
| git-recent | [README](docs/README.git-recent.md) | Branches | List recently checked out branches |
| git-remote-branch | [README](docs/README.git-remote-branch.md) | Branches | Output the remote tracking branch |
| git-repos-name | [README](docs/README.git-repos-name.md) | GitHub | Output the repository name from remote URL |
| git-review | [README](docs/README.git-review.md) | Commits | Review commits not yet pushed to remote |
| git-reword-sha | [README](docs/README.git-reword-sha.md) | Rebase | Reword a specific commit message |
| git-rib | [README](docs/README.git-rib.md) | Rebase | Interactive rebase on main branch |
| git-rollback | [README](docs/README.git-rollback.md) | Commits | Soft reset HEAD by N commits, keeping changes staged |
| git-rreview | [README](docs/README.git-rreview.md) | Commits | Review remote commits not in local branch |
| git-rubocop-branch | [README](docs/README.git-rubocop-branch.md) | Files | Run rubocop on files changed in current branch |
| git-sha-url | [README](docs/README.git-sha-url.md) | GitHub | Get the GitHub URL for a specific commit SHA |
| git-squash-all-commits | [README](docs/README.git-squash-all-commits.md) | Commits | Squash all commits on branch into one |
| git-stash-find | [README](docs/README.git-stash-find.md) | Commits | Search stash entries by message or content |
| git-story | [README](docs/README.git-story.md) | Branches | Output story/ticket ID from branch name |
| git-tree-url | [README](docs/README.git-tree-url.md) | GitHub | Get the GitHub tree URL for current branch |
| git-unmerged | [README](docs/README.git-unmerged.md) | Branches | Show branches with commits not merged to main |
| git-url | [README](docs/README.git-url.md) | GitHub | Get the GitHub URL for the repository |
| git-whatadded | [README](docs/README.git-whatadded.md) | Files | Find the commit that added a specific file |
| git-who-owns | [README](docs/README.git-who-owns.md) | Files | Show CODEOWNERS for a file |

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
