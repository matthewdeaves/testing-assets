#!/bin/bash

# Get the script's own filename
script_name=$(basename "$0")

# Prompt for the directory containing the images
read -p "Enter the full path to the directory containing images (press 'y' for current directory): " IMAGE_DIR

# Check if the user pressed 'y' and set the directory to the current directory
if [ "$IMAGE_DIR" = "y" ]; then
    IMAGE_DIR=$(pwd)
fi

# Check if the directory exists
if [ ! -d "$IMAGE_DIR" ]; then
    echo "Error: The directory '$IMAGE_DIR' does not exist."
    exit 1
fi

echo "Using directory: $IMAGE_DIR"

# Counter for image numbering
counter=1

# Loop through each file in the directory
for file in "$IMAGE_DIR"/*; do
    # Check if it's a file (not a directory) and not the script itself
    if [ -f "$file" ] && [ "$(basename "$file")" != "$script_name" ]; then
        # Get the file extension
        extension="${file##*.}"

        # Construct the new file name
        new_name="image-$counter.$extension"

        # Rename the file
        mv "$file" "$IMAGE_DIR/$new_name"

        # Increment the counter
        ((counter++))
    fi
done

echo "Renaming completed."
