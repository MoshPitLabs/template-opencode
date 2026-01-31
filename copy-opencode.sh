#!/bin/bash

# Script to copy .opencode/ directory contents to ~/.opencode

set -e

SOURCE_DIR="./.opencode"
TARGET_DIR="$HOME/.opencode"

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

# Copy contents
echo "Copying files..."
cp -r "$SOURCE_DIR"/* "$TARGET_DIR"/

echo "✓ Copy completed successfully!"
echo "OpenCode configuration has been copied to $TARGET_DIR"
