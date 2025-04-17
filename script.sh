#!/bin/bash

# Display tree structure while ignoring .git directory and respecting .gitignore
echo "===== Directory Structure ====="
if command -v tree &> /dev/null; then
  tree -a -I ".git" --gitignore
else
  # Fallback if tree command is not available
  # First get a list of files not ignored by git
  git_files=$(git ls-files 2>/dev/null)
  untracked_not_ignored=$(git ls-files --others --exclude-standard 2>/dev/null)

  # If not in a git repo, just list all files except those in .git directories
  if [ -z "$git_files" ] && [ -z "$untracked_not_ignored" ]; then
    find . -type d -not -path "*/\.git*" | sort | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
  else
    # Create a simple directory structure display for git tracked and untracked-but-not-ignored files
    for file in $git_files $untracked_not_ignored; do
      echo "$file" | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
    done
  fi
fi

echo -e "\n==========================="
echo "===== File Contents ====="
echo "==========================="

# Get list of files not ignored by git
files=$(git ls-files 2>/dev/null)
untracked_not_ignored=$(git ls-files --others --exclude-standard 2>/dev/null)
all_files="$files $untracked_not_ignored"

# If not in a git repo, just list all files except those in .git directories
if [ -z "$all_files" ]; then
  all_files=$(find . -type f -not -path "*/\.git*" | sort)
fi

for file in $all_files; do
  # Skip directories
  if [ -d "$file" ]; then
    continue
  fi

  # Skip files in .git directory
  if [[ "$file" == *".git"* ]]; then
    continue
  fi

  # Check if file is binary
  if file "$file" | grep -q "binary"; then
    echo -e "\n===== $file (BINARY FILE - CONTENT NOT DISPLAYED) ====="
    continue
  fi

  # Display file content with header
  echo -e "\n===== $file ====="
  echo "----------"
  cat "$file"
  echo "----------"
done

echo -e "\n===== End of File Contents ====="
