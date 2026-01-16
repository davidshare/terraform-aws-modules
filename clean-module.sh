#!/bin/bash

# CleanDirs.sh - Deletes all directories in current folder except .git, .github, and specified ones

if [ $# -eq 0 ]; then
    echo "Usage: $0 <dir1> [dir2 dir3 ...]"
    echo "Deletes all directories except .git, .github, and the listed directories"
    exit 1
fi

# Store protected directories in an array
protected_dirs=(".git" ".github")
for dir in "$@"; do
    protected_dirs+=("$dir")
done

# Find all directories and exclude protected ones
find . -maxdepth 1 -type d | while read -r dir; do
    dir_name=$(basename "$dir")
    
    # Skip current directory (.)
    [ "$dir_name" = "." ] && continue
    
    # Check if directory is protected
    skip=false
    for protected in "${protected_dirs[@]}"; do
        if [ "$dir_name" = "$protected" ]; then
            skip=true
            break
        fi
    done
    
    if [ "$skip" = false ]; then
        echo "Deleting directory: $dir_name"
        rm -rf "$dir"
    else
        echo "Keeping directory: $dir_name"
    fi
done

echo "Cleanup complete."
