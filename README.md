# Directory and File Contents Viewer

A bash script that displays the directory structure and contents of files in a project, with intelligent handling of git repositories and the ability to process a custom list of files.

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

## Installation

```bash
# Download the script
curl -O https://raw.githubusercontent.com/yourusername/your-repo/main/view_project.sh

# Make it executable
chmod +x view_project.sh
```

## Usage

```bash
./view_project.sh [options]
```

### Options

```
  -h, --help                 Display this help message
  -f, --file-list FILENAME   Use a file containing a list of files to process
```

### File List Format

When using the `-f` option, the specified file should contain one filename per line:

```
file1.txt
src/main.js
README.md
# This line is a comment and will be ignored
config/settings.json

# Empty lines are also ignored
```

## Tutorial

### Basic Usage: View All Files

```bash
# View all git-tracked files (or all files if not in a git repo)
./view_project.sh
```

### Using a Custom File List

```bash
# Create a file list
cat > my_files.txt << EOF
README.md
src/main.js
# Configuration files
config/settings.json
EOF

# Run with custom file list
./view_project.sh -f my_files.txt
```

### Create a Filtered File List

```bash
# Get only JavaScript files, excluding node_modules
find . -name "*.js" | grep -v "node_modules" > js_files.txt

# View only these files
./view_project.sh -f js_files.txt
```

### View Only Git-Modified Files

```bash
# Create a list of files modified in git
git diff --name-only > modified_files.txt

# View only these files
./view_project.sh -f modified_files.txt
```

### Save Output to File

```bash
# Save output to a text file for documentation
./view_project.sh > project_documentation.txt
```

## Output Format

The script output is divided into sections:

1. **Directory Structure**:
   ```
   ===== Directory Structure =====
   .
   ├── README.md
   ├── src
   │   └── main.js
   └── config
       └── settings.json
   ```

2. **File Contents**:
   ```
   ===== README.md =====
   ----------
   # My Project
   This is a sample project.
   ----------
   
   ===== src/main.js =====
   ----------
   console.log('Hello World');
   ----------
   ```

## Notes

- In git repositories, the script respects `.gitignore` rules
- Files in `.git` directories are always skipped
- Large binary files are automatically detected and not displayed
