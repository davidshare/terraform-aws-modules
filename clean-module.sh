#!/bin/bash

# Simple version: delete-modules.sh
# Usage: ./delete-modules.sh <directory-to-keep>

if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory-to-keep>"
    exit 1
fi

KEEP_DIR="$1"

# Directories to always keep (hidden and special dirs)
ALWAYS_KEEP=(".git" ".github" ".vscode")

echo "===== Terraform Module Cleanup ====="
echo "Directory to keep: $KEEP_DIR"
echo "Always keeping: ${ALWAYS_KEEP[*]}"
echo

# Count and list directories to be deleted
DIRS_TO_DELETE=$(find . -maxdepth 1 -type d ! -name "." ! -name "$KEEP_DIR" \
    ! -name ".git" ! -name ".github" ! -name ".vscode" | wc -l)

if [ "$DIRS_TO_DELETE" -eq 0 ]; then
    echo "No directories to delete (only $KEEP_DIR and protected directories exist)."
    exit 0
fi

echo "Found $DIRS_TO_DELETE directories to delete:"
echo "-------------------------------------------"
find . -maxdepth 1 -type d ! -name "." ! -name "$KEEP_DIR" \
    ! -name ".git" ! -name ".github" ! -name ".vscode" \
    -exec basename {} \;
echo "-------------------------------------------"

# Ask for confirmation
read -p "Are you sure you want to delete these $DIRS_TO_DELETE directories? (y/N): " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo
    echo "Deleting directories..."
    echo "-----------------------"
    find . -maxdepth 1 -type d ! -name "." ! -name "$KEEP_DIR" \
        ! -name ".git" ! -name ".github" ! -name ".vscode" \
        -exec echo "  Deleting: {}" \; -exec rm -rf {} \;
    echo "-----------------------"
    echo "✅ Cleanup complete! Kept: $KEEP_DIR"
else
    echo "❌ Operation cancelled."
    exit 0
fi