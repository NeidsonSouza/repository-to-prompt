# repository-to-prompt
Transform repository into prompt data to be used in AI tools.
## Features

- Displays a tree-like directory structure of your project
- Shows the contents of text files with clear formatting
- Skips binary files (displaying a notice instead)
- Three methods of selecting files:
  1. Git-tracked files and untracked-but-not-ignored files (default in git repos)
  2. All files in the directory (default outside git repos)
  3. Custom list of files from a specified file

## Requirements

- Bash shell environment
- For optimal directory tree display: the `tree` command (falls back to a simpler display if not available)
- Git (optional, enhances functionality in git repositories)

## Usage

```bash
./script.sh [options]
