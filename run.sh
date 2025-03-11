#!/bin/bash

# Define the ignore file
IGNORE_FILE=".stow-ignore"

# Read ignored directories from the ignore file if it exists
IGNORED_DIRS=()
if [[ -f "$IGNORE_FILE" ]]; then
    mapfile -t IGNORED_DIRS < "$IGNORE_FILE"
fi

# Find all directories in the current directory
ALL_DIRS=($(find . -maxdepth 1 -type d ! -name "." -exec basename {} \;))

# Filter out ignored directories
STOW_DIRS=()
for dir in "${ALL_DIRS[@]}"; do
    if [[ ! " ${IGNORED_DIRS[@]} " =~ " $dir " ]]; then
        STOW_DIRS+=("$dir")
    fi
done

# Run stow in dry-run mode for each valid directory
for dir in "${STOW_DIRS[@]}"; do
    echo "Running: stow -vv -t ~ $dir"
    stow -n -vv -t ~ "$dir"
done
