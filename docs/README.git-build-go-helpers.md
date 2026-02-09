# git-build-go-helpers

Build and install Go-based helper commands from the `go-commands` directory. This is a development/setup tool for the bin-git repository itself.

## Options

| Option | Description |
|--------|-------------|
| `--help`, `-h` | Show help message |
| `--version`, `-v` | Show version information |

## Examples

```bash
# Build and install go helpers
git build-go-helpers
```

## How it works

Runs `build-all` and `install` scripts in the `go-commands/` directory relative to the bin-git installation.

## Last analyzed

2025-02-08 | 03c4609fa545085c32bcb9298a91b5e69b03aed7
