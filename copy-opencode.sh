#!/bin/bash

# Script to copy .opencode/ directory contents to ~/.opencode
# Only copies necessary configuration files, excluding build artifacts and dependencies

set -e

SOURCE_DIR="./.opencode"
TARGET_DIR="$HOME/.opencode"

# Directories to copy
DIRS_TO_COPY=("agents" "commands" "notes" "plans" "settings" "skills")

# Files to copy (in the root of .opencode/)
FILES_TO_COPY=("AGENTS.md" "settings.json")

echo "Copying OpenCode configuration..."
echo "Source: $SOURCE_DIR"
echo "Target: $TARGET_DIR"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory $SOURCE_DIR does not exist"
  exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
  echo "Creating target directory: $TARGET_DIR"
  mkdir -p "$TARGET_DIR"
fi

# Copy directories
for dir in "${DIRS_TO_COPY[@]}"; do
  if [ -d "$SOURCE_DIR/$dir" ]; then
    echo "Copying directory: $dir"
    cp -r "$SOURCE_DIR/$dir" "$TARGET_DIR/"
  else
    echo "Warning: Directory $dir not found, skipping"
  fi
done

# Copy individual files
for file in "${FILES_TO_COPY[@]}"; do
  if [ -f "$SOURCE_DIR/$file" ]; then
    echo "Copying file: $file"
    cp "$SOURCE_DIR/$file" "$TARGET_DIR/"
  else
    echo "Warning: File $file not found, skipping"
  fi
done

echo ""
echo "✓ Copy completed successfully!"
echo "OpenCode configuration has been copied to $TARGET_DIR"
echo ""
echo "Copied directories: ${DIRS_TO_COPY[*]}"
echo "Copied files: ${FILES_TO_COPY[*]}"
echo ""
echo "Excluded: node_modules, package.json, bun.lock, .gitignore"
