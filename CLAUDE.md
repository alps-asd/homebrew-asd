# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Homebrew tap (`alps-asd/asd`) for distributing the `asd` (app-state-diagram) tool. The tool generates state diagrams and documentation from ALPS profiles.

## Branch Structure

- `1.x`: Legacy PHP/phar-based formula (downloads pre-built `.phar` file)
- `v2-node`: Current development branch for TypeScript/Node.js version (builds from source)
- `hotfix-update-formula`: Main branch for hotfixes

## Formula Location

The formula file is `Formula/asd.rb`.

## Testing Formula Changes

```bash
# Install from tap
brew install alps-asd/asd/asd --build-from-source

# Test the formula
brew test asd

# Audit the formula for style issues
brew audit --strict Formula/asd.rb

# Uninstall
brew uninstall asd
```

## Formula Structure (v2-node)

The current formula:
- Depends on `node@20` and `pnpm`
- Builds from tagged releases of `alps-asd/app-state-diagram`
- Runs `pnpm install` and `pnpm build`
- Creates a shell wrapper script that invokes the built CLI

## Updating the Formula

When updating version:
1. Update the `tag` in url (e.g., `tag: "v2.0.0-alpha.3"`)
2. Update `version` to match
