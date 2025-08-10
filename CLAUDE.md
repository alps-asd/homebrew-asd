# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Homebrew tap repository for the `asd` (App State Diagram) tool, which reads ALPS documents and produces state diagrams and hyperlinked documentation.

## Repository Structure

- `asd.rb` - Main Homebrew formula file that defines how to install the `asd` tool
- `Formula/` - Empty directory (formulas are placed in the root for tap repositories)
- The formula installs a PHP PHAR file and sets up both `asd` and `asdw` executables

## Formula Details

The `asd.rb` formula:
- Downloads a PHAR file from GitHub releases
- Depends on PHP 8.4, Composer (build-time), and Node.js
- Extracts the PHAR and runs npm install for the asd-sync component
- Creates two executables:
  - `asd` - Runs the main PHP PHAR application
  - `asdw` - Runs the npm-based watcher component with profile support

## Common Tasks

Since this is a Homebrew formula repository, common operations include:

- **Testing the formula locally**: `brew install --build-from-source ./asd.rb`
- **Formula validation**: `brew audit --strict asd.rb`
- **Testing installation**: `brew test asd` (runs the test block in the formula)

## Formula Updates

When updating the formula:
1. Update the `url` to point to the new release
2. Update the `sha256` hash (can be obtained with `shasum -a 256 <downloaded-file>`)
3. Test the installation process
4. The formula includes both PHP and Node.js components that need to work together