---
name: readme
description: Create and update README documentation for git tools in bin/
argument-hint: <command> [tool-name]
---

# README Skill

Create and update README documentation for git tools in this repository.

## Usage

```
/readme create [tool-name]
/readme update [tool-name]
/readme update_ruby_compatibility
```

If `tool-name` is omitted, operates on all **committed** tools in `bin/`.

**Important:** Only tools that are committed to git will be documented. Uncommitted tools are ignored.

## Commands

### create

Creates missing README documentation:

1. **Top-level README.md** - If it doesn't exist, create it with the structure below. If it exists, ensure the All Tools table is up-to-date.

2. **docs/README.\<tool\>.md** - For each tool in `bin/` that's missing a README:
   - Create using the template below
   - Analyze the tool's source code to populate sections

### update

Updates existing README documentation:

1. Read the "Last analyzed" section from `docs/README.<tool>.md`
2. Check git history for changes to the tool since that date/SHA
3. If changes exist, re-analyze the tool and update the README
4. Update the "Last analyzed" section with current date/time and SHA

### update_ruby_compatibility

Updates the Ruby Compatibility section in the top-level README.md based on the Ruby versions specified in `.github/workflows/test.yml`.

This command:
1. Reads the GitHub Actions workflow file at `.github/workflows/test.yml`
2. Extracts the Ruby versions from the `matrix.ruby-version` array
3. Updates or creates a "Compatibility" section in README.md

**Note:** This command runs automatically after `create` and `update` commands.

## Top-level README.md Structure

The README.md has these sections in order:

```markdown
# bin-git

[![Tests](https://github.com/zdennis/bin-git/actions/workflows/test.yml/badge.svg)](...)

<Introduction paragraph>

## Compatibility

| Ruby Version | Status |
|--------------|--------|
| 3.4 | ✅ Tested |
| 4.0 | ✅ Tested |

<Note: Ruby versions are extracted from .github/workflows/test.yml>

## Why This Exists

<Philosophy and motivation>

## Installation

<PATH setup instructions>

## Directory Structure

<bin/, script/, spec/ explanation>

## Top Tools

<Curated table of most-used tools with personal notes>

## All Tools

| Tool | Category | README | Description |
|------|----------|--------|-------------|
| git-tool-name | Category | [README](docs/README.git-tool-name.md) | Description |

## By Category

### Branches
<Description>
<Table of branch tools>

### Commits
<Description>
<Table of commit tools>

### Rebase
<Description>
<Table of rebase tools>

### GitHub
<Description>
<Table of GitHub tools>

### Files
<Description>
<Table of file tools>

## How to install (Homebrew)

Some tools are available via Homebrew. See [zdennis/homebrew-bin](https://github.com/zdennis/homebrew-bin) for available tools and installation instructions.

Not all tools may be available. If there's a tool you'd like to install via Homebrew, [open a GitHub issue](https://github.com/zdennis/homebrew-bin/issues/new) and let me know.

## Developing

<Setup, running tests, test philosophy, adding new tools, code style>
```

## Tool README Template (docs/README.\<tool\>.md)

```markdown
# <tool>

<1-5 sentence description of what the tool does>

## Quick Start

<Quick start guide if there are setup steps required, otherwise omit this section>

## Commands

<If the tool has subcommands, list and describe them here>
<If no subcommands, rename this section to "Options" and list CLI options>

## Examples

<Practical usage examples with explanations>

## How it works

<Optional section - include if there are:>
<- Configuration files the tool reads/writes>
<- Directories it creates or uses>
<- Environment variables it respects>
<- Other implementation details developers should know>

## See Also

<Links to related tools in this repository>
<Links to external tools, libraries, or documentation>

## Last analyzed

<Date> | <Git SHA of the tool at time of analysis>
```

## Instructions for Claude

### When running `create`:

1. **Check/create top-level README.md:**
   - If README.md doesn't exist, create it with the structure above
   - If it exists, ensure the All Tools table is up-to-date with all tools in `bin/`

2. **Find tools needing READMEs:**
   - List only **committed** tools using `git ls-files bin/`
   - Check which are missing `docs/README.<tool>.md`
   - If a specific tool was requested, only process that tool (must be committed)

3. **For each tool needing a README:**
   - Read the tool's source code
   - Run `<tool> --help` if available
   - Create `docs/README.<tool>.md` using the template
   - Populate sections based on analysis
   - Set "Last analyzed" to current date and the tool's current git SHA

4. **Update the top-level README.md:**
   - Add README column link to the All Tools table
   - Update By Category tables if needed

5. **Update Ruby compatibility (automatic):**
   - Run the `update_ruby_compatibility` logic (see below)

### When running `update`:

1. **For each tool README to update:**
   - Read `docs/README.<tool>.md`
   - Parse the "Last analyzed" section for date and SHA
   - Run `git log <sha>..HEAD -- bin/<tool>` to check for changes
   - If no changes, skip this tool

2. **If changes exist:**
   - Read the tool's current source code
   - Run `<tool> --help` if available
   - Update the README sections as needed
   - Update "Last analyzed" with current date and new SHA

3. **Update the top-level README.md** if descriptions changed

4. **Update Ruby compatibility (automatic):**
   - Run the `update_ruby_compatibility` logic (see below)

### When running `update_ruby_compatibility`:

1. **Read the workflow file:**
   - Read `.github/workflows/test.yml`
   - Parse the YAML to find `jobs.<job-name>.strategy.matrix.ruby-version`
   - Extract the array of Ruby versions (e.g., `['3.4', '4.0']`)

2. **Update the Compatibility section in README.md:**
   - Find the `## Compatibility` section
   - If it doesn't exist, create it after the test badge and introduction paragraph
   - Generate a table with each Ruby version and "✅ Tested" status
   - Format:
     ```markdown
     ## Compatibility

     | Ruby Version | Status |
     |--------------|--------|
     | 3.4 | ✅ Tested |
     | 4.0 | ✅ Tested |
     ```

3. **Handle missing workflow file:**
   - If `.github/workflows/test.yml` doesn't exist, skip this step silently
   - If the matrix doesn't include ruby-version, skip this step silently

### Important notes:

- **Only document committed tools** - Use `git ls-files bin/` to get the list of tools to document
- Always use `docs/` directory for tool READMEs (create if needed)
- Tool names in filenames should match exactly (e.g., `README.git-backup-branch.md`)
- Keep descriptions concise (1-5 sentences)
- Omit optional sections if not applicable
- For "See Also", link to related tools in this repo first, then external resources
